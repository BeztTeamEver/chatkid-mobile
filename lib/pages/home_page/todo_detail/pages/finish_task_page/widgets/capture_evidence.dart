import 'package:camera/camera.dart';
import 'package:chatkid_mobile/widgets/camera_service.dart';
import 'package:flutter/material.dart';

class CaptureEvidence extends StatefulWidget {
  const CaptureEvidence({super.key});

  @override
  State<CaptureEvidence> createState() => _CaptureEvidenceState();
}

class _CaptureEvidenceState extends State<CaptureEvidence> {
  late final CameraController _controller;
  final camera = CameraService().getCamera();
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
