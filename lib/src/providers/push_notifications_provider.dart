import 'dart:typed_data';

import 'package:chat_udemy/src/api/environment.dart';
import 'package:chat_udemy/src/providers/message_providers.dart';
import 'package:chat_udemy/src/providers/user_providers.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart';

class PushNotificationsProvider extends GetConnect {

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  void initPushNotifications() async {

    await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
  }

  void onMessageListener() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {

      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('NUEVA NOTIFICACION ${message.data}');
      // NOTIFICACIONES EN PRIMER PLANO
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  void showNotification(RemoteMessage message) async {

    AndroidNotificationDetails? androidPlatformChannelSpecifics;

    if (message.data['url'] == '') { // MENSAJE DE TEXTO

      androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: 'launch_background'
      );
    }
    else { // MENSAJE CON IMAGEN
      ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(message.data['url']));
      BigPictureStyleInformation information = BigPictureStyleInformation(
          bigPicture,
          contentTitle: message.data['title'],
          htmlFormatContentTitle: true,
          summaryText: message.data['body'],
          htmlFormatSummaryText: true
      );
      androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: 'launch_background',
          styleInformation: information
      );
    }



    plugin.show(
        int.parse(message.data['id_chat']),
        message.data['title'],
        message.data['body'],
        NotificationDetails(android: androidPlatformChannelSpecifics)
    );

    Socket socket = io('${Environment.API_CHAT}chat', <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': false
    });

    print('Mensaje Id ${message.data['id_message']}');

    socket.connect();
    socket.emit('received', {
      'id_chat': message.data['id_chat'],
      'id_message': message.data['id_message'],
    });

  }

  Future<Response> sendMessage(String token, Map<String, dynamic> data) async {

    Response response = await post('https://fcm.googleapis.com/fcm/send',
      {
      'priority': 'high',
      'ttl': '4500s',
      'data': data,
      'to': token
      },
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'key=AAAA_epku2E:APA91bE8KllzALy6gqPVXKsiq6oFrWYIZXlJLRdHbNQ1tQ-KV7l090HQzW7vOyKq2ibNQk0Is-56Bea2BUTYzQXD3H1BGqXNJv-KWykZN7YExkST8oigfX3EL1z19DyEYAoSLEhE6nj4'
      }
    );

    return response;
  }

  void saveToken(String idUser) async {
    String? token = await FirebaseMessaging.instance.getToken();

    UsersProvider usersProvider = UsersProvider();
    if (token != null) {
      await usersProvider.updateNotificationToken(idUser, token);
    }
  }

}