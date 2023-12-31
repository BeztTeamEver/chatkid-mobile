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
import 'package:chatkid_mobile/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class FormPage extends ConsumerStatefulWidget {
  final UserModel user;
  const FormPage({super.key, required this.user});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _yearBirthDayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                    genderController: _genderController,
                    nameController: _nameController,
                    yearBirthDayController: _yearBirthDayController,
                    isParent: widget.user.role ==
                        Role.Parent.toString().split('.').last,
                  ),
                ),
                Row(
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
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: LoadingButton(
                        handleOnTap: ((stopLoading) => _onSubmitInfo(() {
                              Navigator.push(
                                context,
                                createRoute(
                                  () => PasswordPage(
                                    userId: widget.user.id!,
                                  ),
                                ),
                              );
                            }, stopLoading)),
                        label: "Tiếp theo",
                      ),
                    )
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
