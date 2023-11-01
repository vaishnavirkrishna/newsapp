import 'package:flutter/material.dart';

class ArticleTwoPage extends StatelessWidget {
  String? title;
  String? des;
  String? img;
  String? content;
  String? publish;

  ArticleTwoPage(
      {super.key, this.des, this.title, this.img, this.content, this.publish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS APP'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(img!)),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  SizedBox(height: 10.0),
                  Text(publish!),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("20.2k"),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.comment),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("2.2k"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    des!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    content!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
