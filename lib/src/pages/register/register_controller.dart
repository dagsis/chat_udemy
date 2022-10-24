import 'dart:convert';
import 'dart:io';

import 'package:chat_udemy/src/models/response_api.dart';
import 'package:chat_udemy/src/models/user.dart';
import 'package:chat_udemy/src/providers/user_providers.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;


  void register(BuildContext context) async {

    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando el usuario...');

      User user = User(
          email: email,
          name: name,
          lastname: lastname,
          phone: phone,
          password: password,
          image: 'https://image.shutterstock.com/image-vector/person-icon-profile-isolated-vector-260nw-684276352.jpg'
      );

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        progressDialog.close();

        if (responseApi.success == true) {
          clearForm();
          User user = User.fromJson(responseApi.data);
          GetStorage().write('user', user.toJson());
          goToHomePage();
        }
        else {
          Get.snackbar('No se pudo crear el usuario', responseApi.message!);
        }
      });

    }

  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  Future selectImage(ImageSource imageSource) async {
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update(); // SET STATE
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }

  void clearForm() {
    emailController.text = '';
    nameController.text = '';
    lastnameController.text = '';
    phoneController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  bool isValidForm(
      String email,
      String name,
      String lastname,
      String phone,
      String password,
      String confirmPassword) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el correo electronico');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email que ingresaste no es valido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu numero de telefono');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu contraseña');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes confirmar tu contraseña');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido', 'Las contraseñas no coinciden');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imagen de perfil');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imagen de perfil');
      return false;
    }

    return true;
  }



}