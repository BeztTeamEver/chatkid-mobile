import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/target_category_item.dart';
import 'package:chatkid_mobile/providers/task_categories_provider.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddMissionPage extends ConsumerStatefulWidget {
  const AddMissionPage({super.key});

  @override
  ConsumerState<AddMissionPage> createState() => _AddMissionPageState();
}

class _AddMissionPageState extends ConsumerState<AddMissionPage> {
  final TargetFormStore targetFormStore = Get.find();

  @override
  Widget build(BuildContext context) {
    final taskCategoriesFuture = ref
        .watch(
            getTaskCategoriesProvider(PagingModel(pageSize: 100, pageNumber: 0))
                .future)
        .then((value) {
      return value;
    });
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: taskCategoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Logger().e(snapshot.error);
                return const Center(
                  child: const Text('Đã xảy ra lỗi, vui lòng thử lại sau!'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final taskCategories = snapshot.data!;
                final items = snapshot.data;
                if (items == null || items.isEmpty) {
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 64),
                  scrollDirection: Axis.vertical,
                  itemCount: taskCategories.length,
                  itemBuilder: (context, index) {
                    final taskTypes =
                        taskCategories[index].taskTypes.fold<List<Widget>>(
                      [],
                      (previousValue, item) {
                        if (!taskCategories[index].taskTypes.contains(item)) {
                          return previousValue;
                        }
                        previousValue.add(
                          TargetCategoryItem(
                            imageUrl: item.imageUrl ?? '',
                            title: item.name,
                            taskCategoriesIndex: index,
                            taskType: item,
                            isSelected:
                                targetFormStore.missions.contains(item.id),
                            taskTypeIndex:
                                taskCategories[index].taskTypes.indexOf(item),
                            isFavorited: item.isFavorited ?? false,
                            id: item.id,
                            onLongPress: () {},
                            onTap: (id) {
                              if (targetFormStore.missions.contains(id)) {
                                ShowToast.error(
                                    msg: 'Công việc này đã được thêm');
                                return;
                              }
                              targetFormStore.addListMission(id);
                              Navigator.pop(context);
                            },
                          ),
                        );
                        return previousValue;
                      },
                    );
                    if (taskTypes.isEmpty) {
                      return const SizedBox();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            taskCategories[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontSize: 18,
                                  letterSpacing: 0.1,
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            spacing: 24,
                            runSpacing: 12,
                            children: taskTypes,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ]),
    );
  }
}
