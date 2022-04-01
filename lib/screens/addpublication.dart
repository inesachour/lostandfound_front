import 'dart:io';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:lostandfound/custimizedwidgets/form_widgets.dart';
import 'package:lostandfound/custimizedwidgets/map.dart';
import 'package:lostandfound/services/backend_manager.dart';
import 'package:lostandfound/services/image_picker.dart';

class AddPublicationForm extends StatefulWidget {
  const AddPublicationForm({Key? key}) : super(key: key);

  @override
  State<AddPublicationForm> createState() => _AddPublicationFormState();
}

class _AddPublicationFormState extends State<AddPublicationForm> {

  //Form Validation varaibles
  final _formKey = GlobalKey<FormState>();

  var validator = (value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est obligatoire';
    }
    return null;
  };

  //Date variables
  //var _dateFormat = DateFormat("dd-MM-yyyy");
  late String _dateString;
  DateTime _date = DateTime.now();


  //Images variables
  ImagePickerService _imagePickerService = ImagePickerService();
  List<File> _photos = [];

  //Controllers
  TextEditingController _locationController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  //Backend Manager
  BackendManager _backendManager = BackendManager();

  //Category varaibles
  String _category = "";

  late LatLng _location;

  @override
  Widget build(BuildContext context) {

    _show() async {
      var loc = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return MapScreen();
          }
      );
      setState(() {
        _locationController.text = loc[0];
        _location = loc[1];
      });
    }


    //_dateString = _dateFormat.format(_date);
    TextEditingController _dateController = TextEditingController(text: _dateString);

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff5f5f5),
        appBar: AppBar(
          backgroundColor: Color(0xff52aee5),
          leading: Icon(Icons.arrow_back),
          title: Text("Objet ??"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  DropDown(validator: validator, onchanged: (item){ setState(() { _category = item.toString(); });} ),

                  SizedBox(height: 20,),


                  TextInputField(controller: _titleController,validator: validator, maxLines: 1,label: "Titre"),

                  SizedBox(height: 20,),

                  TextInputField(controller: _descriptionController,validator: validator, maxLines: 6,label: "Description"),

                  SizedBox(height: 20,),

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
                          _date = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(2012),
                            lastDate: DateTime.now(),
                            cancelText: "Annuler",
                            confirmText: "Confirmer",
                            helpText: "Choisir la date",
                            errorFormatText: "Format invalide",
                            errorInvalidText: "Texte invalide",
                            fieldLabelText: "Entrer la date",
                          ) ?? DateTime.now();
                          setState(() {
                            _dateString = _date.toString() ;//_dateFormat.format(_date);
                            _dateController.text = _dateString;
                          });
                        },
                      ),
                    ),

                  ),

                  SizedBox(height: 30,),

                  SizedBox(
                    height:  _photos.length == 0 ? 0 :(((_photos.length-1)/2).toInt()+1)*160,
                    child: _photos==null ? Text("") : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _photos.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.2,
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffd4d8dc), width: 2),
                              ),
                              child: Image.file(_photos[index], fit: BoxFit.contain,),
                            ),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    _photos.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.close_rounded, color: Colors.red,),

                            ),
                          ]
                        );
                      },
                    ),
                  ),

                  Container(
                    child: ( _photos.length >= 4) ? null : TextButton.icon(
                      onPressed: () async{
                        var _images = await _imagePickerService.getPhotosFromGallery();
                        if(_images!=null){
                          setState(() {
                            if(_photos.length >0){
                              _images.forEach((e) {
                                _photos.add(e);
                              });
                            }else{
                              _photos = _images;
                            }
                          });
                        }
                      },
                      icon: Icon(Icons.add,color: Color(0xff707070),),
                      label: Text("ajouter des photos",style: TextStyle(color: Color(0xff707070)),),
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),
                  TextFormField(
                    controller: _locationController,
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
                    validator: validator,
                  ),

                  SizedBox(height: 30,),

                  ElevatedButton(
                    child: Text("Ajouter la publication"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff53abe2),),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      fixedSize: MaterialStateProperty.all(Size(width*0.9,50)),
                    ),
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        //_backendManager.addPublication(publicationModel.Publication(title: _titleController.text, description: _descriptionController.text,owner: "test", date: DateTime.now(),category: _category,location: publicationModel.Location(type: "point",coordinates: [11,11]),images: []));
                        _backendManager.addPublication(title: _titleController.text, description: _descriptionController.text, date: _dateString, category: _category, latlng: _location, images: _photos, owner: "test");
                      }

                      },
                  ),
                ],


              ),
            ),
          ),
        )
    );
  }
}