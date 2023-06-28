import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:list_view/theme/colors.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List user = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    var url = "https://randomuser.me/api/?results=100";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var item = json.decode(response.body)['results'];
      setState(() {
        user = item;
      });
    } else {
      setState(() {
        user = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing User'),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List items = ["1", "2"];
    return ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) {
          return getCard(user[index]);
        });
  }

  Widget getCard(item) {
    var fullName = item['name']['first'] + " " + item['name']['last'];
    var email = item['email'];
    var profileUrl = item['picture']['medium'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(60 / 2),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profileUrl.toString())))),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fullName.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    email.toString(),
                    softWrap: true,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
