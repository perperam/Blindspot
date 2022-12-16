import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:blindspot/screens/screen_image_previewer.dart';
import 'package:blindspot/config/config_colors.dart';

//forked on https://medium.com/@fernnandoptr/how-to-use-camera-in-flutter-flutter-camera-package-44defe81d2da)

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key, required this.cameras, required this.callback}) : super(key: key);
  final List<CameraDescription>? cameras;
  final Function callback;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  Future takePicture() async {
    final NavigatorState navigator = Navigator.of(context);

    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();

      navigator.push(
          MaterialPageRoute(
              builder: (_) {
                return PreviewPage(picture: picture);
              },
              settings:
              const RouteSettings(name: 'CameraScreen')));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.Background,
        body: SafeArea(
          child: Column(children: [
            Expanded(child:
              (_cameraController.value.isInitialized)
              ? CameraPreview(_cameraController)
              : Container(
                color: CustomColors.Background,
                child: const Center(child: CircularProgressIndicator())
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(color: Colors.grey.shade800), // Color Problem
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 30,
                          icon: Icon(
                            _isRearCameraSelected
                            ? Icons.switch_camera
                            : Icons.switch_camera,
                            color: CustomColors.Text),
                          onPressed: () {
                            setState(
                              () => _isRearCameraSelected = !_isRearCameraSelected);
                              initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                              },
                        )
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: takePicture,
                          iconSize: 50,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.circle, color: Colors.black87), // Color Problem
                        )
                      ),
                      const Spacer(),
                    ]
                ),
              )
            ),
          ]
          ),
        )
    );
  }
}
