import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/create_task_type_page/create_task_type_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/create_task_type_page/task_type_image_item.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/widgets/category_item.dart';
import 'package:chatkid_mobile/providers/task_categories_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TaskTypeIcon extends ConsumerStatefulWidget {
  const TaskTypeIcon({super.key});

  @override
  ConsumerState<TaskTypeIcon> createState() => _TaskTypeIconState();
}

class _TaskTypeIconState extends ConsumerState<TaskTypeIcon> {
  bool pop = false;
  @override
  Widget build(BuildContext context) {
    final taskImages = ref.watch(getTaskImageProvider.future);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Container(
          padding: const EdgeInsets.all(8),
          child: SecondaryButton(
            child: SvgIcon(
              icon: 'chevron-left',
              color: primary.shade500,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          'Chọn hình minh họa',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: FutureBuilder(
          future: taskImages,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Đã có lỗi xảy ra, vui lòng thử lại'),
              );
            }
            final data = snapshot.data;
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  if (data![index].name == 'Công việc tùy chỉnh') {
                    return Container();
                  }
                  final taskTypes = data[index].taskType.fold(<Widget>[],
                      (previousValue, element) {
                    previousValue.add(TaskTypeImageItem(
                      onTap: (value) async {
                        // Navigator.pop(context);
                        await Navigator.push(
                          context,
                          createRoute(
                            () => CreateTaskTypePage(
                              TaskCategoryId: data[index].id,
                              taskType: element,
                            ),
                          ),
                        ).then(
                          (value) {
                            if (value != null) {
                              Get.back(result: true);
                            }
                          },
                        );
                      },
                      imageUrl: element.imageUrl,
                      taskType: element,
                      title: element.name,
                      isSelected: false,
                    ));
                    return previousValue;
                  });
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data![index].name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 10,
                        children: taskTypes,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
