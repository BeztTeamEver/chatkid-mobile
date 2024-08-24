import 'package:chatkid_mobile/enum/todo.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/widgets/category_create_item.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/widgets/category_item.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_form_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/todo_page/todo_form_page.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/pages/routes/target_create_route.dart';
import 'package:chatkid_mobile/providers/task_categories_provider.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/confirmation/confirm_modal.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';
import 'package:modals/modals.dart';

class TodoCreatePage extends ConsumerStatefulWidget {
  const TodoCreatePage({super.key});

  @override
  ConsumerState<TodoCreatePage> createState() => _TodoCreatePageState();
}

class _TodoCreatePageState extends ConsumerState<TodoCreatePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TodoFormCreateController todoFormCreateController = Get.find();
  late final AnimationController _controller;
  late final Animation<Offset> _offsetFloat;

  bool _isSaving = false;
  int pageNumber = 0;
  int pageSize = 100;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _offsetFloat = Tween(begin: Offset(0.0, -0.03), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _offsetFloat.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    _offsetFloat.removeListener(() {});
    super.dispose();
  }

  handleDeleteTaskType() {
    showDialog(
      context: context,
      builder: (context) => ConfirmModal(
          isLoading: _isSaving,
          title: "Bạn có chắc là muốn xóa loại công việc này không",
          content:
              "Xóa loại công việc sẽ xóa toàn bộ công việc thuộc loại công việc này",
          onCancel: () {},
          onConfirm: () async {
            setState(() {
              _isSaving = true;
            });
            await todoFormCreateController.deleteTaskType().whenComplete(
              () {
                setState(() {
                  _isSaving = false;
                });
                todoFormCreateController.toggleDelete();
                ref
                    .refresh(getTaskCategoriesProvider(PagingModel(
                            pageSize: pageSize, pageNumber: pageNumber))
                        .future)
                    .then((value) {
                  todoFormCreateController.setTaskCategories(value);
                  return value;
                });
              },
            );
          }),
    );
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: todoFormCreateController.isEdit.value ||
                      todoFormCreateController.isDelete.value
                  ? 0
                  : 48,
              curve: Curves.easeIn,
              transform: Matrix4.translationValues(
                  0,
                  !todoFormCreateController.isEdit.value ||
                          todoFormCreateController.isDelete.value
                      ? 0
                      : -64,
                  0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
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
                      if (index == 1 && todoFormCreateController.isEdit.value) {
                        todoFormCreateController.toggleEdit();
                      }
                      setState(() {
                        _tabController.animateTo(index);
                      });
                    },
                    tabController: _tabController,
                  ),
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
                                  Obx(
                                    () => CategoryItem(
                                      imageUrl: item.imageUrl ?? '',
                                      title: item.name,
                                      isFavorited: item.isFavorited ?? false,
                                      id: item.id,
                                      isSelected: (!todoFormCreateController
                                                  .isDelete.value &&
                                              todoFormCreateController
                                                  .selectedTaskType
                                                  .contains(item.id)) ||
                                          todoFormCreateController
                                              .selectedDeletingTaskTypeId
                                              .contains(item.id),
                                      onLongPress: () {
                                        if (_tabController.index == 0) {
                                          todoFormCreateController.toggleEdit();
                                        }
                                      },
                                      onTap: (id) {
                                        if (todoFormCreateController
                                            .isDelete.value) {
                                          todoFormCreateController
                                              .setSelectedDeletingTaskTypeId(
                                                  id);
                                          return;
                                        }

                                        if (todoFormCreateController
                                            .isEdit.value) {
                                          todoFormCreateController
                                              .toggleFavoriteTaskType(
                                                  index, item);
                                        } else {
                                          todoFormCreateController
                                              .setSelectedTaskType(item.id);
                                          todoFormCreateController
                                              .increaseStep();
                                          todoFormCreateController
                                              .updateProgress();
                                          Navigator.of(context).push(
                                            createRoute(() => TodoFormPage()),
                                          );
                                        }
                                      },
                                      taskCategoriesIndex: index,
                                      taskTypeIndex: todoFormCreateController
                                          .taskCategories[index].taskTypes
                                          .indexOf(item),
                                      taskType: item,
                                    ),
                                  ),
                                );
                              }
                              return previousValue;
                            },
                          );

                          if (index == 0 && _tabController.index == 0) {
                            taskTypes.insert(0,
                                CategoryCreateItem(onTap: (value) {
                              if (value) {
                                ref
                                    .refresh(getTaskCategoriesProvider(
                                            PagingModel(
                                                pageSize: pageSize,
                                                pageNumber: pageNumber))
                                        .future)
                                    .then((value) {
                                  todoFormCreateController
                                      .setTaskCategories(value);
                                  return value;
                                });
                              }
                            }));
                          }
                          if (taskTypes.isEmpty) {
                            return const SizedBox();
                          }
                          return Obx(
                            () => todoFormCreateController.isDelete.value &&
                                    todoFormCreateController
                                            .taskCategories[index].name !=
                                        'Công việc tùy chỉnh'
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          direction: Axis.horizontal,
                                          spacing: 24,
                                          runSpacing: 12,
                                          children: taskTypes,
                                        ),
                                      ],
                                    ),
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
        floatingActionButton: SlideTransition(
          position: todoFormCreateController.isEdit.value ||
                  todoFormCreateController.isDelete.value
              ? _offsetFloat
              : _offsetFloat,
          child: AnimatedContainer(
            width: todoFormCreateController.isEdit.value ||
                    todoFormCreateController.isDelete.value
                ? 320
                : 0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastEaseInToSlowEaseOut,
            child: FullWidthButton(
              onPressed: () async {
                if (todoFormCreateController.isDelete.value) {
                  handleDeleteTaskType();
                  return;
                }
                setState(() {
                  _isSaving = true;
                });
                await todoFormCreateController.saveTask().whenComplete(() {
                  setState(() {
                    _isSaving = false;
                  });
                });
              },
              isDisabled: _isSaving ||
                  (todoFormCreateController
                          .selectedDeletingTaskTypeId.value.isEmpty &&
                      todoFormCreateController.isDelete.value),
              child: !_isSaving
                  ? Text(
                      todoFormCreateController.isDelete.value ? "Xóa" : 'Lưu',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    )
                  : Container(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
