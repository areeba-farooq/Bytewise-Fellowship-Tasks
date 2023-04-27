import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Project2/Picture-Sharing-app/pages/login_pg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      home: const PicShowLoginScreen(),
    );
  }
}
