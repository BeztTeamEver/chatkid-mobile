import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_detail_store.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/camera_service.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class CaptureEvidence extends StatefulWidget {
  const CaptureEvidence({super.key});

  @override
  State<CaptureEvidence> createState() => _CaptureEvidenceState();
}

class _CaptureEvidenceState extends State<CaptureEvidence> {
  final TodoFeedbackStore todoFeedbackStore = Get.find();
  late final CameraController _controller;
  final camera = CameraService().getCamera();
  late Future<void> _initializeControllerFuture;

  String currentImage = "";
  bool isCapturing = false;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(camera, ResolutionPreset.max);
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    todoFeedbackStore.setIsCaptured(false);
    super.dispose();
  }

  Future<void> _takePicture() async {
    setState(() {
      isCapturing = true;
    });
    try {
      await _controller.pausePreview();
      todoFeedbackStore.setIsCaptured(true);
      final image = await _controller.takePicture();
      setState(() {
        currentImage = image.path;
      });
      todoFeedbackStore.formKey.currentState!.fields['evidence']!
          .didChange(currentImage);
    } catch (e) {
      Logger().e(e);
    } finally {
      setState(() {
        isCapturing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - 80,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    child: CameraPreview(
                      _controller,
                      child: todoFeedbackStore.isCaptured && !isCapturing
                          ? Image.file(File(currentImage))
                          : null,
                    ),
                  ),
                  Positioned(
                      bottom: 80,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Obx(
                          () => todoFeedbackStore.isCaptured
                              ? Container()
                              : ElevatedButton(
                                  onPressed: () {
                                    _takePicture();
                                  },
                                  child: Text(""),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(
                                            color: primary.shade500, width: 8),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(20),
                                    ),
                                  ),
                                ),
                        ),
                      ))
                ],
              );
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
