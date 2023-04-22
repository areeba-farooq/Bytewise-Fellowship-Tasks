import 'package:flutter/material.dart';

import 'Animations-task9/animation_task.dart';

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

      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const GetStarted(),
      //   '/login': (context) => const Login(),
      //   '/signup': (context) => const Signup(),
      //   '/home': (context) => const HomePage(),
      // },
      home: const AnimatedBox(),
    );
  }
}
