class Pub{
  String title;
  String url;

  Pub( this.title, this.url);

  factory Pub.fromJson(Map<String, dynamic> item) {
    return Pub(
        item['title'],
        item['url'],
        );
  }
}



