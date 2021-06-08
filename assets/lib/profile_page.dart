import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_anywhere/description.dart';
import 'package:movies_anywhere/models/user_model.dart';
import 'package:movies_anywhere/services/authentication_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final userRef = FirebaseFirestore.instance.collection("users");
  UserModel _currentUser;

  String _uid;
  String _username;
  String _email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    UserModel currentUser = await context
        .read<AuthenticationService>()
        .getUserFromDB(uid: auth.currentUser.uid);

    _currentUser = currentUser;

    print("${_currentUser.username}");

    setState(() {
      _uid = _currentUser.uid;
      _username = _currentUser.username;
      _email = _currentUser.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProfilePage"),
        centerTitle: false,
      ),
      body: _currentUser == null
          ? Center(child: CircularProgressIndicator())
          : Column(children: [
              SizedBox(height: 10.0),
              Text(
                "$_username",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 10.0),
              Text(
                "uid: $_uid",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 10.0),
              Text(
                "email: $_email",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
              Center(
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.orange,
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                  },
                ),
              ),
              Center(
                child: Text(
                  "WatchList",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Container(
                height: 400,
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection("users")
                        .doc("$_uid")
                        .collection("subCollectionPath")
                        .snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var doc = snapshot.data.docs;

                        return new ListView.builder(
                            itemCount: doc.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: NetworkImage(doc[index]
                                                    .data()['bannerurl']),
                                              ))),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          doc[index].data()['name'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                  /* onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Description(
                                                    name: doc[index]
                                                        .data()['name']
                                                        .toString(),
                                                    bannerurl: doc[index]
                                                        .data()['bannerurl'],
                                                    //posterurl: 'https://image.tmdb.org/t/p/w500' +
                                                    //  item['poster_path'],
                                                    description: doc[index]
                                                        .data()['description']
                                                        .toString(),
                                                    //vote: item['vote_average'].toString(),
                                                    //launch_on: item['release_date'].toString(),
                                                  )));
                                    }*/
                                ),
                              );
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ]),
    );
  }
}
