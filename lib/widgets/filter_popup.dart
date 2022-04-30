import 'package:flutter/material.dart';
import 'package:lostandfound/constants/categories.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/widgets/form_widgets.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class FilterPopUp extends StatefulWidget {
  FilterPopUp({Key? key,required this.type}) : super(key: key);

  String type;
  @override
  _FilterPopUpState createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp> {

  PubServices pubServices = PubServices();
  List selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    List _filterCategoriesObjects = [];

    categories.forEach((element) {
      _filterCategoriesObjects.add({
        "display": element,
        "value": element,
      });
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Form(
          child: Column(
            children: [
              Text("Choisir une categorie"),

              MultiSelectFormField(
                chipBackGroundColor: Colors.grey[200],
                chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.blue,
                checkBoxCheckColor: Colors.white,
                dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(
                  "Categorie",
                  style: TextStyle(fontSize: 16),
                ),
                dataSource: _filterCategoriesObjects,
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'Annuler',
                hintWidget: Text('Choisir une ou plusieurs categories'),
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    selectedCategories=value;
                  });
                },
              ),

              ElevatedButton(
                child: Text("Filtrer"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  fixedSize: MaterialStateProperty.all(Size(width*0.7,40))
                ),
                onPressed: () async {
                  var pubs = pubServices.filterPublications(categories: selectedCategories, type: widget.type);
                  Navigator.pop(context,[widget.type,pubs]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
