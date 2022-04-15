
import 'package:flutter/material.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/services/comments_service.dart';
import 'package:lostandfound/settings/colors.dart';

Widget addComment({required TextEditingController controller}){
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
              var ok = await CommentsService.addComment(
                  text: controller.text,
                  owner: User(firstName: "test", lastName: "test", phone: "test", email: "test", photo: "test")
              );
              print(ok);
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