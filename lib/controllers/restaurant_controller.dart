import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/controllers/main_controller.dart';
import 'package:khana_sabailai_admin/utils/utils.dart';
import 'package:http/http.dart' as http;

class RestaurantController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();

  bool isLoading = false;

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

    pickImage() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    imageFile = file;
    update();
  }

  resetFields(){
    nameController.clear();
    emailController.clear();
    contactController.clear();
    addressController.clear();
    passwordController.clear();
    latController.clear();
    lonController.clear();

    imageFile = null;
    update();
  }

  addRestaurant(context) async {
    String name = nameController.text;
    String email = emailController.text;
    String contact = contactController.text;
    String address = addressController.text;
    String password = passwordController.text;
    String lat = latController.text;
    String lon = lonController.text;

    if (name.isEmpty) {
      customGetSnackbar('Error', 'Restaurant name is empty', 'error');
      return;
    }

    if (email.isEmpty) {
      customGetSnackbar('Error', 'Restaurant email is empty', 'error');
      return;
    }

    if (contact.isEmpty) {
      customGetSnackbar('Error', 'Restaurant contact is empty', 'error');
      return;
    }

    if (address.isEmpty) {
      customGetSnackbar('Error', 'Restaurant address is empty', 'error');
      return;
    }

    if (password.isEmpty) {
      customGetSnackbar('Error', 'Restaurant password is empty', 'error');
      return;
    }

    if (lat.isEmpty) {
      customGetSnackbar('Error', 'Restaurant lat is empty', 'error');
      return;
    }

    if (lon.isEmpty) {
      customGetSnackbar('Error', 'Restaurant lon is empty', 'error');
      return;
    }

    isLoading = true;
    update();

    var url = Uri.parse('${baseurl}restaurants/addRestaurant.php');
    var request = http.MultipartRequest("POST", url);
    // List<int> imageBytes = await imageFile!.readAsBytes();
    // String baseimage = base64Encode(imageBytes);
    if (imageFile != null) {
      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      //add multipart to request
      request.files.add(pic);
    }
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['contact'] = contact;
    request.fields['address'] = address;
    request.fields['password'] = password;
    request.fields['lat'] = lat;
    request.fields['lon'] = lon;

    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);
    if (res["success"]) {
      Navigator.of(context).pop();
      resetFields();
      customGetSnackbar('Success', res["message"][0], 'success');
      final mainController = Get.find<MainController>();
      mainController.fetchAllRestaurants();
    } else {
      customGetSnackbar('Failed', res["message"][0], 'error');
    }
    isLoading = false;
    update();
  }


  editRestaurant(context, resId) async {
    String name = nameController.text;
    String contact = contactController.text;
    String address = addressController.text;
    String lat = latController.text;
    String lon = lonController.text;

    if (name.isEmpty) {
      customGetSnackbar('Error', 'Restaurant name is empty', 'error');
      return;
    }


    if (contact.isEmpty) {
      customGetSnackbar('Error', 'Restaurant contact is empty', 'error');
      return;
    }

    if (address.isEmpty) {
      customGetSnackbar('Error', 'Restaurant address is empty', 'error');
      return;
    }


    if (lat.isEmpty) {
      customGetSnackbar('Error', 'Restaurant lat is empty', 'error');
      return;
    }

    if (lon.isEmpty) {
      customGetSnackbar('Error', 'Restaurant lon is empty', 'error');
      return;
    }

    isLoading = true;
    update();

    var url = Uri.parse('${baseurl}restaurants/editprofile.php');
    var request = http.MultipartRequest("POST", url);
    // List<int> imageBytes = await imageFile!.readAsBytes();
    // String baseimage = base64Encode(imageBytes);
    // if (imageFile != null) {
    //   var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
    //   //add multipart to request
    //   request.files.add(pic);
    // }
    request.fields['name'] = name;
    request.fields['contact'] = contact;
    request.fields['address'] = address;
    request.fields['lat'] = lat;
    request.fields['lon'] = lon;
    request.fields['user_id'] = resId;

    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);
    if (res["success"]) {
      Navigator.of(context).pop();
      resetFields();
      customGetSnackbar('Success', res["message"][0], 'success');
      final mainController = Get.find<MainController>();
      mainController.fetchAllRestaurants();
    } else {
      customGetSnackbar('Failed', res["message"][0], 'error');
    }
    isLoading = false;
    update();
  }

  deleteRestaurant(context, id, restore) async {
    isLoading = true;
    update();
    try {
      var url = Uri.parse('${baseurl}restaurants/deleteRestaurant.php');
      var response =
          await http.post(url, body: {'id': id, 'status': restore ? '0' : '1'});
      var res = await jsonDecode(response.body);

      if (res['success']) {
        Navigator.of(context).pop();
        customGetSnackbar('Success', res['message'], 'success');
        final mainController = Get.find<MainController>();
      mainController.fetchAllRestaurants();
      } else {
        customGetSnackbar('Error', res['message'], 'error');
      }
    } catch (e) {
      customGetSnackbar('Error', 'Something went wrong', 'error');
    }
    isLoading = false;
    update();
  }
}
