import 'package:chat_udemy/src/pages/users/users_controller.dart';
import 'package:chat_udemy/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class UsersPage extends StatelessWidget {

  UsersController con = Get.put(UsersController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Lista de usuarios'),
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: con.getUsers(),
          builder: (context,AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isNotEmpty == true) {
                 return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                     itemBuilder: (_,index) {
                       return cardUser(snapshot.data![index]);
                     }
                 );
              } else {
                return Container();
              }
            }  else {
              return Container();
            }
          },
        ),
      )
    );
  }

  Widget cardUser(User user) {
    return ListTile(
      onTap: () => con.goToChat(user),
      title: Text(user.name ?? ''),
      subtitle: Text(user.email ?? ''),
      leading:   AspectRatio(aspectRatio: 1,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: 'assets/img/user_profile_2.png',
            image: user.image ?? 'https://image.shutterstock.com/image-vector/person-icon-profile-isolated-vector-260nw-684276352.jpg'
        ),
      ),
    ),
    );
  }
}
