
import 'package:lostandfound/models/comment.dart';
import 'package:lostandfound/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:lostandfound/settings/const.dart';

class CommentsService{
  static addComment({required String text, required User owner}) async {
    var client = http.Client();
    print("ok");
    try {
      print("ok");
      String url = Const.url+'/comments';
      var comment = Comment(
          text: text,
          dateCreation: DateTime.now(),
          owner: owner
      );

      var result = await client.post(Uri.parse(url), body: comment.toJson());
      print(result);
    }
    catch (e) {
      print(e.toString());
    }
  }
}