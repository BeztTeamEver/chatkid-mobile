import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
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
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: iconAnimalList
                    .map(
                      (icon) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: SelectButton(
                          icon: icon,
                          onPressed: () {
                            // TODO: IMPLEMENT NEXT PAGE
                            Logger()
                                .i("Tai khoan ${iconAnimalList.indexOf(icon)}");
                          },
                          label: "Tai khoan ${iconAnimalList.indexOf(icon)}",
                        ),
                      ),
                    )
                    .toList(),
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
