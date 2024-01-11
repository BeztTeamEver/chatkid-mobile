import 'package:chatkid_mobile/enum/role.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/info_page.dart';
import 'package:chatkid_mobile/pages/start_page/password_page.dart';
import 'package:chatkid_mobile/pages/start_page/role_page.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/error_handler.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class FormPage extends ConsumerStatefulWidget {
  final UserModel user;
  const FormPage({super.key, required this.user});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _roleController = TextEditingController();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _yearBirthDayController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.user.name ?? "";
  }

  void _onSubmitInfo(callback, stopLoading) async {
    final isValid = _formKey.currentState!.saveAndValidate() &&
        _formKey.currentState!.isValid;
    if (isValid) {
      UserModel newUser = UserModel.fromJson({
        ..._formKey.currentState!.value,
        "id": widget.user.id,
        "avatarUrl": widget.user.avatarUrl,
        "password": widget.user.password,
        "deviceToken": FirebaseService.instance.fcmToken,
      });
      // callback();
      // stopLoading();
      // return;
      try {
        await ref.watch(updateUserProvider(newUser).future).then((value) {
          Logger().d(value);
          callback();
        });
      } catch (e) {
        Logger().e(e);
        ErrorSnackbar.showError(err: e, context: context);
      } finally {
        stopLoading();
      }
      // ref.watch(updateUserProvider(newUser)).when(
      //       data: (data) {
      //         stopLoading();
      //         Logger().d(data);
      //         controller.nextPage(
      //           duration: Duration(milliseconds: 500),
      //           curve: Curves.ease,
      //         );
      //       },
      //       error: (error, stackTrace) {
      //         Logger().e(error);
      //         stopLoading();
      //         ErrorSnackbar.showError(err: error, context: context);
      //       },
      //       loading: () {},
      //     );
    }
    stopLoading();
    _formKey.currentState!.errors.forEach((key, value) {
      Logger().e("$key: $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 60),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onWillPop: () => Future.value(false),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: InfoPage(
                    roleController: _roleController,
                    genderController: _genderController,
                    nameController: _nameController,
                    yearBirthDayController: _yearBirthDayController,
                    isParent: widget.user.role ==
                        Role.Parent.toString().split('.').last,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Quay lại"),
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                              elevation: MaterialStatePropertyAll(2),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: BorderSide(
                                    color: primary.shade400,
                                    width: 2,
                                  ),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStatePropertyAll(primary.shade50),
                              foregroundColor:
                                  MaterialStatePropertyAll(primary.shade400),
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _onSubmitInfo(
                          () => {
                            Navigator.push(
                              context,
                              createRoute(
                                () => PasswordPage(
                                  userId: widget.user.id!,
                                ),
                              ),
                            )
                          },
                          () {},
                        ),
                        child: Text("Tiếp tục"),
                      ),
                    ),
                    //   Expanded(
                    //     child: ConstrainedBox(
                    //       constraints: BoxConstraints(
                    //         maxWidth: 150,
                    //         maxHeight: 100,
                    //       ),
                    //       child: FullWidthButton(
                    //         onPressed: ((stopLoading) => _onSubmitInfo(() {
                    //               Navigator.push(
                    //                 context,
                    //                 createRoute(
                    //                   () => PasswordPage(
                    //                     userId: widget.user.id!,
                    //                   ),
                    //                 ),
                    //               );
                    //             }, stopLoading)),
                    //         child: Text("Tiếp tục"),
                    //       ),
                    //     ),
                    //   )
                  ],
                )
                // InfoPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
