import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies_anywhere/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_anywhere/services/authentication_service.dart';
import 'package:provider/provider.dart';

class Description extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String name, description, bannerurl, posterurl, vote, launch_on, video;

  Description({
    Key key,
    this.name,
    this.description,
    this.bannerurl,
    this.posterurl,
    this.vote,
    this.launch_on,
    this.video,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  )),
                  Positioned(
                      bottom: 10,
                      child: modified_text(
                        text: '  ⭐Average Rating - ' + vote,
                        size: 18,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: modified_text(
                text: name != null ? name : 'Not Loaded',
                color: Colors.white,
                size: 24,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: modified_text(
                text: 'Releasing On - ' + launch_on,
                color: Colors.white,
                size: 14,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text(
                  'Watch Trailer',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  launch(video);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text(
                  'Add to watchlist',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  createMovieInFirestore(context);
                },
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    child: modified_text(
                      text: description,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  createMovieInFirestore(BuildContext context) async {
    context.read<AuthenticationService>().addMovieToDB(
          name: name,
          description: description,
          bannerurl: bannerurl,
        );
  }
}
