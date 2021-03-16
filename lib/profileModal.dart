import 'package:flutter/material.dart';

class Profile{

  var id;
  var name;
  var username;
  var email;
  var address;
  var phone;
  var website;
  var company;

  Profile(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json["email"],
      address: json["address"]["street"],
      phone: json["phone"],
      website: json["website"],
      company: json["company"]["name"]
    );
  }

}