

import 'package:flutter/material.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/services/comments_service.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
              final SharedPreferences prefs = await _prefs;
              var commentOwner = prefs.getStringList("user");
              var ok = await CommentsService.addComment(
                  text: controller.text,
                  commentOwner: commentOwner![0],
                  publication: publication,
              );
              controller.clear();
        }
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fillColor: Colors.white,
        filled: true,
        focusColor: Colors.white,
        hintText: " . . .",
      ),
    ),
  );
}