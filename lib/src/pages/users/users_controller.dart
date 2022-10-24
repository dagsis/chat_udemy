
import 'package:chat_udemy/src/providers/user_providers.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class UsersController extends GetxController {
   UsersProvider usersProvider = UsersProvider();

   Future<List<User>> getUsers() async {
     return await usersProvider.getUsers();
   }

   void goToChat(User user) {
     Get.toNamed('/message',arguments: {
       'user' : user.toJson()
     });
   }
}