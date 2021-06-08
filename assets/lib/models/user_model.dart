import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String email;
  String uid;
  String username;
  DateTime timestamp;
  String name;
  String description;
  String bannerurl;

  UserModel({
    this.email,
    this.uid,
    this.username,
    this.timestamp,
    this.name,
    this.description,
    this.bannerurl,
  });

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["username"] = user.username;
    data["email"] = user.email;
    data["timestamp"] = user.timestamp;
    data["name"] = user.name;
    data["description"] = user.description;
    data["bannerurl"] = user.bannerurl;

    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.username = mapData["username"];
    this.email = mapData["email"];
    this.name = mapData["name"];
    this.description = mapData["description"];
    this.bannerurl = mapData["bannerurl"];
  }
}
