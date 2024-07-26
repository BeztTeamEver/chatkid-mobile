import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';

class UniversePage extends StatefulWidget {
  const UniversePage({super.key});

  @override
  State<UniversePage> createState() => _UniversePageState();
}

class _UniversePageState extends State<UniversePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 20,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: HexColor("260A95"),
              ),
              child: SingleChildScrollView(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 30,
                  children: [
                    Image.asset(
                      "assets/blog/universe/sun.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/sao_thuy.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/sao_kim.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/trai_dat.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/sao_hoa.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/sao_moc.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/sao_tho.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/sao_thien_vuong.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      "assets/blog/universe/sao_hai_vuong.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primary.shade100),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: primary.shade400,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
