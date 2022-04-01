// ignore_for_file: curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/models/user.dart';

class PubServices
{
  // ignore: prefer_final_fields
  static List<Publication> _publications = [
    Publication("Téléphone S8 plus",
        "desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption ",
        "Found", DateTime.tryParse("2021-10-26 20:18")??DateTime.now(),
        Location("Point",[33.8805705,10.84553]),
        ["https://c2.lestechnophiles.com/images.frandroid.com/wp-content/uploads/2017/09/samsung-galaxy-s8-18.jpg?resize=320,300"],
      User("amal","sammari","26 524 125","sammari_a@outlook.fr", "http://www.goodmorningimagesdownload.com/wp-content/uploads/2020/11/Stylish-Girls-Whatsapp-DP-Profile-3.jpg")
    ),
    Publication("Caméra Canon",
        "desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption ",
        "Found", DateTime.tryParse("2021-10-26 20:18")??DateTime.now(),
        Location("Point",[36.8441363,10.1967341]),
        ["https://images.indianexpress.com/2018/12/Canon-EOS-R-1.jpg"],
      User("safé","abidi","26 524 125","sammari_a@outlook.fr"
          ,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDChPwjoYrt8i96FEtFeAeGqlrKPHYCEXu6A&usqp=CAU")
    ),
    Publication("Iphone 13 pro",
        "desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption ",
        "Lost", DateTime.tryParse("2021-10-26 20:18")??DateTime.now(),
        Location("Point",[36.7671689,10.2798129]),
        ["https://cdn.pocket-lint.com/r/s/1200x/assets/images/160362-phones-news-hands-on-considering-the-alpine-green-iphone-13-pro-here-is-what-it-looks-like-image1-v9jlvle0qb.jpg"],
      User("raoua","trimech","26 524 125","raoua@outlook.fr",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh9Kifz56BOXZ6LOyPQAt3w_qb2DCR9WwnXA&usqp=CAU"
    )),
    Publication("Samsung S20",
        "desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption desciption ",
        "Lost", DateTime.parse("2021-10-26"),
        Location("Point",[36.6776341,10.146192]),
        ["https://cdn.pocket-lint.com/r/s/970x/assets/images/153997-phones-review-hands-on-samsung-galaxy-s20-fe-image1-n1j5wpamd4.jpg"],
      User("ines","Achour","26 524 125","noussa@outlook.fr"
          ,"https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/11/1080p-Whatsapp-Dp-Profile-Images-For-Girl-pics.gif")
    ),
  ];

  static List<Publication> getLostPub()
  {
    List<Publication> _lostPublications = [];
    _publications.forEach((element) {
      if(element.type=="Lost")
        _lostPublications.add(element);
    });
    return _lostPublications;
  }
  static List<Publication> getFoundPub()
  {
    List<Publication> _foundPublications = [];
    _publications.forEach((element) {
      if(element.type=="Found")
        _foundPublications.add(element);
    });
    return _foundPublications;
  }

}