import 'package:chat_udemy/src/pages/chat/chats_page.dart';
import 'package:chat_udemy/src/pages/profile/profile_page.dart';
import 'package:chat_udemy/src/pages/users/users_page.dart';
import 'package:chat_udemy/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {

  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottonNacigatorBar(context),
      body: Obx(()=> IndexedStack(
        index: con.tabIndex.value,
        children: [
          ChatsPage(),
          UsersPage(),
          ProfilePage()
        ],
      ))
    );
  }

  Widget bottonNacigatorBar(BuildContext context) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
          height: 54,
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: con.changeTabIndex,
            currentIndex: con.tabIndex.value,
            backgroundColor: MyColors.primaryColor,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat,
                  size: 20,
                  ),
                label: 'Chats',
                backgroundColor: MyColors.primaryColor
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                    size: 20,
                  ),
                  label: 'Usuarios',
                  backgroundColor: MyColors.primaryColor
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin_rounded,
                    size: 20,
                  ),
                  label: 'Perfil',
                  backgroundColor: MyColors.primaryColor
              ),
            ],
          ),
        )
        )
    );
  }
}
