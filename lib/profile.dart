import 'package:flutter/material.dart';
import 'package:flutter_task/profileModal.dart';

class ProfileData extends StatefulWidget {
  Profile profile;


  ProfileData({this.profile});

  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Text(widget.profile.name),
            Text(widget.profile.username),
            Text(widget.profile.id.toString()),
            Text(widget.profile.address),
            Text(widget.profile.phone.toString()),
          ],
        ),
      ),
    );
  }
}

