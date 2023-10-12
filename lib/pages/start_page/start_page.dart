import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/start_page/role_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class StartPage extends ConsumerStatefulWidget {
  final List<UserModel> _users;

  const StartPage({Key? key, users})
      : _users = users,
        super(key: key);
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
    // final familyUsers = ref.watch(createFamilyProvider);
    Logger().d(widget._users.join(", "));
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
              // ListView(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     //TODO: render by using family accounts
              //     children: .(data: (data) {

              //     }, error: () => {

              //     }, loading: () => {

              //     },),
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
