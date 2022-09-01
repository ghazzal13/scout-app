import 'package:flutter/material.dart';
import 'package:scout/layout/auth/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      home: const LoginPage(),
    );
  }
}


/*
Platform  Firebase App Id
web       1:453196205507:web:ece4328a98bff7691cc176
android   1:453196205507:android:d687f1222ce85d1d1cc176
ios       1:453196205507:ios:18deb9fdafe9ee041cc176
macos     1:453196205507:ios:18deb9fdafe9ee041cc176

 */