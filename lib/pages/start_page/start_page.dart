import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
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
    // GET FAMILY ACCOUNTS
    // final familyAccounts = ref.watch(familyServiceProvider).getFamilyAccounts();
    // Logger().d(familyAccounts);
    // final familyAccounts = ref.watch(createFamilyProvidr);
    // Logger().d(familyAccounts);
    final familyUsers = ref.read(getFamilyProvider(const FamilyRequestModel()));
    Logger().d(familyUsers);
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
                data: (data) => ListView(
                  shrinkWrap: true,
                  children: [
                    for (final user in data)
                      SelectButton(
                        label: user.name ?? "No name",
                        onPressed: () {
                          Logger().d(user.id);
                        },
                      ),
                  ],
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
                        Size(double.infinity, 45),
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
