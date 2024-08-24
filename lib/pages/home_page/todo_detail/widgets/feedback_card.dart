import 'dart:ui';

import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/todo_detail.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:get/get.dart';

class FeedBackCard extends StatefulWidget {
  final TaskModel task;

  const FeedBackCard({super.key, required this.task});

  @override
  State<FeedBackCard> createState() => _FeedBackCardState();
}

class _FeedBackCardState extends State<FeedBackCard> {
  late VideoPlayerController _videoController;
  final TodoHomeStore todoHomeStore = Get.find();
  String thumbnail = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget
            .task.evidence ??
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"))
      ..initialize().then((value) {
        setState(() {});
      });
  }

  onAccept() async {
    final result = await TodoService()
        .updateTaskStatus(widget.task.id, TodoStatus.completed);

    todoHomeStore.updateTaskStatus(
        widget.task.id, TodoStatus.pending, TodoStatus.completed);
  }

  onReject() async {
    final result = await TodoService()
        .updateTaskStatus(widget.task.id, TodoStatus.notCompleted);
    todoHomeStore.updateTaskStatus(
        widget.task.id, TodoStatus.pending, TodoStatus.notCompleted);
  }

  // getThumbnail() async {
  //   final tempDir = await getTemporaryDirectory();
  //   final fileName = await VideoThumbnail.thumbnailFile(
  //     video: widget.task.evidence ??
  //         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  //     thumbnailPath: tempDir.path + "/tmp.png",
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight:
  //         80, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //     quality: 40,
  //   ).catchError((e) {
  //     Logger().e(e);
  //   });
  //   if (mounted) {
  //     setState(() {
  //       thumbnail = fileName ?? "";
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getThumbnail();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(16),
      children: [
        // ChatTextBox(
        //   isSender: false,
        //   user: todoHomeStore.currentUser.value,
        //   useVoice: false,
        //   message:
        //       'Công việc ${FeedbackMap[widget.task.feedbackLevel]?.toLowerCase() ?? ""}',
        // ),
        // SizedBox(height: 16),
        ChatTextBox(
          isSender: false,
          user: todoHomeStore.currentUser.value,
          useVoice: false,
          imageUrl:
              widget.task.feedbackEmoji ?? "https://picsum.photos/200/200",
        ),
        SizedBox(height: 16),
        // ChatTextBox(
        //   isSender: false,
        //   user: todoHomeStore.currentUser.value,
        //   voiceUrl: widget.task.feedbackVoice,
        // ),
        SizedBox(height: 16),
        // Image.network(
        //   widget.task.evidence ?? "https://picsum.photos/200/200",
        //   fit: BoxFit.cover,
        //   height: 400,
        // ),
        _videoController.value.isInitialized
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    child: AvatarPng(
                      imageUrl: todoHomeStore.currentUser.value.avatarUrl,
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(VideoPreviewModal(
                          videoUrl: widget.task.evidence ??
                              "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          child: Container(
                            height: 180,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              shape: BoxShape.rectangle,
                            ),
                            child: AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 180,
                            width: 100,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Icon(Icons.play_arrow,
                              size: 32, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                width: 24,
                height: 24,
                child: CustomCircleProgressIndicator(),
              ),
        widget.task.status == TodoStatus.pending
            ? ActionButtons(
                onCancel: onReject,
                onConfirm: onAccept,
              )
            : Container(),
      ],
    );
  }
}

class VideoPreviewModal extends StatefulWidget {
  final videoUrl;
  const VideoPreviewModal({super.key, this.videoUrl});

  @override
  State<VideoPreviewModal> createState() => _VideoPreviewModalState();
}

class _VideoPreviewModalState extends State<VideoPreviewModal>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..addListener(() {
            setState(() {});
          })
          ..initialize().then((value) {
            setState(() {});
          });
    _videoController.addListener(() {
      setState(() {});
    });
  }

  void resetVideo() {
    _videoController.seekTo(Duration.zero);
    // _playProgressController.reset();
  }

  void playVideo() async {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        // _playProgressController.stop();
      } else {
        if (_videoController.value.isCompleted) {
          resetVideo();
        }
        _videoController.play();
        // _playProgressController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: 320),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.videoUrl,
                child: _videoController.value.isInitialized
                    ? Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            child: AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            ),
                          ),
                          Positioned(
                            child: VideoProgressIndicator(
                              _videoController,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                playedColor: primary.shade500,
                                bufferedColor: primary.shade100,
                                backgroundColor: primary.shade50,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        width: 48,
                        height: 48,
                        child: CustomCircleProgressIndicator(
                          color: primary.shade500,
                        ),
                      ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    child: ElevatedButton(
                      onPressed: resetVideo,
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      child: Icon(
                        Icons.replay,
                        color: primary.shade500,
                        size: 32,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 68,
                    height: 68,
                    child: ElevatedButton(
                      onPressed: playVideo,
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      child: Icon(
                        _videoController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: primary.shade500,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
