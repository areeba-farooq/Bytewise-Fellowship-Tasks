import 'dart:typed_data';

import 'package:bytewise_fellowship_tasks/Project2/Picture-Sharing-app/pages/Services/auth_service.dart';
import 'package:bytewise_fellowship_tasks/Project2/Picture-Sharing-app/pages/login_pg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? _file;
  final TextEditingController _titleController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  bool isLoading = false;
  void postImage() async {
    setState(() {
      isLoading = true;
    });
    String res = 'Error Occurred';
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        String uid = user.uid;

        String res = await StorageService().uploadPost(
          uid,
          _titleController.text,
          _file!,
        );

        if (res == 'success') {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Posted'),
            ),
          );
          clearImage();
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void logout() async {
    setState(() {
      isLoading = true;
    });
    await _authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PicShowLoginScreen(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Pictures'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => logout(), icon: const Icon(Icons.logout))
        ],
      ),
      body: _file == null
          ? StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final posts = snapshot.data?.docs ?? [];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final post in posts)
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(15),
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  post['postURL'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              post['title'],
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),

                      // Add the button, text field, and other UI elements here
                    ],
                  ),
                );
              },
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 0)),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: 'Write something...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: postImage, child: const Text('Post'))
                      ],
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _imageSelectOption(context),
        child: const Icon(Icons.camera),
      ),
    );
  }

  _imageSelectOption(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select Image'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a Photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImages(ImageSource.camera);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Pick an Image from gallery'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImages(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  pickImages(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return file.readAsBytes();
    }
    print('No Image selected!');
  }
}
