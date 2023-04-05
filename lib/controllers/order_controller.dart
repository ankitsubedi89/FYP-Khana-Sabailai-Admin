import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/controllers/main_controller.dart';
import 'package:khana_sabailai_admin/models/order.dart';
import 'package:khana_sabailai_admin/models/report.dart';
import 'package:khana_sabailai_admin/utils/utils.dart';

class LabelValue {
  String label;
  String value;

  LabelValue(this.label, this.value);
}

class OrderController extends GetxController {
  List<Order> orders = [];
  bool isLoading = false;
  String orderStatus = 'All';
  String restaurantStatus = 'All';

  List<LabelValue> getAllOrderStatus() {
    List<LabelValue> orderStatus = [
      LabelValue('All', 'All'),
      LabelValue('Pending', '0'),
      LabelValue('Preparing', '1'),
      LabelValue('Completed', '2'),
      LabelValue('Cancelled', '3'),
    ];
    return orderStatus;
  }

  List<LabelValue> getAllRestaurantNames() {
    final mainController = Get.find<MainController>();

    var def = LabelValue('All', 'All');
    List<LabelValue> restaurantNames = [def];
    for (var i = 0; i < mainController.allRestaurants.length; i++) {
      var restaurant = LabelValue(mainController.allRestaurants[i].name!,
          mainController.allRestaurants[i].id!);
      restaurantNames.add(restaurant);
    }
    return restaurantNames;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchOrders();
    fetchReport('All', 'All');
  }

  String reportTime = 'All';

  List<LabelValue> reportTimeList = [
    LabelValue('All', 'All'),
    LabelValue('Last 7 days', 'last_7_days'),
    LabelValue('Last 30 days', 'last_30_days'),
    LabelValue('Last 3 months', 'last_90_days'),
    LabelValue('Last 6 months', 'last_180_days'),
    LabelValue('Last 1 year', 'last_365_days'),
  ];

  AllReport? allReport = AllReport();

  fetchReport(String time, String resId) async {
    isLoading = true;
    update();

    print('restaurant $resId');

    // try {
    var url = Uri.parse('${baseurl}orders/report.php');
    var body = {'time': time};
    if (resId != 'All') {
      body['restaurantId'] = resId;
    }
    var response = await http.post(url, body: body);
    var res = await jsonDecode(response.body);
    if (res['success']) {
      allReport = AllReport.fromJson(res);
    } else {
      customGetSnackbar('Error', 'Something went wrong', 'error');
    }
    // } catch (e) {
    //   customGetSnackbar('Error', 'Something went wrong', 'error');
    // }
    isLoading = false;
    update();
  }

  fetchOrders() async {
    isLoading = true;
    update();

    var url = Uri.parse('${baseurl}orders/getAllOrders.php');
    var res = await http.post(url);

    var response = await jsonDecode(res.body);

    if (response['success']) {
      orders = AllOrders.fromJson(response).order!;
    }
    isLoading = false;
    update();
  }

  changeOrderStatus(status, orderId) async {
    var url = Uri.parse('${baseurl}orders/changeOrderStatus.php');
    var res =
        await http.post(url, body: {'status': status, 'order_id': orderId});

    var response = await jsonDecode(res.body);

    if (response['success']) {
      fetchOrders();

      customGetSnackbar('Success', response['message'], 'success');
    } else {
      customGetSnackbar('Error', response['message'], 'error');
    }
  }

  List<Order> getTodayOrders(bool isToday) {
    if (!isToday) {
      var orders = filteredAllOrders();
      return orders;
    }
    //convert orders date to dart format and compare to see if the order is from today
    return orders.where((element) {
      var date = DateTime.parse(element.date!);
      return date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year;
    }).toList();
  }

  List<Order> filteredAllOrders() {
    List<Order> filteredOrders = [];
    if (orderStatus == 'All' && restaurantStatus == 'All') {
      filteredOrders = orders;
    } else if (orderStatus == 'All' && restaurantStatus != 'All') {
      filteredOrders = orders.where((element) {
        return element.restaurantId == restaurantStatus;
      }).toList();
    } else if (orderStatus != 'All' && restaurantStatus == 'All') {
      filteredOrders = orders.where((element) {
        return element.status == orderStatus;
      }).toList();
    } else {
      filteredOrders = orders.where((element) {
        return element.status == orderStatus &&
            element.restaurantId == restaurantStatus;
      }).toList();
    }

    return filteredOrders;
  }
}
