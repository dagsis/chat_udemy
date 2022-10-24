import 'package:chat_udemy/src/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {

  ProfileController con = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => con.gotoProfileEdit(),
            child: Icon(Icons.edit),
            backgroundColor: Colors.blueAccent,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => con.sigOut(),
            child: Icon(Icons.power_settings_new),
            backgroundColor: Colors.green,
          ),
        ],
      ),
      body:  Obx( () =>
          SafeArea(
          child: Column(
            children: [
             circleImageUser(),
             userInfo('Nombre del usuario',
                 '${con.user.value.name}  ${con.user.value.lastname}',
                 Icons.person),
              userInfo('Email',
                  '${con.user.value.email}',
                  Icons.email),
              userInfo('Teléfono',
                  '${con.user.value.phone}',
                  Icons.phone),
            ],
          ),
        ),
      )
    );
  }
  Widget userInfo(String title,String subtile,IconData iconData) {
    return  Container(
      margin: EdgeInsets.only(left: 30,right: 30),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtile),
        leading: Icon(iconData),
      ),
    );
  }

  Widget circleImageUser() {
    return   Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 200,
        child: AspectRatio(aspectRatio: 1,
          child: ClipOval(
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/img/user_profile_2.png',
                image: con.user.value.image ?? 'https://image.shutterstock.com/image-vector/person-icon-profile-isolated-vector-260nw-684276352.jpg'
            ),
          ),
        ),
      ),
    );
  }
}

