import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocode/geocode.dart';
import 'package:latlong2/latlong.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

//try using MAPBOX

class _MapScreenState extends State<MapScreen> {

  LatLng center = LatLng(34.4394, 9.490272);
  late LatLng point = LatLng(50, 50);
  Address location = Address(city: "",region: "",countryName: "");
  String locationString = "";
  GeoCode geoCode = GeoCode();
  var coordinates = Coordinates();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              nePanBoundary: LatLng(35, 10),
              swPanBoundary: LatLng(34, 9),
              onTap: (p,latlng) async {
                try{
                  location = await geoCode.reverseGeocoding(latitude: latlng.latitude, longitude: latlng.longitude);
                  locationString = "${location.countryName ?? ""} ${location.city ?? ""} ${location.region ?? ""}";
                  setState(() {
                    point = latlng;
                    print(point);
                  });
                }
                catch(Exception){
                  showDialog(context: context, builder: (context){return AlertDialog(title: Text("Une erreur s'est produite. Réessayez encore."),alignment: Alignment.bottomCenter,);});
                }

              },
              center: center,
              zoom: 6.5
          ),
          layers: [

            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a','b','c'],
            ),
            MarkerLayerOptions(
                markers: [
                  Marker(
                      width: 100,
                      height: 100,
                      point: point,
                      builder: (ctx)=> Icon(Icons.location_on,color: Colors.red,)
                  ),
                ]
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      locationString != "" ? locationString: "Choisissez la localisation",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Card(
                    child: TextButton.icon(
                      onPressed: (){
                        Navigator.pop(context,[locationString,location]);
                      },
                      icon: Icon(Icons.location_on),
                      label: Text("Confirmer"),
                    )
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}


/*
tuple: ^2.0.0
transparent_image: ^2.0.0
async: ^2.8.2
flutter_image: ^4.1.0
  vector_math: ^2.1.1
  proj4dart: ^2.0.0
  meta: ^1.7.0
  collection: ^1.15.0
*/