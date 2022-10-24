import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/my_colors.dart';
import 'profile_edit_controller.dart';

class ProfileEditPage extends StatelessWidget {

  ProfileEditController con = Get.put(ProfileEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil de usuario'),
          automaticallyImplyLeading: true,
          backgroundColor: MyColors.primaryColor,
        ),
        bottomNavigationBar: _buttonRegister(context),
        body: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _imageUser(context),
                      SizedBox(height: 30),
                      _textFieldName(),
                      _textFieldLastName(),
                      _textFieldPhone(),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _iconBack() {
    return IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios, color: Colors.white)
    );
  }

  Widget _textRegister() {
    return Text(
      'REGISTRO',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primeryColorDark
            ),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.lastnameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primeryColorDark
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primeryColorDark
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {

    return GestureDetector(
      onTap: () => con.showAlertDialog(context),
      child: GetBuilder<ProfileEditController>(
        builder: (value) => CircleAvatar(
          backgroundImage: con.imageFile != null
              ? FileImage(con.imageFile!)
              : con.user.image != null 
                ?  NetworkImage(con.user.image!)
                : AssetImage('assets/img/user_profile_2.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () => con.updateUser(context),
        child: Text('ACTUALIZAR'),
        style: ElevatedButton.styleFrom(

            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor
      ),
    );
  }

}
