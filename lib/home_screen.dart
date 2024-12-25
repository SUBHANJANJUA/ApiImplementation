import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Modal/post_modal.dart';

// ignore: must_be_immutable
class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});
  List<PostsModel> getPostlist = [];
  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    // log(response.body.toString());
    var data = jsonDecode(response.body.toString());
    // log(data.toString());
    if (response.statusCode == 200) {
      getPostlist.clear();
      for (Map<String, dynamic> i in data) {
        getPostlist.add(PostsModel.fromJson(i));
      }
      log(getPostlist.length.toString());
      return getPostlist;
    } else {
      return getPostlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APIs lecture'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('loading');
                  } else {
                    return ListView.builder(
                        itemCount: getPostlist.length,
                        itemBuilder: (context, index) {
                          return Text(getPostlist[index].title.toString());
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
