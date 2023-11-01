import 'dart:convert';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/view/business.dart';
import 'package:flutter_application_1/view/technology.dart';
import 'package:flutter_application_1/view/detail.dart';
import 'package:flutter_application_1/view/entertainment.dart';
import 'package:flutter_application_1/view/health.dart';
import 'package:flutter_application_1/view/political.dart';
import 'package:flutter_application_1/view/science.dart';
import 'package:flutter_application_1/view/sports.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/model/model.dart';

import 'package:flutter/material.dart';

class NewsHomeOnePage extends StatefulWidget {
  const NewsHomeOnePage({super.key});

  @override
  State<NewsHomeOnePage> createState() => _NewsHomeOnePageState();
}

class _NewsHomeOnePageState extends State<NewsHomeOnePage> {
  final SearchController = TextEditingController();
  NewsApi? newsModel;

  Future<void> fetchData(String query) async {
    var apiKey = "64174d48a9ae41de96dd432d950b586e";
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=all&apiKey=64174d48a9ae41de96dd432d950b586e");
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
        centerTitle: true,
        title: Text("ALL WORLD NEWS"),
        backgroundColor: const Color.fromARGB(255, 88, 112, 155),
      ),
      backgroundColor: Color.fromARGB(255, 136, 211, 161),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 300,
                child: TextFormField(
                  onChanged: (value) {
                    fetchData(SearchController.text);
                    SearchController.clear();
                  },
                  controller: SearchController,
                  decoration: InputDecoration(
                    labelText: "search",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  maxLines: 1,
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 40,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 5),
                scrollDirection: Axis.horizontal,
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      String selectedItem = myList[index];

                      switch (selectedItem) {
                        case "Health":
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              fetchData('Health');
                              return MyHome();
                            },
                          ));
                          break;

                        case "Entertainment":
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyEntertainment()));
                          break;
                        case "Science":
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyScience()));
                          break;
                        case "Sports":
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MySports()));
                          break;
                        case "Political":
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyPolitics()));
                          break;
                        case "Business":
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyBusiness()));
                          break;
                        case "Technology":
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyTechnology()));
                          break;
                      }
                    },
                    child: Chip(
                      backgroundColor: const Color.fromARGB(255, 218, 188, 224),
                      label: Text(myList[index]),
                    ),
                  );
                },
              )),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: const Color.fromARGB(255, 74, 68, 68),
              ),
              itemCount: newsModel?.articles?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleTwoPage(
                          publish: newsModel?.articles?[index].publishedAt
                                  .toString() ??
                              "error",
                          img: newsModel?.articles?[index].urlToImage
                                  .toString() ??
                              "error",
                          title: newsModel?.articles?[index].title.toString() ??
                              "error",
                          des: newsModel?.articles?[index].description
                                  .toString() ??
                              "error",
                          content:
                              newsModel?.articles?[index].content.toString() ??
                                  "error",
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 100,
                          child: Image.network(
                            newsModel?.articles?[index].urlToImage.toString() ??
                                "error",
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amberAccent,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                newsModel?.articles?[index].title.toString() ??
                                    "error",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                newsModel?.articles?[index].description
                                        .toString() ??
                                    "error",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchData(''),
      ),
    );
  }
}
