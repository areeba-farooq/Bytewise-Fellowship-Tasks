// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  final String title;
  final String postID;
  final String postURL;
  final DateTime datePublished;
  final String uid;
  PostModel(
      {required this.title,
      required this.postID,
      required this.postURL,
      required this.datePublished,
      required this.uid});

  Map<String, dynamic> toJason() => {
        'title': title,
        'postID': postID,
        'postURL': postURL,
        'datePublished': datePublished,
        'uid': uid,
      };
}
