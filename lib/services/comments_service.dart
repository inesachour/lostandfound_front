// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/foundation.dart';
import 'package:lostandfound/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';

class CommentsService extends ChangeNotifier {

  static CommentsService _commentsService = CommentsService();
  static CommentsService get getCommentService => _commentsService;

   addComment(
      {required String text,
      required String commentOwner,
      required String publication}) async {
    var client = http.Client();
    try {
      String url = Const.url + '/comments';
      var comment = Comment(
          text: text,
          dateCreation: DateTime.now().toString(),
          commentOwner: commentOwner,
          publication: publication);
      var result = await client.post(Uri.parse(url), body: comment.toJson());
      if(result.statusCode==201)
        notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

   Future<List<Comment>?> findComments(
      {required String publicationId}) async {
    var client = http.Client();
    try {
      String url = Const.url + '/comments/' + publicationId;
      var result = await client.get(Uri.parse(url));
      return commentsFromJson(result.body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> deleteComment(String id) async
  {
    var client = http.Client();
    try {
      String url = Const.url + '/comments/' + id;
      var result = await client.delete(Uri.parse(url));
      if(result.statusCode==200)
        {
          notifyListeners();
          return true;
        }
    } catch (e) {
      print(e.toString());
    }
    return false;

  }
  Future<bool> updateComment(String id,String text) async
  {
    var client = http.Client();
    try {
      String url = Const.url + '/comments/' + id;
      var result = await client.patch(Uri.parse(url),
      body: {
        "text": text
      }
      );
      if(result.statusCode==200)
        {
          notifyListeners();
          return true;
        }
    } catch (e) {
      print(e.toString());
    }
    return false;

  }
}
