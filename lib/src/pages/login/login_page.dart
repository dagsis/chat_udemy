import 'package:chat_udemy/src/pages/login/login_controller.dart';
import 'package:chat_udemy/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  LoginController con = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: -80,
                left: -100,
                child: _circleLogin()
            ),
            Positioned(
              child: _textLogin(),
              top: 60,
              left: 25,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _imgBanner(context),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _textDomHaceAccount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textDomHaceAccount() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No tienes cuenta?',style: TextStyle(
            color: MyColors.primaryColor
        ),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: (){
            Get.toNamed('/register');
          },
          child: Text(
            'Registrate',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor
            ),
          ),
        )
      ],
    );
  }

  Widget _buttonLogin() {
    return   Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 30),
      child: ElevatedButton(
        onPressed: () {
          con.login();
        },
        child: Text('INGRESAR'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primeryColorDark,
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo electronico',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primeryColorDark,
          ),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          ),
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
        color: MyColors.primaryColor,

      ),
    );
  }

  Widget _textLogin() {
    return Text(
      'LOGIN',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22
      ),
    );
  }

  Widget _imgBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 120,
          bottom: MediaQuery.of(context).size.height * 0.040
      ),
      child: Image.asset(
        'assets/img/chat.png',
        width: 150,
        height: 150,
      ),
    );
  }
}




