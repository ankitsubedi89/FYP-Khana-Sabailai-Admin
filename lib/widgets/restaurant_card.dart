import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/models/restaurant.dart';
import 'package:khana_sabailai_admin/routes.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {super.key,
      this.height = 120,
      this.marginRight = 10,
      this.marginBottom = 0,
      this.fromNear = false,
      required this.restaurant});

  final double height;
  final double marginRight;
  final double marginBottom;

  final bool? fromNear;

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(GetRoutes.singleRestaurant,
            arguments: [restaurant, fromNear]);
      },
      child: Container(
        margin: EdgeInsets.only(right: marginRight, bottom: marginBottom),
        child: Stack(
          children: [
            Hero(
              tag: 'restaurant${restaurant.id}${fromNear! ? 'near' : ''}',
              child: Container(
                  height: height,
                  width: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          baseurl + restaurant.image!,
                        ),
                        fit: BoxFit.cover,
                      ))),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: height,
                width: height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0x36000000),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                      ),
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
