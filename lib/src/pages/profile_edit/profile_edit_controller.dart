
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../models/response_api.dart';
import '../../models/user.dart';
import '../../providers/user_providers.dart';
import '../profile/profile_controller.dart';

class ProfileEditController  extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  User user = User.fromJson(GetStorage().read('user') ?? {});

  UsersProvider usersProvider = UsersProvider();

  ProfileController profileController = Get.find();

  ProfileEditController(){
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }

  void  updateUser(BuildContext context) async {

    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();


    User uUser = User(
      id: user.id,
      email: user.email,
      name: name,
      lastname: lastname,
      phone: phone,
      image: user.image,
      sessionToken: user.sessionToken
    );

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(max: 100, msg: 'Actualizando el usuario...');

    if (imageFile == null){
      ResponseApi responseApi = await usersProvider.update(uUser);

      progressDialog.close();



      if (responseApi.success == true) {
        User userResponse = User.fromJson(responseApi.data);
        GetStorage().write('user', userResponse.toJson());
        profileController.user.value = userResponse;
        Get.snackbar('Usuario Actualizado', responseApi.message!);
      }
      else {
        Get.snackbar('No se pudo crear el usuario', responseApi.message!);
      }
    } else {

      Stream stream = await usersProvider.updateWithImage(uUser, imageFile!);
      stream.listen((res) {

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        progressDialog.close();



        if (responseApi.success == true) {
          User userResponse = User.fromJson(responseApi.data);
          GetStorage().write('user', userResponse.toJson());
          profileController.user.value = userResponse;
          Get.snackbar('Usuario Actualizado', responseApi.message!);
        }
        else {
          Get.snackbar('No se pudo crear el usuario', responseApi.message!);
        }
      });
    }
  }

  void saveUserSession() {

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
}