import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/constants/categories.dart';
import 'package:lostandfound/services/pubservices.dart';
import 'package:lostandfound/widgets/form_widgets.dart';
import 'package:lostandfound/widgets/map.dart';
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
  LatLng? _location;
  TextEditingController _filterLocationController = TextEditingController();

  //DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  DateTimeRange? _dateRange;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    initializeDateFormatting();

    List _filterCategoriesObjects = [];

    categories.forEach((element) {
      _filterCategoriesObjects.add({
        "display": element,
        "value": element,
      });
    });

    _show() async {
      var loc = await showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return MapScreen();
          }
      );
      setState(() {
        print(loc[1]);
        _filterLocationController.text = loc[0];
        //print(_filterLocationController.text);
        _location = loc[1];
      });
    }

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

              TextFormField(
                controller: _filterLocationController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  label: Text("Localisation"),
                  fillColor: Color(0xfffafafa),
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      _show();
                    },
                  ),
                ),
              ),


              TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      label: Text("Date"),
                      fillColor: Color(0xfffafafa),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.date_range_outlined),
                        onPressed: () async {
                          print("ok");
                          _dateRange = await showDateRangePicker(
                            context: context,
                            //initialDate: _date,
                            firstDate: DateTime(2012),
                            lastDate: DateTime.now(),
                            cancelText: "Annuler",
                            confirmText: "Confirmer",
                            helpText: "Choisir la date",
                            errorFormatText: "Format invalide",
                            errorInvalidText: "Texte invalide",
                          );
                          setState(() {
                            print(_dateRange);
                           // _dateController.text = DateFormat('EEEE d MMMM yyyy','fr').format(_date);
                            //print(_date);
                            String _date;
                            if(_dateRange!.start != _dateRange!.end){
                              _date = DateFormat('EEEE d MMMM yyyy', 'fr').format(_dateRange!.start)+" - "+ DateFormat('EEEE d MMMM yyyy', 'fr').format(_dateRange!.end);
                            }
                            else{
                              _date =  DateFormat('EEEE d MMMM yyyy', 'fr').format(_dateRange!.start);
                            }
                            _dateController.text = _date;
                          });
                        },
                      ),
                    ),
                  ),

              ElevatedButton(
                child: Text("Filtrer"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  fixedSize: MaterialStateProperty.all(Size(width*0.7,40))
                ),
                onPressed: () async {
                  var pubs = pubServices.filterPublications(categories: selectedCategories, type: widget.type, latlng: _location, dateRange: _dateRange);
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
