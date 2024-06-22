import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/widgets/category_item.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/providers/task_categories_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoCreatePage extends ConsumerStatefulWidget {
  const TodoCreatePage({super.key});

  @override
  ConsumerState<TodoCreatePage> createState() => _TodoCreatePageState();
}

class _TodoCreatePageState extends ConsumerState<TodoCreatePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TodoFormCreateController todoFormCreateController =
      Get.put(TodoFormCreateController());

  int pageNumber = 0;
  int pageSize = 100;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskCategories = ref
        .watch(getTaskCategoriesProvider(
                PagingModel(pageSize: pageSize, pageNumber: pageNumber))
            .future)
        .then((value) {
      todoFormCreateController.setTaskCategories(value);
      return value;
    });

    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                padding: const EdgeInsets.all(4),
                child: CustomTabbar(
                  tabs: ['Tất cả', "Đã ghim"],
                  onTabChange: (index) {
                    setState(() {
                      _tabController.animateTo(index);
                    });
                  },
                  tabController: _tabController,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: taskCategories,
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
                    final items = snapshot.data;
                    if (items == null || items.isEmpty) {
                      return const Center(
                        child: Text('Không có dữ liệu'),
                      );
                    }

                    return Obx(
                      () => ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 64),
                        scrollDirection: Axis.vertical,
                        itemCount:
                            todoFormCreateController.taskCategories.length,
                        itemBuilder: (context, index) {
                          final taskTypes = todoFormCreateController
                              .taskCategories[index].taskTypes
                              .fold<List<Widget>>(
                            [],
                            (previousValue, item) {
                              if (_tabController.index == 0 ||
                                  item.isFavorited == true) {
                                previousValue.add(
                                  CategoryItem(
                                    imageUrl: item.imageUrl ?? '',
                                    title: item.name,
                                    isFavorited: item.isFavorited ?? false,
                                    id: item.id,
                                    onTap: (id) {
                                      if (todoFormCreateController
                                          .isEdit.value) {
                                        todoFormCreateController
                                            .toggleFavoriteTaskType(
                                                index, item);
                                      } else {
                                        if (todoFormCreateController
                                                .step.value ==
                                            4) {
                                          todoFormCreateController
                                              .decreaseStep();
                                        } else {
                                          todoFormCreateController
                                              .increaseStep();
                                        }
                                        todoFormCreateController.updateProgress(
                                          todoFormCreateController.step.value,
                                        );
                                        // _stepController.animateTo(
                                        //     todoFormCreateController.step / 4);
                                      }
                                    },
                                    taskCategoriesIndex: index,
                                    taskTypeIndex: todoFormCreateController
                                        .taskCategories[index].taskTypes
                                        .indexOf(item),
                                    taskType: item,
                                  ),
                                );
                              }
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
                                  todoFormCreateController
                                      .taskCategories[index].name,
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
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AnimatedContainer(
          width: todoFormCreateController.isEdit.value ? 220 : 0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastEaseInToSlowEaseOut,
          child: FullWidthButton(
            width: 220,
            onPressed: () {},
            child: Text(
              'Lưu',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
