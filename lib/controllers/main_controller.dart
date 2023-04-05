import 'dart:convert';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_admin/utils/utils.dart';

class MainController extends GetxController {
  String currentAddress = '';
  Position? currentPosition;

  bool isLoading = false;

  List<Restaurant> allRestaurants = [];
  List<Restaurant> filteredRestaurants = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchAllRestaurants();
  }

  search(String val) {
    if (val.isNotEmpty) {
      filteredRestaurants = allRestaurants
          .where((res) =>
              res.name!.toLowerCase().contains(val.toLowerCase()) ||
              res.address!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filteredRestaurants = allRestaurants;
    }
    update();
  }

  fetchAllRestaurants() async {
    isLoading = true;
    update();
    var response = await http
        .get(Uri.parse('${baseurl}restaurants/getAllRestaurants.php'));
    var res = json.decode(response.body);
    if (res['success']) {
      allRestaurants = AllRestaurants.fromJson(res).restaurant!;
      filteredRestaurants = AllRestaurants.fromJson(res).restaurant!;
    } else {
      customGetSnackbar('Restaurant Fetch Failed', res['message'], 'error');
    }
    isLoading = false;
    update();
  }
}
