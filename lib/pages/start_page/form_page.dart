import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/role_page.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class FormPage extends ConsumerStatefulWidget {
  final UserModel user;
  const FormPage({super.key, required this.user});

  @override
  ConsumerState<FormPage> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  PageController controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(userFormProvider(widget.user)).userModel;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: PageView(
                  children: [
                    RolePage(),
                  ],
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) => setState(() {
                    _currentPage = value;
                  }),
                ),
              ),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   createRoute(
                    //     () => RolePage(
                    //       id: id,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Text("Tiếp tục"),
                  style:
                      Theme.of(context).elevatedButtonTheme.style!.copyWith(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
