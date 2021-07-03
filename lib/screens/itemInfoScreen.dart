import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map pageArgs = ModalRoute.of(context).settings.arguments;
    String userId = pageArgs['userId'];
    DocumentSnapshot item = pageArgs['item'];

    return Scaffold(
      appBar: AppBar(
        title: Text(item['itemName']),
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.network(item['image'], width: 250, height: 250),
              SizedBox(height: 50),
              Text(
                item['itemName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${item['author']}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${item['itemPrice']} ${item['currency']}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "\n\n${item['description']}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}