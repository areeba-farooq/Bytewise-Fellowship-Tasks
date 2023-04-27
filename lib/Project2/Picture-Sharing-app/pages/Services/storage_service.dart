import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadMultipleImages(List<File> files) async {
    List<String> downloadUrls = [];
    for (int i = 0; i < files.length; i++) {
      Reference ref = _storage.ref().child('images/${DateTime.now()}');
      UploadTask uploadTask = ref.putFile(files[i]);
      await uploadTask.whenComplete(() async {
        String url = await ref.getDownloadURL();
        downloadUrls.add(url);
      });
    }
    return downloadUrls;
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postImages(String title, List<String> downloadUrls) async {
    try {
      CollectionReference imagesRef = _firestore.collection('images');
      await imagesRef.add({
        'title': title,
        'downloadUrls': downloadUrls,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}
