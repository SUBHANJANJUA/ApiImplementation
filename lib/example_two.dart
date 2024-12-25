import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwoView extends StatefulWidget {
  const ExampleTwoView({super.key});

  @override
  State<ExampleTwoView> createState() => _ExampleTwoViewState();
}

class _ExampleTwoViewState extends State<ExampleTwoView> {
  List<PhotosModel> photoList = [];
  Future<List<PhotosModel>> getPhoto() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    log(' this msg');
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      photoList.clear();
      for (Map<String, dynamic> i in data) {
        //photoList.add(PhotosModel.fromJson(i));
        PhotosModel photosModel = PhotosModel(title: i['title'], url: i['url']);
        photoList.add(photosModel);
      }
      log(photoList.length.toString());
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Two'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhoto(),
                builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString()),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class PhotosModel {
  String title, url;
  PhotosModel({required this.title, required this.url});
}
