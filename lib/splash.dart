import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 1.0),
            colors: [Color(0xff31bcff), Color(0xff000074)],
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  SvgPicture.asset(
                    'assets/svg/logo-white.svg',
                    height: 100,
                    width: 100,
                  ),
                  const Text(
                    'खाना सबैलाई',
                    style: TextStyle(
                      fontFamily: 'Laila',
                      fontSize: 39,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Khana Sabailai',
                    style: TextStyle(
                      fontFamily: 'Laila',
                      fontSize: 34,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
