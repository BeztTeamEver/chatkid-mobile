import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/start_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/route.dart';
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

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập tên chung cho gia đình bạn";
    }
    return null;
  }

  Future<void> onSubmit(callback) async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        ref
            .watch(
              createFamilyProvider(_controller.text).future,
            )
            .then((value) => (callback()))
            .catchError((err) {
          Logger().e(err);
          ErrorSnackbar.showError(context: context, err: err);
        });
      }
    } catch (err) {
      Logger().e(err);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Column(
                children: [
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
                  SizedBox(
                    width: double.infinity,
                    child: LoadingBtn(
                      height: 60,
                      borderRadius: 40,
                      width: double.infinity,
                      loader: Container(
                        padding: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.idle) {
                          startLoading();
                          onSubmit(() {
                            stopLoading();
                            Navigator.push(
                              context,
                              createRoute(
                                () => StartPage(),
                              ),
                            );
                          });
                        }
                      },
                      child: Text(
                        "Tiếp tục",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
