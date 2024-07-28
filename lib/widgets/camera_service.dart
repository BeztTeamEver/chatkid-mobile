import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  static CameraService _instance = CameraService._internal();
  List<CameraDescription> cameras = <CameraDescription>[];

  factory CameraService() {
    if (_instance == null) {
      _instance = CameraService._internal();
    }
    return _instance;
  }

  CameraService._internal();

  void takePicture() {
    print('Take picture');
  }

  Future<void> init() async {
    cameras = await availableCameras();
  }

  CameraDescription getCamera() {
    return cameras.first;
  }
}
