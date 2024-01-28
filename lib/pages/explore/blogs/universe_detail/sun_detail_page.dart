import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class SunDetailPage extends StatefulWidget {
  const SunDetailPage({super.key});

  @override
  State<SunDetailPage> createState() => _SunDetailPageState();
}

class _SunDetailPageState extends State<SunDetailPage> {
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
    body: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }
}