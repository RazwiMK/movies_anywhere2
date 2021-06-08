import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_anywhere/description.dart';

class SearchPage extends StatefulWidget {
  @override
  createState() => new _SearchPage();
}

//get the movielist from search term
Future<Map> fetchMovies(String searchTerm, int page) async {
  final response = await http.get(
      "https://api.themoviedb.org/3/search/movie?api_key=f9fea204b60058a665990757fcea5089&language=en-US&query=" +
          searchTerm +
          "&page=" +
          page.toString() +
          "&include_adult=false");
  print(response.body);
  return json.decode(response.body);
}

class _SearchPage extends State<SearchPage> {
  // ignore: deprecated_member_use
  List _movieData = new List();
  int _totalPages;
  int _page = 1;
  bool _noResults = false;
  String _searchTerm = "";
  TextEditingController _inputController =
      new TextEditingController(); //used to clear the search text
  FocusNode _inputFocus =
      new FocusNode(); //used to focus input when search cleared

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: new TextField(
            controller: _inputController,
            focusNode: _inputFocus,
            autofocus: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
            ),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            onSubmitted: (String term) {
              _page = 1;
              _searchTerm = term;
              // ignore: deprecated_member_use
              _movieData = new List();
              _noResults = false;
              _getMovies(term);
            }),
        actions: <Widget>[
          _showClearSearch(),
        ],
      ),
      body: _createBody(),
    );
  }

  void _getMovies(String term) {
    if (term != null || term != "") {
      fetchMovies(term, _page++).then((Map map) {
        setState(() {
          _totalPages = map['total_pages'];
          List data = map['results'];

          if (data != null && data.isNotEmpty) {
            if (_movieData != null)
              _movieData.addAll(data);
            else
              _movieData = data;
          } else {
            _noResults = true;
          }
        });
      });
    }
  }

  Widget _createGrid() {
    if (_movieData == null)
      return new Container();
    else if (_movieData.isEmpty)
      return new Center(
        child: Text('No results'),
      );
    List items = ['results'];

    return ListView.builder(
        itemCount: _movieData.length,
        // ignore: missing_return
        itemBuilder: (context, index) {
          if (_movieData[index]['backdrop_path'].toString() != 'null') {
            return _createcard(_movieData[index]);
          }
        });
  }

  // ignore: missing_return
  Widget _createcard(item) {
    // ignore: non_constant_identifier_names
    var MovieName = item['original_title'];
    // ignore: non_constant_identifier_names
    var MovieImage = item['backdrop_path'];
    return Card(
        child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage('https://image.tmdb.org/t/p/w500' +
                            MovieImage.toString())),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    MovieName.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Description(
                            name: item['original_title'],
                            bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                item['backdrop_path'],
                            posterurl: 'https://image.tmdb.org/t/p/w500' +
                                item['poster_path'],
                            description: item['overview'],
                            vote: item['vote_average'].toString(),
                            launch_on: item['release_date'].toString(),
                          )));
            }));
  }

  Widget _createBody() {
    if (_searchTerm == "")
      return Center(
        child: Text('Search movies'),
      );

    if (_noResults)
      return Center(
          child: Text(
        'No movies found',
      ));

    if (_movieData != null && _movieData.isNotEmpty)
      return _createGrid();
    else
      return Center(
        child: CircularProgressIndicator(),
      );
  }

  Widget _showClearSearch() {
    if (_searchTerm != "") {
      return new IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          _searchTerm = "";
          _inputController.clear();
          FocusScope.of(context).requestFocus(_inputFocus);
        },
      );
    }
    return Container();
  }
}
