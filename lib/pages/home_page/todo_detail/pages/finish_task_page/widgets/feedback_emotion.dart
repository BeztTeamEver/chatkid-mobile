import 'package:chatkid_mobile/constants/feedback_page.dart';
import 'package:chatkid_mobile/providers/todo_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedBackEmotion extends ConsumerStatefulWidget {
  const FeedBackEmotion({super.key});

  @override
  ConsumerState<FeedBackEmotion> createState() => _FeedBackEmotionState();
}

class _FeedBackEmotionState extends ConsumerState<FeedBackEmotion> {
  final user = LocalStorage.instance.getUser();

  @override
  Widget build(BuildContext context) {
    final emojis = ref.watch(getTaskEmoji.future);
    return FutureBuilder(
      future: emojis,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Đã xảy ra lỗi, vui lòng thử lại sau'),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text('Không có dữ liệu'),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: FormBuilderField(
            name: 'emoji',
            builder: (field) {
              return Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        field.didChange(snapshot.data![index].name);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: field.value == snapshot.data![index].name
                                ? primary.shade500
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          snapshot.data![index].url,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
