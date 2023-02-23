import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class VideoCommentModal extends StatefulWidget {
  const VideoCommentModal({Key? key}) : super(key: key);

  @override
  State<VideoCommentModal> createState() => _VideoCommentModalState();
}

class _VideoCommentModalState extends State<VideoCommentModal> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  void _onTapClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  bool _isDirty = false;

  void _onTapBody(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit(BuildContext context) {
    _textController.clear();
    setState(() {
      _isDirty = false;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(Sizes.size10)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text("22796 comments"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => _onTapClose(context),
              icon: const FaIcon(FontAwesomeIcons.x),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () => _onTapBody(context),
          child: Stack(children: [
            Scrollbar(
              controller: _scrollController,
              child: ListView.separated(
                controller: _scrollController,
                itemCount: 10,
                padding: const EdgeInsets.only(
                  left: Sizes.size16,
                  right: Sizes.size16,
                  top: Sizes.size16,
                  bottom: Sizes.size16 + Sizes.size96,
                ),
                separatorBuilder: (context, index) => Gaps.v20,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(radius: 18, child: Text("Hr")),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Haru',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w400,
                                fontSize: Sizes.size14,
                              ),
                            ),
                            Gaps.v4,
                            const Text(
                              "That's not it l've seen the same thing but also in a cave",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Gaps.h8,
                      VideoButton(
                        icon: FontAwesomeIcons.heart,
                        text: '52.2K',
                        color: Colors.grey.shade500,
                        iconSize: Sizes.size24,
                        fontSize: Sizes.size14,
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              height: Sizes.size96,
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size20,
                    vertical: Sizes.size8,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                        child: const Text('Hr'),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size48,
                          child: TextField(
                            controller: _textController,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.newline,
                            onChanged: (value) => setState(() {
                              _isDirty = value.isNotEmpty;
                            }),
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "Write a comment...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        right: Sizes.size14),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FaIcon(FontAwesomeIcons.at,
                                              color: Colors.grey.shade800),
                                          Gaps.h12,
                                          FaIcon(FontAwesomeIcons.gift,
                                              color: Colors.grey.shade800),
                                          Gaps.h12,
                                          FaIcon(FontAwesomeIcons.faceSmile,
                                              color: Colors.grey.shade800),
                                          if (_isDirty)
                                            Row(
                                              children: [
                                                Gaps.h12,
                                                GestureDetector(
                                                  onTap: () =>
                                                      _onSubmit(context),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .solidPaperPlane,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ])),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size20,
                                  vertical: Sizes.size12,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
