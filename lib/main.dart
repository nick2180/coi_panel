import 'dart:io';

import 'package:coi_panel/Home.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

Future main() async {
  bool web = true;
  WidgetsFlutterBinding.ensureInitialized();

  if (web == false) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD_aVeZDwg6toU9K6DdO9dLLvMiDgUHbZw",
            authDomain: "connecetmyhobbies.firebaseapp.com",
            projectId: "connecetmyhobbies",
            storageBucket: "connecetmyhobbies.appspot.com",
            messagingSenderId: "359478760391",
            appId: "1:359478760391:web:a6cd4be02a184d1d5bbfe2",
            measurementId: "G-NTPW7JL70N"));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
