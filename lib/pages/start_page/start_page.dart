import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/pages/start_page/form_page.dart';
import 'package:chatkid_mobile/pages/start_page/role_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/providers/step_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<StartPage> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(saveStepProvider(1));

    final familyUsers =
        ref.watch(getFamilyProvider(const FamilyRequestModel()));
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bạn là ai?",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(
                height: 40,
              ),
              familyUsers.when(
                data: (data) => ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) => SizedBox(
                    width: double.infinity,
                    child: SelectButton(
                      borderColor: primary.shade100,
                      hasBackground: true,
                      icon: data[index].avatarUrl ?? iconAnimalList[index],
                      label: data[index].name ?? "No name",
                      onPressed: () {
                        Navigator.push(
                          context,
                          createRoute(
                            () => FormPage(id: data[index].id),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                error: (error, stack) {
                  Logger().e(error, stackTrace: stack);
                  return Container();
                },
                loading: () => const CircularProgressIndicator(),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {},
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 45),
                      ),
                    ),
                child: const Text("Xác Nhận"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
