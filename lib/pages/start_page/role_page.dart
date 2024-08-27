import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/form_page.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/secondary_select_button.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RolePage extends ConsumerStatefulWidget {
  const RolePage({super.key});

  @override
  ConsumerState<RolePage> createState() => _RolePageState();
}

class _RolePageState extends ConsumerState<RolePage> {
  String _role = "";

  setFormField(value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hãy chọn vai trò cho tài khoản",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 20,
                    ),
              ),
              Text(
                "Phụ huynh có thể hỗ trợ bé tạo tài khoản",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
              const SizedBox(
                height: 40,
              ),
              SecondarySelectButton(
                label: "Phụ huynh",
                hasBackground: true,
                backgroundImage: "assets/selectButton/parent.svg",
                onPressed: () {
                  setState(() {
                    _role = RoleConstant.Parent;
                  });
                },
                isSelected: _role == RoleConstant.Parent,
              ),
              const SizedBox(
                height: 10,
              ),
              SecondarySelectButton(
                label: "Trẻ em",
                isSelected: _role == RoleConstant.Child,
                backgroundImage: "assets/selectButton/children.svg",
                onPressed: () {
                  setState(() {
                    _role = RoleConstant.Child;
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
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
                      style:
                          Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                elevation: const MaterialStatePropertyAll(2),
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
                      child: Text(
                        "Quay lại",
                        style: TextStyle(
                          color: primary.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          _role.isNotEmpty
                              ? primary.shade400
                              : neutral.shade200,
                        ),
                        surfaceTintColor: MaterialStateProperty.all<Color>(
                          _role.isNotEmpty
                              ? neutral.shade500
                              : primary.shade200,
                        ),
                      ),
                      onPressed: () {
                        if (_role.isEmpty) {
                          return;
                        }

                        Navigator.push(
                          context,
                          createRoute(
                            () => FormPage(
                              userRole: _role,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Tiếp tục",
                        style: TextStyle(
                          color:
                              _role.isEmpty ? neutral.shade600 : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
