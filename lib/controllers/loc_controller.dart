import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_admin/models/loc.dart';
import 'package:khana_sabailai_admin/utils/utils.dart';

class LocController extends GetxController {
  List<Loc> loc = [];
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchAllLOC();
  }

  fetchAllLOC() async {
    var url = Uri.parse('${baseurl}loc/getLoc.php');
    var res = await http.get(url);

    var response = await jsonDecode(res.body);

    if (response['success']) {
      loc = AllLOC.fromJson(response).data!;
    }

    update();
  }

  addLOCCompany(context) async {
    String name = nameController.text;
    String email = emailController.text;
    String contact = contactController.text;
    if (name.isEmpty) {
      customGetSnackbar('Error', 'Company name is empty', 'error');
      return;
    }
    if (contact.isEmpty) {
      customGetSnackbar('Error', 'Company contact is empty', 'error');
      return;
    }
    if (email.isEmpty) {
      customGetSnackbar('Error', 'Company email is empty', 'error');
      return;
    }
    
    if (GetUtils.isEmail(email) == false) {
      customGetSnackbar('Error', 'Company email is invalid', 'error');
      return;
    }

    isLoading = true;
    update();

    try {
      var url = Uri.parse('${baseurl}loc/addLoc.php');
      var response = await http.post(url,
          body: {'name': name, 'contact': contact,'email':email});
      var res = await jsonDecode(response.body);

      if (res['success']) {
        customGetSnackbar('Success', res['message'], 'success');
        fetchAllLOC();
        Navigator.pop(context);
        nameController.clear();
        contactController.clear();
        emailController.clear();
      } else {
        customGetSnackbar('Error', res['message'], 'error');
      }
    } catch (e) {
      customGetSnackbar('Error', 'Something went wrong', 'error');
    }
    isLoading = false;
    update();
  }

  editLOCCompany(context, id)async{
    String name = nameController.text;
    String email = emailController.text;
    String contact = contactController.text;
    if (name.isEmpty) {
      customGetSnackbar('Error', 'Company name is empty', 'error');
      return;
    }
    if (contact.isEmpty) {
      customGetSnackbar('Error', 'Company contact is empty', 'error');
      return;
    }
    if (email.isEmpty) {
      customGetSnackbar('Error', 'Company email is empty', 'error');
      return;
    }
    
    if (GetUtils.isEmail(email) == false) {
      customGetSnackbar('Error', 'Company email is invalid', 'error');
      return;
    }

    isLoading = true;
    update();

    try {
      var url = Uri.parse('${baseurl}loc/editLoc.php');
      var response = await http.post(url,
          body: {'id':id, 'name': name, 'contact': contact,'email':email});
      var res = await jsonDecode(response.body);

      if (res['success']) {
        customGetSnackbar('Success', res['message'], 'success');
        fetchAllLOC();
        Navigator.pop(context);
        nameController.clear();
        contactController.clear();
        emailController.clear();
      } else {
        customGetSnackbar('Error', res['message'], 'error');
      }
    } catch (e) {
      customGetSnackbar('Error', 'Something went wrong', 'error');
    }
    isLoading = false;
    update();
  }

  deleteLOC(id) async {
    isLoading = true;
    update();

    try {
      var url = Uri.parse('${baseurl}loc/deleteLoc.php');
      var response = await http.post(url, body: {'id': id});
      var res = await jsonDecode(response.body);

      if (res['success']) {
        customGetSnackbar('Success', res['message'], 'success');
      } else {
        customGetSnackbar('Error', res['message'], 'error');
      }
      fetchAllLOC();
    } catch (e) {
      customGetSnackbar('Error', 'Something went wrong', 'error');
    }
    isLoading = false;
    update();
  }
}
