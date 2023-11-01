import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:http/http.dart' as http;

class MyTechnology extends StatefulWidget {
  const MyTechnology({super.key});

  @override
  State<MyTechnology> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyTechnology> {
  NewsApi? newsModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var apiKey = "64174d48a9ae41de96dd432d950b586e";
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=technology&apiKey=64174d48a9ae41de96dd432d950b586e");
    var response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    print(response.statusCode);
    setState(() {
      newsModel = NewsApi.fromJson(decodedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUSINESS'),
      ),
      body: ListView.builder(
        itemCount: newsModel?.articles?.length ?? 0,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Color.fromARGB(255, 136, 211, 161),
            child: Container(
              height: 250,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Image.network(
                      newsModel?.articles?[index].urlToImage.toString() ??
                          "error",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(newsModel?.articles?[index].description.toString() ??
                      "error"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
