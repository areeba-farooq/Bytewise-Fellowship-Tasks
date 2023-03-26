import 'package:bytewise_fellowship_tasks/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
          'Login',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: Text(
            'Please enter the details below to continue!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.purple[400],
              ),
              border: const OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.purple[400],
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
          height: 30,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.purple[400]),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 18),
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Signup',
                    style: TextStyle(fontSize: 18, color: Colors.blue[400])))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 60,
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
                size: 60,
              ),
            ),
            Container(
              height: 60,
              width: 60,
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
            )
          ],
        )
      ]),
    );
  }
}
