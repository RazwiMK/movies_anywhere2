import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_anywhere/description.dart';
import 'package:movies_anywhere/text.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_api/tmdb_api.dart';
import 'package:movies_anywhere/trailer.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  TrendingMovies({
    Key key,
    this.trending,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            modified_text(
              text: 'Trending Movies',
              size: 26,
              color: Colors.white,
            ),
            Container(
              height: 270,
              child: ListView.builder(
                  itemCount: trending.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //Navigator.push(
                        //context,
                        //MaterialPageRoute(
                        //  builder: (context) =>
                        //Trailer(movieID: trending[index]['id']),
                        //),
                        //);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: trending[index]['title'],
                                      bannerurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['backdrop_path'],
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path'],
                                      description: trending[index]['overview'],
                                      vote: trending[index]['vote_average']
                                          .toString(),
                                      launch_on: trending[index]['release_date']
                                          .toString(),
                                    )));
                      },
                      child: trending[index]['title'] != null
                          ? Container(
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    trending[index]
                                                        ['poster_path']))),
                                  ),
                                  Container(
                                    child: modified_text(
                                      text: trending[index]['title'] != null
                                          ? trending[index]['title']
                                          : 'loading',
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    );
                  }),
            )
          ],
        ));
  }
}
