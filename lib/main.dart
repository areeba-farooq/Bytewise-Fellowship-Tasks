import 'package:bytewise_fellowship_tasks/Screens/get_started_screen.dart';
import 'package:bytewise_fellowship_tasks/Screens/home_screen.dart';
import 'package:bytewise_fellowship_tasks/Screens/login_screen.dart';
import 'package:bytewise_fellowship_tasks/Screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const GetStarted(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/home': (context) => const HomePage(),
      },
      // home: const GetStarted(),
    );
  }
}
