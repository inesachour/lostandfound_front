import 'package:flutter/material.dart';
import 'package:lostandfound/models/publication.dart';
import 'package:lostandfound/services/backend_manager.dart';

var backendManager = BackendManager();

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: TextField(
        showCursor: false,
        readOnly: true,
        onTap: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          );
        },
        decoration: InputDecoration(
          hintText: 'Rechercher',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

/************************************/
class CustomSearchDelegate extends SearchDelegate {
  late Future<List<Publication>> _allPublications =
      backendManager.getPublications(query);

  @override
  String get searchFieldLabel => 'Rechercher';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Publication>>(
      future: _allPublications,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text("Aucune publication trouvée"),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.indexOf(snapshot.data!.last) + 1,
                  itemBuilder: (BuildContext context, int index) {
                    var pub = snapshot.data!.elementAt(index);
                    return ListTile(
                      leading: pub.images.length > 0
                          ? Image.network(
                              pub.images[0].url,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            )
                          : SizedBox(
                              height: 20,
                            ),
                      title: Text(pub.title),
                      subtitle: Text(pub.description),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                                body: Center(
                              child: Text('hello, u pressed ${pub.title}'),
                            )),
                          ),
                        );
                      },
                    );
                  },
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _allPublications = backendManager.getPublications(query);
    return FutureBuilder<List<Publication>>(
      future: _allPublications,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text("Aucune publication trouvée"),
                )
              : ListView.builder(
                  //shows last 5 pubs if query (search term) is empty
                  itemCount: query.length > 0 ? snapshot.data!.indexOf(snapshot.data!.last) + 1 : 5,
                  itemBuilder: (BuildContext context, int index) {
                    var pub = snapshot.data!.elementAt(index);
                    return ListTile(
                      leading: pub.images.length > 0
                          ? Image.network(
                              pub.images[0].url,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            )
                          : SizedBox(
                              height: 20,
                            ),
                      title: Text(pub.title),
                      subtitle: Text(pub.description),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                                body: Center(
                              child: Text('hello, u pressed ${pub.title}'),
                            )),
                          ),
                        );
                      },
                    );
                  },
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
