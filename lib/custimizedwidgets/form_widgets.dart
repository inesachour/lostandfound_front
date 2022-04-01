import 'package:flutter/material.dart';



Widget DropDown({onchanged, validator}){
  return DropdownButtonFormField<String>(
    hint: Text("Categorie"),
    items: [
      DropdownMenuItem(child: Text("CIN"),value: "Category1",),
      DropdownMenuItem(child: Text("Telephone"), value: "Category2"),
    ],
    onChanged: onchanged,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      fillColor: Color(0xfffafafa),
      filled: true,
    ) ,
    icon: Icon(Icons.keyboard_arrow_down_rounded),
    validator: validator,
  );
}



//------------------------------------------------------//

Widget TextInputField({controller, validator, maxLines, label}){
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      fillColor: Color(0xfffafafa),
      filled: true,
      label: Text(label),
    ),
    validator: validator,
    maxLines: maxLines,
  );
}
