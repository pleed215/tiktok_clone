import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();
export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    await snapshot.ref.update({ hello: "from functions" });
    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();
    const destPath = `/tmp/${snapshot.id}.jpg`;
    await spawn("ffmpeg", [
      "-i",
      video.fileUrl,
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      destPath,
    ]);
    const storage = admin.storage();
    const [uploaded, _] = await storage.bucket().upload(destPath, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });

    await uploaded.makePublic();
    await snapshot.ref.update({
      thumbnailUrl: uploaded.publicUrl(),
    });

    const db = admin.firestore();
    await db
      .collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({ thumbnailUrl: uploaded.publicUrl(), videoId: snapshot.id });
  });

export const onLikedCreated = functions.firestore
  .document("likes/{likeId}")
  .onCreate(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({ likes: admin.firestore.FieldValue.increment(1) });
    const video = await (
      await db.collection("videos").doc(videoId).get()
    ).data();
    if (video) {
      const creatorId = video["creatorUid"];
      const user = await (
        await db.collection("users").doc(creatorId).get()
      ).data();
      if (user) {
        const token = user["token"];
        await admin.messaging().sendToDevice(token, {
          data: {
            screen: "123",
          },
          notification: {
            tile: "Someone liked your video",
            body: "Likes + 1, Congratulation!",
          },
        });
      }
    }
  });

export const onLikeDeleted = functions.firestore
  .document("likes/{likeId}")
  .onDelete(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({ likes: admin.firestore.FieldValue.increment(-1) });
  });

export const onChatRoomCreated = functions.firestore
  .document("chat_rooms/{chatroomId}")
  .onCreate(async (snapshot, context) => {
    const db = admin.firestore();
    const userIds = snapshot.data().userIds as string[];
    const [[firstId, firstName], [secondId, secondName]] = userIds.map(
      (idAndName) => idAndName.split("___")
    );

    await db
      .collection("users")
      .doc(firstId)
      .collection("chat_rooms")
      .doc()
      .create({
        chatRoomId: snapshot.id,
        partnerId: secondId,
        partnerName: secondName,
      });
    await db
      .collection("users")
      .doc(secondId)
      .collection("chat_rooms")
      .doc()
      .create({
        chatRoomId: snapshot.id,
        partnerId: firstId,
        partnerName: firstName,
      });
  });

export const onChatRoomDeleted = functions.firestore
  .document("chat_rooms/{chatroomId")
  .onDelete((snapshot, context) => {
    {
      const db = admin.firestore();
      const userIds = snapshot.data().userIds as string[];
      const [[firstId], [secondId]] = userIds.map((idAndName) =>
        idAndName.split("___")
      );

      db.collection("users")
        .doc(firstId)
        .collection("chat_rooms")
        .where("chatRoomId", "==", snapshot.id)
        .get()
        .then((docs) => docs.forEach((doc) => doc.ref.delete()));
      db.collection("users")
        .doc(secondId)
        .collection("chat_rooms")
        .where("chatRoomId", "==", snapshot.id)
        .get()
        .then((docs) => docs.forEach((doc) => doc.ref.delete()));
    }
  });
