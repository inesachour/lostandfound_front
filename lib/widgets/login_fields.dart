// ignore_for_file: prefer_final_fields, prefer_const_constructors


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/settings/config.dart';

class LoginField extends StatefulWidget {
  String type;
  String hint;
  void Function(String)? getContent;
  LoginField({ required this.type,required this.hint,this.getContent});
  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  bool show = true;
  FocusNode _focusNode = FocusNode();
  TextEditingController? _controller ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height*0.025),
      width: context.width*0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]
      ),
      child: TextFormField(
        onChanged: (value){
          widget.getContent!(value);
        },
        textInputAction: TextInputAction.done,
        focusNode: _focusNode,
        onEditingComplete: () {
          setState(() {
            _focusNode.unfocus();
          });
        },
        controller : _controller ,
        obscureText: widget.type=="password"?show:false,
        keyboardType: widget.type=='email' ? TextInputType.emailAddress:TextInputType.text,
        decoration :InputDecoration(
          prefixIcon: widget.type=='password'?Icon(Icons.vpn_key_rounded):Icon(Icons.email,),
          suffixIcon: widget.type=='password' ? InkWell(
            splashColor: Colors.transparent,
            onTap: (){
              setState(() {
                show=!show;
              });
            },
              child: Icon(Icons.remove_red_eye_outlined)):null,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          hintText:widget.hint,
          hintStyle: TextStyle(
            color:Colors.grey[400],
            fontSize:  context.width*0.04,
          ),
        ),
      ),
    );
  }
}
