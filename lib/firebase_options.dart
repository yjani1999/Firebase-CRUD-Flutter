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
///
///

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
    apiKey: 'AIzaSyAs1pO5WVoYlxhNgwcJrG-xIMRBh3b9pAA',
    appId: '1:289909812297:web:0b572f81f31f393dfd2398',
    messagingSenderId: '289909812297',
    projectId: 'fir-crud-7b8d1',
    authDomain: 'fir-crud-7b8d1.firebaseapp.com',
    storageBucket: 'fir-crud-7b8d1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGUATVUO3Q7Ovw2MJWidzEg0Iwz7IQ_uk',
    appId: '1:289909812297:android:c3251e661fbcb84cfd2398',
    messagingSenderId: '289909812297',
    projectId: 'fir-crud-7b8d1',
    storageBucket: 'fir-crud-7b8d1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyhZclhE28q3zFz3cUSFaAlGVJqglXCdo',
    appId: '1:289909812297:ios:ec8d415f4a90b353fd2398',
    messagingSenderId: '289909812297',
    projectId: 'fir-crud-7b8d1',
    storageBucket: 'fir-crud-7b8d1.appspot.com',
    iosClientId:
        '289909812297-sp1oj9m2hq4elorsbmhm358morg9ukl1.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyhZclhE28q3zFz3cUSFaAlGVJqglXCdo',
    appId: '1:289909812297:ios:ec8d415f4a90b353fd2398',
    messagingSenderId: '289909812297',
    projectId: 'fir-crud-7b8d1',
    storageBucket: 'fir-crud-7b8d1.appspot.com',
    iosClientId:
        '289909812297-sp1oj9m2hq4elorsbmhm358morg9ukl1.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseCrud',
  );
}
