import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/features/videos/widgets/flash_mode.dart';

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

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  MediaPermissionStatus _hasPermission = MediaPermissionStatus.requesting;
  late CameraController _cameraController;
  bool _isSelfie = false;
  late final _buttonAnimationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);
  late final _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
      upperBound: 1.0,
      lowerBound: 0.0);

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
    await _cameraController.prepareForVideoRecording();
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
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

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) {
      return;
    }
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
    setState(() {});
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) {
      return;
    }
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    try {
      final videoFile = await _cameraController.stopVideoRecording();
      print(videoFile.path);
      print(videoFile.name);
    } on CameraException catch (_, e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  Future<void> _toggleSelfie() async {
    _isSelfie = !_isSelfie;
    await initCamera();
    print("tapped");
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
                    alignment: Alignment.center,
                    children: [
                      CameraPreview(_cameraController),
                      Positioned(
                        right: 0,
                        top: 40,
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: _toggleSelfie,
                              icon: const FaIcon(FontAwesomeIcons.cameraRotate),
                            ),
                            Gaps.v10,
                            FlashModeWidget(
                                cameraController: _cameraController),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: Sizes.size28,
                        child: GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (_) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size72,
                                  height: Sizes.size72,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size8,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size60,
                                  height: Sizes.size60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
