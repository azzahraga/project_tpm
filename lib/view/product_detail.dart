import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tpm/navbar.dart';
import 'package:project_tpm/view/home.dart';

class ProductDetail extends StatelessWidget {

  int id;
  String title;
  String thumbnail;
  String short_description;
  String price;
  String product_type;

  ProductDetail({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.short_description,
    required this.price,
    required this.product_type,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Nav()),
                        (route) => false);
              },
            ),
          ],
          title: Text(title.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(height: 220, decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fitHeight, image: NetworkImage(thumbnail.toString()))),),
              Container(
                height: 150,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 110,
                        width: 75,
                        decoration: BoxDecoration(
                            image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(thumbnail.toString())),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            title.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Type : " + product_type.toString(),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),

                          SizedBox(height: 10),
                          Text("Price : " + price.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.10),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Raleway'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        short_description.toString(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          wordSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}