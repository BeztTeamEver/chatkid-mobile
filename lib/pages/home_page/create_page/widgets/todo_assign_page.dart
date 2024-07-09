import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/todo_home_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/routes/todo_create_route.dart';
import 'package:chatkid_mobile/pages/routes/todo_route.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/route.dart';
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

class _TodoAssignPageState extends ConsumerState<TodoAssignPage> {
  TodoFormCreateController todoFormCreateController = Get.find();
  List<int> _selectedIndex = [];

  onSubmit() async {
    try {
      if (todoFormCreateController.formKey.currentState!.saveAndValidate()) {
        final formState = todoFormCreateController.formKey.currentState!;
        // Assign for a member

        final value = TodoCreateModel.fromJson(formState.value);
        Logger().i(value.toJson());
        await TodoService().createTask(value);
        Get.offAll(MainPage());
        return;
      }
    } catch (e) {
      Logger().e(e);
    }
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
            name: "memberId",
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
                        final data = snapshot.data?.members.fold([],
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
                                isSelected: _selectedIndex.contains(index),
                                borderColor: primary.shade100,
                                hasBackground: true,
                                icon: icon,
                                label: data[index].name ?? "No name",
                                onPressed: () {
                                  // Multiple select
                                  // setState(() {
                                  //   if (_selectedIndex.contains(index)) {
                                  //     _selectedIndex.remove(index);
                                  //   } else {
                                  //     _selectedIndex.add(index);
                                  //   }
                                  // });
                                  _selectedIndex = [index];
                                  field.didChange(data[index].id);
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
        onPressed: () {
          onSubmit();
        },
        child: Text(
          "Xác nhận",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
