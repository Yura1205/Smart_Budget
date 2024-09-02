// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCay8GPTKniXuaXReP7r4oV77-h1NzxwL0',
    appId: '1:75276627411:web:2a2d73e98cd0acd172d326',
    messagingSenderId: '75276627411',
    projectId: 'smartbudget-57353',
    authDomain: 'smartbudget-57353.firebaseapp.com',
    storageBucket: 'smartbudget-57353.appspot.com',
    measurementId: 'G-HT38CCZPF9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGzuXyWshbz8A90RJwIMJGaNssiQew0nE',
    appId: '1:75276627411:android:190defa850eaec0272d326',
    messagingSenderId: '75276627411',
    projectId: 'smartbudget-57353',
    storageBucket: 'smartbudget-57353.appspot.com',
  );
}