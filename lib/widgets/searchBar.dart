import 'package:flutter/material.dart';
import 'package:lostandfound/models/publications.dart';
import 'package:lostandfound/services/service.dart';

var backendManager = BackendManager();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost and found'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
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
                        hintText: 'rechercher',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/************************************/
class CustomSearchDelegate extends SearchDelegate {
  late Future<List<Publication>> _allPublications = backendManager.getPublications(query);

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
          return snapshot.data!.isEmpty ? Center(child: Text("Nothing found"),) :
            ListView.builder(
            itemCount: snapshot.data!.indexOf(snapshot.data!.last) + 1,
            itemBuilder: (BuildContext context, int index) {
              var pub = snapshot.data!.elementAt(index);
              return ListTile(
                leading: Icon(Icons.search),
                title: Text(pub.title),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: Center(
                        child: Text('hello, u pressed me'),
                      )),
                    ),
                  );
                },
              );
            },
          );
        } else if(snapshot.data!.isEmpty){
          return Center(child: Expanded(child: Text('nothing'),));
        }
        else{
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
          return snapshot.data!.isEmpty ? Center(child: Text("Nothing found"),) :
            ListView.builder(
            itemCount: snapshot.data!.indexOf(snapshot.data!.last) + 1,
            itemBuilder: (BuildContext context, int index) {
              var pub = snapshot.data!.elementAt(index);
              return ListTile(
                leading: Icon(Icons.search),
                title: Text(pub.title),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: Center(
                            child: Text('hello, u pressed me'),
                          )),
                    ),
                  );
                },
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
