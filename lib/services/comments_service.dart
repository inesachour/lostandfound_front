
import 'package:lostandfound/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';

class CommentsService{
  static addComment({required String text, required String commentOwner, required String publication}) async {
    var client = http.Client();
    try {
      String url = Const.url+'/comments';
      var comment = Comment(
          text: text,
          dateCreation: DateTime.now(),
          commentOwner: commentOwner,
          publication: publication
      );

      var result = await client.post(Uri.parse(url), body: comment.toJson());
      print(result);
    }
    catch (e) {
      print(e.toString());
    }
  }
}