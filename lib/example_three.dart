import 'dart:convert';
import 'dart:developer';

import 'package:api_start/Modal/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThreeView extends StatefulWidget {
  const ExampleThreeView({super.key});

  @override
  State<ExampleThreeView> createState() => _ExampleThreeViewState();
}

class _ExampleThreeViewState extends State<ExampleThreeView> {
  List<UserModel> userList = [];
  Future<List<UserModel>> UserView() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    //log(response.body.toString());
    var data = jsonDecode(response.body.toString());
    //log(data.toString());
    if (response.statusCode == 200) {
      userList.clear();
      for (Map<String, dynamic> i in data) {
        log("this is view ${i['name'].toString()}");
        userList.add(UserModel.fromJson(i));
      }
      log(userList.length.toString());
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example three User model'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: UserView(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            return Card(
                              child: Column(
                                children: [
                                  Text(snapshot.data![index].name.toString()),
                                  Text(snapshot.data![index].address!.city
                                      .toString()),
                                  Text(snapshot.data![index].address!.geo
                                      .toString()),
                                  Text(snapshot.data![index].address!.street
                                      .toString()),
                                ],
                              ),
                            );
                          }
                        });
                  }))
        ],
      ),
    );
  }
}
