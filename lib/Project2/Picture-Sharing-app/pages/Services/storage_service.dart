import 'dart:typed_data';

import 'package:bytewise_fellowship_tasks/Project2/Picture-Sharing-app/model/post_model.dart';
import 'package:bytewise_fellowship_tasks/Project2/Picture-Sharing-app/pages/Services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Future<String> imageToStorage(Uint8List file) async {
    try {
      String id = const Uuid().v1();
      Reference ref = _storage.ref().child('posts').child(id);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadPost(String uid, String title, Uint8List file) async {
    String res = 'Some Error Occurred';
    try {
      String? uid =
          await _authService.getCurrentUserId(); // Retrieve the user's UID

      String photoUrl = await imageToStorage(file);
      String postId = const Uuid().v1();
      PostModel postModel = PostModel(
          title: title,
          postID: postId,
          postURL: photoUrl,
          datePublished: DateTime.now(),
          uid: uid!);
      _firestore.collection('posts').doc(postId).set(postModel.toJason());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
