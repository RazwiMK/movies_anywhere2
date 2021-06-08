/*import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_anywhere/description.dart';
import 'package:movies_anywhere/text.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_api/tmdb_api.dart';

// ignore: must_be_immutable
class Trailer extends StatelessWidget {
  // ignore: deprecated_member_use
  List trailer;
  int movieID;
  Future<Map> fetchMovies(int movieID) async {
    final response = await http.get("https://api.themoviedb.org/3/movie/" +
        movieID.toString() +
        "/videos?api_key=f9fea204b60058a665990757fcea5089&language=en-US");
    print(response.body);
    return json.decode(response.body);
  }

  void _gettrailer(int movieID) {
    fetchMovies(movieID).then((Map map) {
      List data = map['results'];

      trailer = data;
      print(trailer);
    });
  }

  Trailer({
    Key key,
    this.movieID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List trailer = new List();
    print(movieID);
    _gettrailer(movieID);
    return ListView.builder(
        itemCount: trailer.length,
        // ignore: missing_return
        itemBuilder: (context, index) {
          print(index);
          return Description(
              video: 'https://www.youtube.com/watch?v=' +
                  trailer[index]['key'].toString());
        });
  }
}*/
