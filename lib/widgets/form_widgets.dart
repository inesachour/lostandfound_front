import 'package:flutter/material.dart';

Widget DropDown({required onchanged, validator, required List<String> items}) {
  return DropdownButtonFormField<String>(
    hint: Text("Categorie"),

    items: items.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: onchanged,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      fillColor: Color(0xfffafafa),
      filled: true,
    ),
    icon: Icon(Icons.keyboard_arrow_down_rounded),
    validator: validator,
  );
}

//------------------------------------------------------//

Widget TextInputField({controller, validator, maxLines, label}) {
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

//-----------------------------------------------------//

Widget RegisterInputField(
    {controller,
    validator,
    maxLines,
    keyboardType,
    obscureText,
    decoration}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    maxLines: maxLines,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: decoration,
  );
}

//decoration
InputDecoration buildInputDecoration(IconData icons, String hinttext, String label, Widget? widget) {
  return InputDecoration(
    fillColor: Color(0xfffafafa),
    filled: true,
    label: Text(label),
    hintText: hinttext,
    prefixIcon: Icon(icons),
    suffixIcon: widget,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.blue, width: 1.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
  );
}
