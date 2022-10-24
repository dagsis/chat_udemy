import 'dart:io';

import 'package:chat_udemy/src/pages/login/login_page.dart';
import 'package:chat_udemy/src/pages/messages/mesagge_page.dart';
import 'package:chat_udemy/src/pages/profile_edit/profile_edit_page.dart';
import 'package:chat_udemy/src/pages/register/register_page.dart';
import 'package:chat_udemy/src/utils/my_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'src/api/environment.dart';
import 'src/models/user.dart';
import 'src/pages/home/home_page.dart';
import 'src/providers/push_notifications_provider.dart';
import 'src/utils/default_firebase_config.dart';


User myUser = User.fromJson(GetStorage().read('user') ?? {});

PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // NOTIFICACIONES EN SEGUNDO PLANO
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  print('Notificacion en segundo plano ${message.messageId}');
  print('NUEVA NOTIFICACION BACKGROUND ${message.data}');
  pushNotificationsProvider.showNotification(message);

  Socket socket = io('${Environment.API_CHAT}chat', <String, dynamic> {
    'transports': ['websocket'],
    'autoConnect': false
  });
  socket.connect();
  socket.emit('received', {
    'id_chat': message.data['id_chat'],
    'id_message': message.data['id_message'],
  });
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDEoqOgmCuc07CL1QNLFZY_ZMHESw-0jp8',
      appId: '1:1090559196001:android:010077d3f9c1d5ae5b6320',
      messagingSenderId: '1090559196001',
      projectId: 'chat-flutter-f23c8',
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initPushNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App Flutter',
      initialRoute: myUser.id != null ?  '/home' : '/',
      getPages: [
        GetPage(name: '/', page:() => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile/edit', page: () => ProfileEditPage()),
        GetPage(name: '/message', page: () => MessagePage()),
      ],
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
      ),
      navigatorKey: Get.key,
    );
  }
}

