import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storageService = StorageService();

  List<File> _selectedImages = [];
  final TextEditingController _titleController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: _selectedImages
            .map((image) => Image.file(
                  image,
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectImages,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _selectImages() async {
    List<XFile>? pickedFiles =
        await ImagePicker().pickMultiImage(imageQuality: 50);

    List<File> files =
        pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();

    setState(() {
      _selectedImages = files;
    });
  }

  void _postImages() async {
    if (_selectedImages.isEmpty || _titleController.text.isEmpty) {
      return;
    }
    List<String> downloadUrls =
        await _storageService.uploadMultipleImages(_selectedImages);
    String title = _titleController.text;
    await FirestoreService().postImages(title, downloadUrls);
    setState(() {
      _selectedImages.clear();
      _titleController.clear();
    });
  }
}
