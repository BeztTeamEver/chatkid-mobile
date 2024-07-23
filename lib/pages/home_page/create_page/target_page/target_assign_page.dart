import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/target_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TargetAssignPage extends ConsumerStatefulWidget {
  const TargetAssignPage({super.key});

  @override
  ConsumerState<TargetAssignPage> createState() => _TargetAssignPageState();
}

class _TargetAssignPageState extends ConsumerState<TargetAssignPage> {
  TargetFormStore targetFormStore = Get.find();
  bool isSubmitting = false;
  List<String> _selectedMember = [];

  toggleSubmit(bool isSubmitting) {
    setState(() {
      this.isSubmitting = isSubmitting;
    });
  }

  onSubmit() async {
    try {
      toggleSubmit(true);
      if (targetFormStore.formKey.currentState!.saveAndValidate()) {
        final formState = targetFormStore.formKey.currentState!;
        // Assign for a member
        if (_selectedMember.isEmpty) {
          ShowToast.error(msg: "Vui lòng chọn thành viên");
        }

        final value = formState.value;

        await TargetService().createTarget(TargetRequestModal.fromJson({
          ...value,
          "memberIds": _selectedMember,
        }));

        Get.offAll(() => const MainPage());
        return;
      }
    } catch (e) {
      Logger().e(e);
      final errorMessage =
          e.toString().split(":")[e.toString().split(":").length - 1].trim();
      ShowToast.error(msg: errorMessage);
    } finally {
      toggleSubmit(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final familyUsers = ref.watch(getOwnFamily.future).then((value) {
      return value;
    });

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(14),
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder(
                      future: familyUsers,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
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
                          return const Center(
                            child: Text('Không có dữ liệu'),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.only(bottom: 64),
                          itemCount: data.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final icon = data[index].avatarUrl != null &&
                                    data[index].avatarUrl != ""
                                ? data[index].avatarUrl
                                : iconAnimalList[0];
                            return SizedBox(
                              width: double.infinity,
                              child: SelectButton(
                                isSelected:
                                    _selectedMember.contains(data[index].id),
                                borderColor: primary.shade100,
                                hasBackground: true,
                                icon: icon,
                                label: data[index].name ?? "No name",
                                onPressed: () {
                                  // Multiple select
                                  setState(() {
                                    if (_selectedMember
                                        .contains(data[index].id)) {
                                      _selectedMember.remove(data[index].id);
                                    } else {
                                      _selectedMember.add(data[index].id);
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
        onPressed: () {
          onSubmit();
        },
        isDisabled: isSubmitting,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSubmitting)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            const SizedBox(width: 8),
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
