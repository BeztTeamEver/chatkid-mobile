import 'package:chatkid_mobile/pages/main_page.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Vũ trụ"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: HexColor("260A95"),
          ),
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
      bottomNavigationBar: BottomMenu(
        currentIndex: 0,
        onTap: (index) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainPage(index: index)));
        },
      ),
    );
  }
}
