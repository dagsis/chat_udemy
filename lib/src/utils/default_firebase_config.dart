import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
        authDomain: 'react-native-firebase-testing.firebaseapp.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        projectId: 'chat-flutter-f23c8',
        storageBucket: 'react-native-firebase-testing.appspot.com',
        messagingSenderId: '448618578101',
        appId: '1:448618578101:web:772d484dc9eb15e9ac3efc',
        measurementId: 'G-0N1G9FLDZE',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
        appId: '1:448618578101:ios:0b11ed8263232715ac3efc',
        messagingSenderId: '448618578101',
        projectId: 'chat-flutter-f23c8',
        authDomain: 'react-native-firebase-testing.firebaseapp.com',
        iosBundleId: 'io.flutter.plugins.firebase.messaging',
        iosClientId:
        '448618578101-evbjdqq9co9v29pi8jcua8bm7kr4smuu.apps.googleusercontent.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:1090559196001:android:010077d3f9c1d5ae5b6320',
        apiKey: 'AIzaSyDEoqOgmCuc07CL1QNLFZY_ZMHESw-0jp8',
        projectId: 'chat-flutter-f23c8',
        messagingSenderId: '1090559196001',
        authDomain: 'chat-flutter-f23c8.appspot.com',
        androidClientId:
        '1090559196001-3ldaubs154rcl7f0fm102l7l9hmsb7ji.apps.googleusercontent.com',
      );
    }
  }
}