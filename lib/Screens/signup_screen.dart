import 'package:flutter/material.dart';

import 'home_screen.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset(
          'assets/translater.png',
          height: 200,
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Signup',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: Text(
            'Translate and earn money',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.blue[400],
              ),
              border: const OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.blue[400],
              ),
              border: const OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blue[400],
              ),
              suffixIcon: const Icon(
                Icons.visibility_off_sharp,
              ),
              border: const OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.blue[400]),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: const Text(
              'Signup',
              style: TextStyle(fontSize: 18),
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Login',
                    style: TextStyle(fontSize: 18, color: Colors.purple[400])))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(
                Icons.facebook,
                color: Colors.blue[900],
                size: 50,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Icon(
                Icons.apple,
                color: Colors.black,
                size: 50,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
