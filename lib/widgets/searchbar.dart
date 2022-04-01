// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class Searchbar extends StatefulWidget {
  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: TextField(
        cursorWidth: 1.5,
        cursorColor: Colors.grey,
        controller: _controller,
        decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear,
            color: Colors.black87,
          ),
          onPressed: () {
            setState(() {
              _controller.text="";
            });
          },
        ),
        prefixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
      )),
    );
  }
}
