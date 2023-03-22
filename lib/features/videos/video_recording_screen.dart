import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

enum MediaPermissionStatus {
  allowed,
  denied,
  requesting,
}

class VideoRecordingScreen extends StatefulWidget {
  static String routeName = "video_screen";
  static String routeUrl = "/";

  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  MediaPermissionStatus _hasPermission = MediaPermissionStatus.requesting;
  late CameraController _cameraController;
  bool _isSelfie = false;

  Future<void> initPermissions() async {
    setState(() {
      _hasPermission = MediaPermissionStatus.requesting;
    });
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      await initCamera();
      setState(() {
        _hasPermission = MediaPermissionStatus.allowed;
      });
      return;
    }

    setState(() {
      _hasPermission = MediaPermissionStatus.denied;
    });
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
        cameras[_isSelfie ? 1 : 0], ResolutionPreset.ultraHigh);
    await _cameraController.initialize();
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _onTapOpenAppSetting(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Open app setting"),
          content: const Text(
              "Please allow your camera & microphone permission if you want to proceed."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Don't allow"),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
              child: const Text("Allow"),
            ),
          ]),
    );
  }

  Future<void> _toggleSelfie() async {
    _isSelfie = !_isSelfie;
    await initCamera();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _hasPermission == MediaPermissionStatus.allowed
          ? _cameraController.value.isInitialized
              ? FractionallySizedBox(
                  widthFactor: 1,
                  child: Stack(
                    children: [
                      CameraPreview(_cameraController),
                      Positioned(
                        right: 0,
                        top: 20,
                        child: IconButton(
                          color: Colors.white,
                          onPressed: _toggleSelfie,
                          icon: const FaIcon(FontAwesomeIcons.cameraRotate),
                        ),
                      ),
                    ],
                  ),
                )
              : const SafeArea(
                  child: Center(
                    child: Text(
                      "Initializing camera...",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
          : _hasPermission == MediaPermissionStatus.requesting
              ? SafeArea(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Requesting permissions..",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            color: Colors.white,
                          ),
                        ),
                        Gaps.v20,
                        CircularProgressIndicator.adaptive(),
                      ],
                    ),
                  ),
                )
              : SafeArea(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Camera permission denied",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            color: Colors.white,
                          ),
                        ),
                        Gaps.v20,
                        TextButton(
                          onPressed: () {
                            _onTapOpenAppSetting(context);
                          },
                          child: const Text("Open app setting"),
                        ),
                        TextButton(
                          onPressed: () {
                            initPermissions();
                          },
                          child: const Text("Refresh permission"),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
