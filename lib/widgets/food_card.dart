import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/models/menu.dart';
import 'package:khana_sabailai_admin/routes.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({Key? key, required this.menu}) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(GetRoutes.singleFood, arguments: menu);
      },
      child: Stack(
        children: [
          Hero(
            tag: 'food${menu.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                baseurl + menu.image!,
                height: 175,
                width: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: ClipRect(
              child: Container(
                height: 175,
                width: 170,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.food!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Rs. ${menu.price}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
