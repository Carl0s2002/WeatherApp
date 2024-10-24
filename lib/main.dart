import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wheather_app/screens/login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'providers/user_provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}


