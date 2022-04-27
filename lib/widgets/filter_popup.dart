import 'package:flutter/material.dart';
import 'package:lostandfound/constants/categories.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/widgets/form_widgets.dart';

class FilterPopUp extends StatefulWidget {
  const FilterPopUp({Key? key,required String type}) : super(key: key);

  @override
  _FilterPopUpState createState() => _FilterPopUpState();
}

class _FilterPopUpState extends State<FilterPopUp> {

  PubServices pubServices = PubServices();
  String _category = "";


  @override
  Widget build(BuildContext context) {
  print("y=test");
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
                onPressed: () async {
                  print("gkodgkopdghijodghk,o");
                  var pubs = pubServices.filterPublications(category: _category, type: "LOST");
                  Navigator.pop(context,["Lost",pubs]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
