import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_tpm/helper/shared_preference.dart';
import 'package:project_tpm/view/product_detail.dart';

import 'login_page.dart';

class CategoryEye extends StatefulWidget {

  @override
  _CategoryEyeState createState() => _CategoryEyeState();
}

class _CategoryEyeState extends State<CategoryEye> {
  List home = [];
  bool load = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchHome();
  }

  fetchHome() async {
    setState(() {
      load = true;
    });
    var url =
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline&&product_type=eyeshadow";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List items = (json.decode(response.body) as List)
      //     // .map((data) => ProductDetail.)
          .toList();

      // var items = json.decode(response.body)['results'];
      setState(() {
        home = items;
        load = false;
      });
    } else {
      setState(() {
        home = [];
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Eyeshadow",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SharedPreference().setLogout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (home.contains(null) || home.length < 0 || load) {
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
          ));
    }
    return ListView.builder(
        itemCount: home.length,
        itemBuilder: (context, index) {
          return getCard(home[index]);
        });
  }

  Widget getCard(item) {

    var id = item['id'];
    var title = item['name'];
    var thumbnail = item['image_link'];
    var short_description =item['description'];
    var price = item['price'];
    var product_type = item['product_type'];
    // var publisher = item['publisher'];

    return Card(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProductDetail(id : id, title : title,  thumbnail: thumbnail,short_description: short_description,price: price, product_type: product_type,
                // genre: genre, platform: platform,publisher: publisher,
              ))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(thumbnail.toString()),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Text(
                        "Type : " + product_type.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      // Text(
                      //   "Publisher : " + publisher.toString(),
                      //   style: TextStyle(fontSize: 14, color: Colors.grey),
                      // ),
                      SizedBox(height: 10),
                      Text("Description",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Container(
                        width: 420,
                        child: Text(
                          short_description.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Raleway'),
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
