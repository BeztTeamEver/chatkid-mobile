import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/profile_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';

class MoMoQRCodePage extends StatefulWidget {
  int index;
  String identifier;
  MoMoQRCodePage({super.key, this.index = 100, this.identifier = ""});

  @override
  State<MoMoQRCodePage> createState() => _MoMoQRCodePageState();
}

class _MoMoQRCodePageState extends State<MoMoQRCodePage> {
  @override
  Widget build(BuildContext context) {
    Logger().i(widget.identifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Chuyển khoản"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Image.asset(
              "assets/payment/qr${widget.index}.jpg",
              width: MediaQuery.of(context).size.width - 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(color: Colors.orangeAccent, width: 1.5)),
              child: Row(children: [
                const Text(
                  "Nội dung chuyển khoản:",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    widget.identifier,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: LoadingBtn(
                height: 50,
                borderRadius: 40,
                width: double.infinity,
                loader: Container(
                  padding: const EdgeInsets.all(10),
                  width: 45,
                  height: 45,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                onTap: (startLoading, stopLoading, btnState) async {
                  // if (btnState == ButtonState.idle) {
                  //   startLoading();
                  //   onSubmit((orderId, link) {
                  //     stopLoading();
                  //     _launchPaypalURL(link, orderId);
                  //   });
                  // }
                  Navigator.push(
                    context,
                    createRoute(
                      () => const MainPage(index: 3),
                    ),
                  );
                },
                child: Text(
                  "Xác nhận đã thanh toán",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              style: ButtonStyle(
                side: const MaterialStatePropertyAll(
                    BorderSide(color: Colors.orangeAccent, width: 1.5)),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 50)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all(
                  Colors.white,
                ),
              ),
              child: Text(
                'Quay lại',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.orangeAccent,
                    ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        currentIndex: 3,
        onTap: (index) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainPage(index: index)));
        },
      ),
    );
  }
}
