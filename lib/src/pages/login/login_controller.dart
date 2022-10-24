import 'package:chat_udemy/src/providers/user_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/response_api.dart';
import '../../models/user.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {


    String email = emailController.text.trim();
    String password = passwordController.text.trim();


    UsersProvider userProvider = UsersProvider();

    GetStorage storage = GetStorage();

    if (email.isNotEmpty && password.isNotEmpty){
      ResponseApi responseApi = await userProvider.login(email, password);

      if (responseApi.success == true){
        User user = User.fromJson(responseApi.data);
        print(user.toJson());
        storage.write('user', user.toJson());
        goToHomePage();
      } else {
        Get.snackbar('Error de Sesion', 'Usuario o contraseña Incorrecta');
      }
    } else {
      Get.snackbar('Error de Sesion', 'Los campos email y password no deben estar vacios');
    }

  }

  void goToHomePage() {
     Get.toNamed('/home');
  }

}