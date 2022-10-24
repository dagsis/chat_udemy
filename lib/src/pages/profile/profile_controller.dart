import 'package:chat_udemy/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {

    var user  = User.fromJson(GetStorage().read('user') ?? {}).obs;

    void sigOut() {
      GetStorage().remove('user');
      Get.offNamedUntil('/',(route) => false);
    }

    void gotoProfileEdit() {
      Get.toNamed('/profile/edit');
    }
}