import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset(
          'assets/translater.png',
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Translate & Earn',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Text(
            'Now its easy to earn money, just use the translate and collect points',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.purple[400]),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Get Started',
              style: TextStyle(fontSize: 18),
            ))
      ]),
    );
  }
}
