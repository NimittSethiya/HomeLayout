import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_task/profile.dart';
import 'package:flutter_task/profileModal.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  List<String> acceptedData = [];
  List<String> profileImages = ["https://images.unsplash.com/photo-1561055657-b9e0bf0fa360?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
  "https://images.unsplash.com/photo-1558898479-33c0057a5d12?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
  "https://images.unsplash.com/photo-1544435253-f0ead49638fa?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
  "https://images.unsplash.com/photo-1606589329778-e87fbc5b7e33?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=926&q=80",
  "https://images.unsplash.com/photo-1598550874175-4d0ef436c909?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1189&q=80",
  "https://images.unsplash.com/photo-1611774833580-40f2f588eaa4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=689&q=80",
  "https://images.unsplash.com/photo-1605993439219-9d09d2020fa5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
  "https://images.unsplash.com/photo-1591579883657-e0f15d09f9fe?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
  "https://images.unsplash.com/photo-1577091379102-31fc6dc08626?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=691&q=80",
  "https://images.unsplash.com/photo-1572316787289-4d87404eea4e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"];
  TabController _tabController;
  List<Profile> profile;

  var totalMatch=0;
  var temp = 20;

  Future<Profile> fetchData() async {
    final response =
    await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));

    if (response.statusCode == 200) {
      setState(() {
        profile = jsonDecode(response.body)
            .map((item) => Profile.fromJson(item))
            .toList()
            .cast<Profile>();

        totalMatch=profile.length;
        // _showMyDialog(context);
        _onPress();
        print("data:"+profile.length.toString());
      });


      // return Profile.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget feedList = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: totalMatch,
        itemBuilder: (BuildContext context, int index) =>
            feedData(context, index));

    Widget datesList = GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: totalMatch,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
            dataList(context, index),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (temp / 5).toInt()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Explore",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 100,
            child: feedList,
          ),
          TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.greenAccent,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: "Dates",
                ),
                Tab(
                  text: "Mates",
                )
              ]),


          // SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          //   child: datesList,
          // )
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    height: (35 * temp).toDouble(), child: datesList)),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black, width: 1.0),
                color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  "https://avatars.githubusercontent.com/u/908687?s=200&v=4"),
            )),
        tooltip: "Do you want to set your intent?",
        onPressed: () {
          // _onPress();
        },
      ),
    );
  }

  void _onPress() {
    print("here");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(days: 1),
      elevation: 1.0,
      content: Container(
        height: 20,
        color: Colors.white,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We have $totalMatch matches for you today",
                style: TextStyle(color: Colors.black),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap:(){
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                    child: Icon(Entypo.cross)),
                // IconButton(
                //   icon: Icon(Entypo.cross),
                //   onPressed: (){
                //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    ));
  }

  feedData(BuildContext context, int index) {
    return DragTarget<int>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        if (acceptedData.isNotEmpty && acceptedData.length>index) {
          return acceptedData[index] != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: new BoxDecoration(
                            image:new DecorationImage(
                              fit: BoxFit.contain,
                                image: NetworkImage(acceptedData[index])),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.greenAccent,width: 1)
                        ),
                      ),
                      Positioned(bottom: 0,right: 2,child: Icon(Entypo.dot_single,color: Colors.lightGreenAccent,size: 30,))
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    maxRadius: 35,
                    minRadius: 35,
                  ),
                );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              maxRadius: 35,
              minRadius: 35,
            ),
          );
        }
      },
      onAccept: (int data) {
        setState(() {
          if(!acceptedData.contains(profileImages[data])){
            acceptedData.add(profileImages[data]);
          }
        });
      },
    );
  }

  dataList(BuildContext context, int index) {
    return GestureDetector(
      onTap:() {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProfileData(profile: profile[index],)));
      },
      child: Draggable(
        data: index,
        child: profileImages.isNotEmpty
            ? profileImages.elementAt(index) != null
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profileImages[index]),
                    maxRadius: 50,
                    minRadius: 50,
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    maxRadius: 50,
                    minRadius: 50,
                  ),
                )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                maxRadius: 50,
                minRadius: 50,
              ),
            ),
        feedback: profileImages.isNotEmpty
            ? profileImages.elementAt(index) != null
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profileImages[index]),
                    maxRadius: 50,
                    minRadius: 50,
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    maxRadius: 50,
                    minRadius: 50,
                  ),
                )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                maxRadius: 50,
                minRadius: 50,
              ),
            ),
        childWhenDragging: profileImages.isNotEmpty
            ? profileImages.elementAt(index) != null
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profileImages[index]),
                    maxRadius: 50,
                    minRadius: 50,
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    maxRadius: 50,
                    minRadius: 50,
                  ),
                )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                maxRadius: 50,
                minRadius: 50,
              ),
            ),
      ),
    );
  }
}
