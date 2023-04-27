import 'package:bytewise_fellowship_tasks/Project2/Picture-Sharing-app/pages/signup_pg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Services/auth_service.dart';
import 'home_pg.dart';

class PicShowLoginScreen extends StatefulWidget {
  const PicShowLoginScreen({super.key});

  @override
  _PicShowLoginScreenState createState() => _PicShowLoginScreenState();
}

class _PicShowLoginScreenState extends State<PicShowLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign in'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()));
              },
              child: _isGoogleLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign up'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isGoogleLoading ? null : _signInWithGoogle,
              child: _isGoogleLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _authService.signInWithEmailAndPassword(
              _emailController.text.trim(), _passwordController.text.trim());
      print('Signed in user: ${userCredential.user!.email}');
      // Navigate to home screen
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signInWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final UserCredential userCredential = await _authService.signInWithGoogle(
          googleAuth.idToken!, googleAuth.accessToken!);
      print('Signed in user: ${userCredential.user!.email}');
      // Navigate to home screen
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isGoogleLoading = false;
      });
    }
  }
}
