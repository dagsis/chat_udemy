
import 'dart:io';

import 'package:chat_udemy/src/api/environment.dart';
import 'package:chat_udemy/src/models/user.dart';
import 'package:chat_udemy/src/providers/push_notifications_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});
  PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();


  var tabIndex = 0.obs;

  Socket socket = io('${Environment.API_CHAT}chat', <String, dynamic> {
    'transports': ['websocket'],
    'autoConnect': false
  });

  HomeController() {
    print('Uusario de sesion: ${user.toJson()}');
    connectAndListen();
    saveToken();
  }

  void saveToken() {

    if ( user.id != null) {

      pushNotificationsProvider.saveToken(user.id!);
    }
  }


  void connectAndListen() {
    if (user.id != null) {
      socket.connect();
      socket.onConnect((data) {
        print('USUARIO CONECTADO A SOCKET IO');
        emitOnline();
      });
    }
  }

  void emitOnline() {
    socket.emit('online', {
      'id_user': user.id
    });
  }



  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    socket.disconnect();
  }
}