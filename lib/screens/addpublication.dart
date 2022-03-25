
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lostandfound/custimizedwidgets/map.dart';
import 'package:lostandfound/models/categories.dart';
import 'package:lostandfound/services/backend_manager.dart';
import 'package:lostandfound/services/image_picker.dart';

class AddPublicationForm extends StatefulWidget {
  const AddPublicationForm({Key? key}) : super(key: key);

  @override
  State<AddPublicationForm> createState() => _AddPublicationFormState();
}

class _AddPublicationFormState extends State<AddPublicationForm> {

  var _dateFormat = DateFormat("dd-MM-yyyy");
  late String _dateString;
  DateTime _date = DateTime.now();
  ImagePickerService _imagePickerService = ImagePickerService();
  List<File>? _photos = [];
  TextEditingController _locationController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  BackendManager _backendManager = BackendManager();

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
      });
    }

    _dateString = _dateFormat.format(_date);
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
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: "ok",
                    items: [
                      DropdownMenuItem(child: Text("Test1"),value: "ok",),
                      DropdownMenuItem(child: Text("Test1111"), value: "ok2"),
                    ],
                    onChanged: (item){},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      fillColor: Color(0xfffafafa),
                      filled: true,
                    ) ,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        fillColor: Color(0xfffafafa),
                        filled: true,
                        label: Text("Titre")
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        label: Text("Description"),
                      fillColor: Color(0xfffafafa),
                      filled: true,
                    ),
                  ),

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
                            _dateString = _dateFormat.format(_date);
                            _dateController.text = _dateString;
                          });
                        },
                      ),
                    ),

                  ),

                  SizedBox(height: 30,),

                  SizedBox(
                    height: _photos == null || _photos!.length == 0 ? 0 :(((_photos!.length-1)/2).toInt()+1)*160,
                    child: _photos==null ? Text("") : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _photos!.length,
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
                              child: Image.file(_photos![index], fit: BoxFit.cover,),
                            ),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    _photos!.removeAt(index);
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
                    child: (_photos != null && _photos!.length >= 4) ? null : TextButton.icon(
                      onPressed: () async{
                        var _images = await _imagePickerService.getPhotosFromGallery();
                        if(_images!=null){
                          setState(() {
                            if(_photos!=null){
                              _images.forEach((e) {
                                _photos!.add(e);
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
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

                  SizedBox(height: 30,),

                  ElevatedButton(
                    child: Text("Ajouter la publication"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff53abe2),),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      fixedSize: MaterialStateProperty.all(Size(width*0.9,50)),
                    ),
                    onPressed: (){
                      _backendManager.addPublication(Publication(title: _titleController.text, description: _descriptionController.text, user: "test"));
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