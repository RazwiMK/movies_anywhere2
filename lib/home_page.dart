import 'package:flutter/material.dart';
import 'package:movies_anywhere/json/home_json.dart';
import 'package:movies_anywhere/text.dart';
import 'package:movies_anywhere/toprated.dart';
import 'dart:ui';
import 'package:movies_anywhere/trendingmovies.dart';
import 'package:movies_anywhere/tv.dart';

import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = 'f9fea204b60058a665990757fcea5089';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOWZlYTIwNGI2MDA1OGE2NjU5OTA3NTdmY2VhNTA4OSIsInN1YiI6IjYwYjRmOGRlYWJmOGUyMDA1OTZhNzc1ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lma501-V8K4_FMeSUfe_uhl1oRMxunRnS9YPuw1roUo';

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmbdWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingresult = await tmbdWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmbdWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmbdWithCustomLogs.v3.tv.getPouplar();

    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: modified_text(
          text: 'Flutter Movie App',
        ),
      ),
      body: ListView(
        children: [
          TV(
            tv: tv,
          ),
          TopRated(
            toprated: topratedmovies,
          ),
          TrendingMovies(trending: trendingmovies),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
