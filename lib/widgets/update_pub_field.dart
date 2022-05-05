// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lostandfound/settings/config.dart';

class UpdatePubField extends StatefulWidget {
  String _label;
  String content = "";
  void Function(String)? getContent;

  UpdatePubField(this._label, this.content,
      {
        this.getContent,
        });

  @override
  State<UpdatePubField> createState() => _UpdatePubFieldState();
}

class _UpdatePubFieldState extends State<UpdatePubField> {
  FocusNode _focusNode = FocusNode();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: context.width * 0.05,
              left: context.width * 0.04,
              right: context.width * 0.04),
          child: Text(
            widget._label + " :",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                bottom: context.width * 0.08,
                left: context.width * 0.04,
                right: context.width * 0.04),
            child: TextFormField(
              focusNode: _focusNode,
              initialValue: widget.content,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(48.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                fillColor: Colors.white12,
                filled: true
              ),
              onChanged: (value) {
                setState(() {
                  widget.content = value;
                  widget.getContent!(widget.content);
                });
              },
              onEditingComplete: () {
                setState(() {
                  _focusNode.unfocus();
                });
              },
            )),
      ],
    );
  }
}
