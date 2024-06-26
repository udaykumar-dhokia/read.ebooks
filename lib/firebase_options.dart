// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAWvkEGuA2yYodmlMTYxdtirJmeOW8k4zs',
    appId: '1:1050066422494:web:e452a16f1d8554da95504f',
    messagingSenderId: '1050066422494',
    projectId: 'read-fab72',
    authDomain: 'read-fab72.firebaseapp.com',
    storageBucket: 'read-fab72.appspot.com',
    measurementId: 'G-T9D3NL8599',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCks4Y9pcGilbNf5PC3ytXj8peyKNpRwYc',
    appId: '1:1050066422494:android:d3ef336896144db195504f',
    messagingSenderId: '1050066422494',
    projectId: 'read-fab72',
    storageBucket: 'read-fab72.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbscU1_t0Qt8_30QlJfpi9kRHurkXumME',
    appId: '1:1050066422494:ios:7102fadc1573d7d595504f',
    messagingSenderId: '1050066422494',
    projectId: 'read-fab72',
    storageBucket: 'read-fab72.appspot.com',
    iosBundleId: 'com.example.read',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbscU1_t0Qt8_30QlJfpi9kRHurkXumME',
    appId: '1:1050066422494:ios:140f70631ff61bd495504f',
    messagingSenderId: '1050066422494',
    projectId: 'read-fab72',
    storageBucket: 'read-fab72.appspot.com',
    iosBundleId: 'com.example.read.RunnerTests',
  );
}
