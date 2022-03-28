import 'package:flutter/material.dart';
import 'package:lostandfound/model/publication.dart';

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
                  SizedBox(width: 20,),
                  Text('Filtres'),
                ],
              ),
              ),
          ],
        ),
      ),
    );
  }
}


List<Pub> searchTerms = [
  Pub('hello', "https://images.unsplash.com/photo-1604537529428-15bcbeecfe4d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80"),
  Pub('missing phone', "https://images.unsplash.com/photo-1604537529428-15bcbeecfe4d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80"),
  Pub("money lost", "https://images.unsplash.com/photo-1604537529428-15bcbeecfe4d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80"),
];

class CustomSearchDelegate extends SearchDelegate {

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
    //this should have the last of results coming from the backend
    List<Pub> matchQuery = [];
    for (var pub in searchTerms) {
      if (pub.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(pub);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        var title = result.title;
        return ListTile(
          leading: Image.network(
            result.url,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
          title: Text(result.title),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(body: Center(child: Text('hello, u pressed $title'),)),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //this should have a list a sugg of the available pubs in that page
    List<Pub> matchQuery = [];
    for (var pub in searchTerms) {
      if (pub.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(pub);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        var title = result.title;
        return ListTile(
          leading: Image.network(
            result.url,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
          title: Text(result.title),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(body: Center(child: Text('hello, u pressed $title'),)),
              ),
            );
          },
        );
      },
    );
  }
}
