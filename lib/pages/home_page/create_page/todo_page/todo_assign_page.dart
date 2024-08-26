import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/widgets/todo_overlap_modal.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoAssignPage extends ConsumerStatefulWidget {
  const TodoAssignPage({super.key});

  @override
  ConsumerState<TodoAssignPage> createState() => _TodoAssignPageState();
}

class _TodoAssignPageState extends ConsumerState<TodoAssignPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  TodoFormCreateController todoFormCreateController = Get.find();
  List<String> _selectedIndex = [];

  bool isLoading = false;

  handleSubmitData(value) async {
    await TodoService().createTask(value);
    Get.delete<TodoFormCreateController>();
    // Get.delete<TodoHomeStore>();

    Get.offAll(() => MainPage(), predicate: (route) => false);
  }

  onSubmit() async {
    try {
      if (_selectedIndex.isEmpty) {
        ShowToast.error(msg: "Vui lòng chọn thành viên");
        return;
      }
      setState(() {
        isLoading = true;
      });
      if (todoFormCreateController.formKey.currentState!.saveAndValidate()) {
        final formState = todoFormCreateController.formKey.currentState!;

        // Assign for a member
        final value = TodoCreateModel.fromJson({
          ...formState.value,
          'numberOfCoin': int.parse(formState.value['numberOfCoin']),
          'frequency': <String?>[],
          "memberIds": _selectedIndex,
        });

        final overlapUsers = await TodoService().checkOverlapTask(value);
        if (overlapUsers != null && overlapUsers.isNotEmpty) {
          setState(() {
            isLoading = false;
          });
          if (mounted) {
            await showModalBottomSheet(
                context: context,
                enableDrag: true,
                showDragHandle: true,
                backgroundColor: Theme.of(context).colorScheme.background,
                transitionAnimationController: _controller,
                isScrollControlled: true,
                useSafeArea: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 180,
                ),
                builder: (context) {
                  bool isFull = true;
                  for (var i = 0; i < _selectedIndex.length; i++) {
                    final user = overlapUsers.firstWhereOrNull(
                        (element) => element.id == _selectedIndex[i]);
                    if (user == null) {
                      isFull = false;
                      break;
                    }
                  }
                  return TodoOverlapModal(
                      isFull: isFull,
                      onConfirm: () async {
                        final users = _selectedIndex.fold(<String>[],
                            (previousValue, element) {
                          if (overlapUsers.firstWhereOrNull(
                                  (element2) => element2.id == element) ==
                              null) {
                            previousValue.add(element);
                          }

                          return previousValue;
                        });
                        value.memberIds = users;

                        await handleSubmitData(value);
                      },
                      endTime: value.endTime,
                      users: overlapUsers,
                      startTime: value.startTime);
                });

            return;
          }
        }
        await handleSubmitData(value);
        // // todoFormCreateController.navigatorKey.currentState!.pop();
        // return;
      }
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      ShowToast.error(msg: "Có lỗi xảy ra");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final familyUsers = ref.watch(getOwnFamily.future).then((value) {
      return value;
    });

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(14),
        child: FormBuilderField(
            name: "memberIds",
            builder: (field) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thành viên làm công việc",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder(
                      future: familyUsers,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final data = snapshot.data?.members.fold(<UserModel>[],
                            (previousValue, element) {
                          if (element.role == RoleConstant.Child)
                            previousValue.add(element);
                          return previousValue;
                        });

                        if (data == null) {
                          return Center(
                            child: Text('Không có dữ liệu'),
                          );
                        }
                        return ListView.separated(
                          padding: EdgeInsets.only(bottom: 64),
                          itemCount: data.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final icon = data[index].avatarUrl != null &&
                                    data[index].avatarUrl != ""
                                ? data[index].avatarUrl
                                : iconAnimalList[0];
                            return SizedBox(
                              width: double.infinity,
                              child: SelectButton(
                                isSelected:
                                    _selectedIndex.contains(data[index].id),
                                borderColor: primary.shade100,
                                hasBackground: true,
                                icon: icon,
                                label: data[index].name ?? "No name",
                                onPressed: () {
                                  // Multiple select
                                  setState(() {
                                    if (_selectedIndex
                                        .contains(data[index].id)) {
                                      _selectedIndex.remove(data[index].id!);
                                    } else {
                                      _selectedIndex.add(data[index].id!);
                                    }
                                  });
                                  // _selectedIndex = [index];
                                  // field.didChange(data[index].id);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FullWidthButton(
        isLoading: isLoading,
        onPressed: () {
          onSubmit();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const CustomCircleProgressIndicator()
                : const SizedBox(),
            isLoading ? const SizedBox(width: 10) : const SizedBox(),
            Text(
              "Xác nhận",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
