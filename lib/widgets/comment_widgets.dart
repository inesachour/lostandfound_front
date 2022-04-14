
import 'package:flutter/material.dart';
import 'package:lostandfound/settings/colors.dart';

Widget addComment({required controller}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
    child: TextFormField(
      controller: controller,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.send),
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