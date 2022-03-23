import 'package:flutter/material.dart';


class AddPublicationForm extends StatefulWidget {
  const AddPublicationForm({Key? key}) : super(key: key);

  @override
  State<AddPublicationForm> createState() => _AddPublicationFormState();
}

class _AddPublicationFormState extends State<AddPublicationForm> {

  DateTime? _date;
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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

                  InputDatePickerFormField(
                    firstDate: DateTime(DateTime.now().year - 120),
                    lastDate: DateTime.now(),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffd4d8dc), width: 2),
                          ),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add_a_photo_rounded,size: 50,color: Color(0xffd4d8dc),),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffd4d8dc), width: 2),
                          ),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add_a_photo_rounded,size: 50,color: Color(0xffd4d8dc),),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.add,color: Color(0xff707070),),
                    label: Text("add photos",style: TextStyle(color: Color(0xff707070)),),
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
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
                    onPressed: () async {
                      var i = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2010), lastDate: DateTime.now());
                      setState(() {
                       _date = i;
                      });
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