// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_options.dart';
import 'package:firebase_crud/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAs1pO5WVoYlxhNgwcJrG-xIMRBh3b9pAA",
          appId: "1:289909812297:web:0b572f81f31f393dfd2398",
          messagingSenderId: "289909812297",
          projectId: "fir-crud-7b8d1",
          storageBucket: "fir-crud-7b8d1.appspot.com"),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firebase CRUD',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
