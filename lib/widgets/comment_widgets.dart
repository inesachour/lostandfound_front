

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lostandfound/models/comment.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/services/comments_service.dart';
import 'package:lostandfound/services/users_service.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
late User? user;

Widget addComment({required TextEditingController controller, required String publication}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
    child: TextFormField(
      controller: controller,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(Icons.send,),
            onPressed: () async {
              if(controller.text != Null && controller.text.isNotEmpty ){
                final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                final SharedPreferences prefs = await _prefs;
                var commentOwner = prefs.getString("userId");
                var ok = await CommentsService.addComment(
                  text: controller.text,
                  commentOwner: commentOwner!,
                  publication: publication,
                );
                controller.clear();
              }
        }
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fillColor: Colors.white,
        filled: true,
        focusColor: Colors.white,
        hintText: "Ecrire commentaire",
      ),
    ),
  );
}


Widget listComments({required TextEditingController controller, required String publicationId}){
  var commentsFuture = CommentsService.findComments(publicationId: publicationId);

  return Column(
    children: [
      StreamBuilder<List<Comment>?>(
        stream: Stream.fromFuture(commentsFuture),
        builder: (BuildContext context, AsyncSnapshot<List<Comment>?> snapshot,) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else if (snapshot.connectionState == ConnectionState.active
              || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Erreur');
            } else if (snapshot.hasData) {
              var _comments = snapshot.data ?? [];
              print(_comments.length);
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    Comment comment = _comments[index];
                    print(comment.commentOwner);
                    return CommentCard(comment);
                  });
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
      addComment(controller : controller, publication: publicationId)
    ],
  );
}

Widget CommentCard(Comment comment){

  getUser(comment.commentOwner);
  return Card(
    child: Row(
      children: [

        Container(
          child: Column(
            children: [
              Text(user!= null ? user!.firstName : "ok"),
              Text(comment.text)
            ],
          ),
        )
      ],
    ),
  );
}

getUser(String commentOwner) async{
  user =  await UsersService.findUser(userId: commentOwner);
}