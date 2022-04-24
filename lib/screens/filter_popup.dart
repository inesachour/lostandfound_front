import 'package:flutter/material.dart';
import 'package:lostandfound/constants/categories.dart';
import 'package:lostandfound/widgets/form_widgets.dart';

class FilterPopUp extends StatefulWidget {
  const FilterPopUp({Key? key}) : super(key: key);

  @override
  _FilterPopUpState createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp> {
  @override


  Widget build(BuildContext context) {

    String _category = "";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Form(
          child: Column(
            children: [
              Text("Choisir une categorie"),
              DropDown(
                  onchanged: (item){
                    setState(() {
                      _category = item.toString();

                    });
                  },
                  items: categories
              ),

              ElevatedButton(
                child: Text("Filtrer"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  fixedSize: MaterialStateProperty.all(Size(width*0.7,40))
                ),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
