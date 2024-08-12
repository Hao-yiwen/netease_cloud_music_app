import 'package:get/get.dart';

class AuthController extends GetxController{
  var isLoggedIn = false.obs;

  void login(){
    isLoggedIn.value = true;
  }

  void logout(){
    isLoggedIn.value = false;
  }
}