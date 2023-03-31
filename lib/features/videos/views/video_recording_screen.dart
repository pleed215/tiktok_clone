import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/features/videos/views/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/flash_mode.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

enum MediaPermissionStatus {
  allowed,
  denied,
  requesting,
}

class VideoRecordingScreen extends StatefulWidget {
  static String routeName = "records";
  static String routeUrl = "/records";

  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
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
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  bool _isAppInactive = false;
  double _maximumZoomLevel = 0.0;
  double _currentZoomLevel = 1.0;
  final double _zoomStep = 0.05;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera || _hasPermission != MediaPermissionStatus.allowed) return;

    try {
      if (!_cameraController.value.isInitialized) {
        return;
      }

      if (state == AppLifecycleState.inactive) {
        _isAppInactive = true;
        await _cameraController.dispose();
      } else if (state == AppLifecycleState.resumed) {
        _isAppInactive = false;
        await initCamera();
      }
    } on CameraException catch (_, e) {
      setState(() {});
    }
  }

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
      cameras[_isSelfie ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();
    _maximumZoomLevel = await _cameraController.getMaxZoomLevel();
    _currentZoomLevel = 1.0;
    await _cameraController.setZoomLevel(1.0);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = MediaPermissionStatus.allowed;
      });
    }
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
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    if (!_noCamera) _cameraController.dispose();
    WidgetsBinding.instance.removeObserver(this);
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

  void _onPanUpdateCameraButton(DragUpdateDetails details) {
    if (_noCamera) return;
    if (details.delta.dy < 0 && _currentZoomLevel < _maximumZoomLevel) {
      _currentZoomLevel += _zoomStep;
    } else if (details.delta.dy > 0 && _currentZoomLevel > 1.0) {
      _currentZoomLevel -= _zoomStep;
    }
    _currentZoomLevel = _currentZoomLevel.clamp(1.0, _maximumZoomLevel);
    _cameraController.setZoomLevel(_currentZoomLevel);
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_noCamera || _cameraController.value.isRecordingVideo) {
      return;
    }
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
    setState(() {});
  }

  Future<void> _stopRecording() async {
    if (_noCamera || !_cameraController.value.isRecordingVideo) {
      return;
    }
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    try {
      final videoFile = await _cameraController.stopVideoRecording();
      if (!mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPreviewScreen(
              video: videoFile,
              isPicked: false,
            ),
          ));
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

  Future<void> _onTapPickVideo() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) {
      return;
    }
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _hasPermission == MediaPermissionStatus.allowed
          ? !_isAppInactive
              ? FractionallySizedBox(
                  widthFactor: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!_noCamera) CameraPreview(_cameraController),
                      const Positioned(
                        top: 0,
                        left: 0,
                        child: SafeArea(child: CloseButton()),
                      ),
                      if (!_noCamera)
                        Positioned(
                          right: 0,
                          top: 40,
                          child: Column(
                            children: [
                              IconButton(
                                color: Colors.white,
                                onPressed: _toggleSelfie,
                                icon:
                                    const FaIcon(FontAwesomeIcons.cameraRotate),
                              ),
                              Gaps.v10,
                              FlashModeWidget(
                                  cameraController: _cameraController),
                            ],
                          ),
                        ),
                      Positioned(
                        bottom: Sizes.size28,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onPanUpdate: _onPanUpdateCameraButton,
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
                                        value:
                                            _progressAnimationController.value,
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
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: _onTapPickVideo,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.image,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
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
