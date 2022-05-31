
import 'package:flutter/material.dart';
import 'package:lostandfound/settings/colors.dart';
import 'package:lostandfound/widgets/painter.dart';

class PremiumPurchase extends StatefulWidget {
  const PremiumPurchase({Key? key}) : super(key: key);

  @override
  _PremiumPurchaseState createState() => _PremiumPurchaseState();
}

class _PremiumPurchaseState extends State<PremiumPurchase> {
  int chosen = -1;
  List colors = [lightGrey,lightGrey,lightGrey];
    final List<List<dynamic>> abonnements = [["Mentuelle","2DT/mois"],["Semi-Annuelle","10DT/6mois"],["Annuelle","18DT/an"]];
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [
          Column(
            children: [
              CustomPaint(
                child: Container(
                  height: 175,
                ),
                painter: CurvePainter(),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Title("Publications Premium"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                        child: Description("Vos publications auront plus de visibilité donc vous aurez plus de chance de trouvez votre objet perdu ou le propriétaire de l'objet trouvé."),
                      ),
                      SizedBox(height: 10,),
                      Title("Recevoir des notifcations"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                        child: Description("Vos recevez des notifications pour les publicat ions portants sur des objets qui ressemblent à celui que vous cherchez."),
                      ),
                      SizedBox(height: 10,),
                      Title("Eliminer les publicités"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                        child: Description("Vous n'aurez plus de publicités dans l'applicat ion Lost And Found."),
                      ),
                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20,left: 10,right: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.2,
                          child: GridView.builder(
                              itemCount: 3,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (contex,index){
                                print(abonnements[index]);
                                return InkWell(
                                  child: PurchaseCard(abonnements[index][0], abonnements[index][1], MediaQuery.of(context).size.width*0.25, colors[index]),
                                  onTap: (){
                                    setState(() {
                                      if(chosen == -1){
                                        colors[index]= Color(0xffEEB609);
                                        //colors[index] = Colors.blue.shade400;
                                        chosen = index;
                                      }
                                      else if (chosen == index){
                                        colors[index] = lightGrey;
                                        chosen =-1;
                                      }
                                    });
                                  },
                                );
                              }
                          ),
                        ),
                      ),

                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          height:  MediaQuery.of(context).size.width*0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: chosen!=-1 ? Color(0xffEEB609) : lightGrey,
                            border: Border.all(color: primaryGrey),
                          ),

                          child: ElevatedButton(
                            onPressed: (){},
                            child: Text("Paiement", style: TextStyle(color: chosen!=-1 ? Colors.white : primaryGrey),),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              shadowColor:MaterialStateProperty.all(Colors.transparent)
                            ),
                          ),
                        ),

                      ),
                    ],
                ),
              ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.125,
              child: Row(
                children: [
                  Icon(Icons.star, color : Color(0xffEEB609),size: 35,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  Text(
                    "Devenir Premium",
                    style: TextStyle(
                        color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.08),
                  ),

                ],
              )
          ),
          Positioned(
              top: 30,
              left: 5,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
          ),
        ],
      ),
    );
  }
}

Widget Title(String text){
  return Row(
    children: [
      Icon(Icons.check_box_outlined, color: Color(0xffEEB609),),
      SizedBox(width: 8,),
      Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget Description(String text){
  return Text(
    text,
    style: TextStyle(fontSize: 14),
  );
}

Widget PurchaseCard(String title,String price, double width, color){
  return Container(
    width: width,
    height: width*1.2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: primaryGrey),
      color: color,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: 14, color: color == lightGrey ? Colors.black : Colors.white)),
        SizedBox(height: 20),
        Text(price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color == lightGrey ? Colors.black : Colors.white),),
      ],
    ),
  );
}
