import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:http/http.dart' as http;

class MySports extends StatefulWidget {
  const MySports({super.key});

  @override
  State<MySports> createState() => _MyHomeState();
}

class _MyHomeState extends State<MySports> {
  NewsApi? newsModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var apiKey =
        "64174d48a9ae41de96dd432d950b586e"; // Replace with your News API key
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=sports&apiKey=64174d48a9ae41de96dd432d950b586e");
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
        title: Text('SPORTS'),
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
