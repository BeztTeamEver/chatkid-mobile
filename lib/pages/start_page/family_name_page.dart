import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/enum/role.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/form_page.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';

class FamilyNamePage extends ConsumerStatefulWidget {
  FamilyNamePage({super.key});

  @override
  ConsumerState<FamilyNamePage> createState() => _FamilyNamePageState();
}

class _FamilyNamePageState extends ConsumerState<FamilyNamePage> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final _preferences = LocalStorage.instance.preferences;
  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập tên chung cho gia đình bạn";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    final isFirstRegister =
        _preferences.getBool(LocalStorageKey.IS_FIRST_REGISTER);
    if (isFirstRegister != null) {
      _preferences.remove(LocalStorageKey.IS_FIRST_REGISTER);
    }
  }

  Future<void> onSubmit() async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        //   ref
        //       .watch(
        //         createFamilyProvider(_controller.text).future,
        //       )
        //       .then((value) => {
        //             Navigator.push(
        //               context,
        //               createRoute(
        //                 () => StartPage(),
        //               ),
        //             )
        //           })
        //       .catchError((err) {
        //     Logger().e(err);
        //     ErrorSnackbar.showError(context: context, err: err);
        //   });
        Navigator.push(
          context,
          createRoute(
            // TODO: change to the user from api
            () => FormPage(
              user: UserModel(role: RoleConstant.Parent),
            ),
          ),
        );
      }
    } catch (err) {
      Logger().e(err);
    } finally {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(
          createFamilyProvider(_controller.text),
        )
        .isLoading;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                children: [
                  Text(
                    "Tên chung cho gia đình bạn",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: InputField(
                      name: "family_name",
                      controller: _controller,
                      hint: "Gia đình",
                      validator: _validate,
                      autoFocus: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  SvgPicture.asset(
                    'assets/loginPage/family.svg',
                    height: 270,
                  ),
                  const SizedBox(
                    height: 105,
                  ),
                  FullWidthButton(
                    onPressed: () async {
                      onSubmit();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoading
                            ? const CustomCircleProgressIndicator()
                            : Container(),
                        Text(
                          "Tiếp tục",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
