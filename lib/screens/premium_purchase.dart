import 'package:flutter/material.dart';

class PremiumPurchase extends StatefulWidget {
  const PremiumPurchase({Key? key}) : super(key: key);

  @override
  _PremiumPurchaseState createState() => _PremiumPurchaseState();
}

class _PremiumPurchaseState extends State<PremiumPurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Title("Publications Premium"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                child: Description("Vos publications auront plus de visibilité donc vous aurez plus de chance de trouvez votre objet perdu ou le propriétaire de l'objet trouvé."),
              ),
              Title("Publications Premium"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                child: Description("Vos publications auront plus de visibilité donc vous aurez plus de chance de trouvez votre objet perdu ou le propriétaire de l'objet trouvé."),
              ),
              Title("Publications Premium"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 30),
                child: Description("Vos publications auront plus de visibilité donc vous aurez plus de chance de trouvez votre objet perdu ou le propriétaire de l'objet trouvé."),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: Text("2dt/mois"),
                  onPressed: (){

                  },
                ),
              ),
            ],
        ),
      ),
    );
  }
}

Widget Title(String text){
  return Row(
    children: [
      Icon(Icons.verified, color: Colors.green,),
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
