import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_book_store/services/AuthService.dart';
import 'package:my_book_store/services/DatabaseService.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthService _authService = AuthService();
  String userId;

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context).settings.arguments;
    print(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
        actions: [ 
          ElevatedButton(
            onPressed: () async {
              await _authService.logoutUser();
              Navigator.pushReplacementNamed(context, 'auth');
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 30),
          child: Column(
            children: [
              displayUserdata(),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Discover new stories and add them to your favorites!",
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              displayItems(),
            ],
          ),
        ),
      ),
    );
  }
  Widget displayUserdata() {
    return new FutureBuilder(
      future: DatabaseService(uid: userId).fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data.exists) {
            String firstName = snapshot.data['firstName'];
            String lastName = snapshot.data['lastName'];
            return Container(
              child: Column(
                children: [
                  Text(
                  "Welcome, $firstName $lastName!",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        } else {
          return new CircularProgressIndicator();
        }
      }
    );
  }
  Widget displayItems() {
    return FutureBuilder(
      future: DatabaseService().fetchProducts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          if( snapshot.data != null ) {

            List items = [];
            snapshot.data.documents.map((item) {
              items.add(item);
            }).toList();
            return Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 44,
                        minHeight: 100,
                        maxWidth: 80,
                        maxHeight: 150,
                      ),
                      child: Image.network(items[index]['image'], fit: BoxFit.cover,),
                    ),
                    title: Text(items[index]['itemName']),
                    // /n Click for more description.
                    subtitle: Text("${items[index]['itemPrice']} ${items[index]['currency']}"),
                    trailing:  IconButton(
                      icon: Icon(Icons.star_rounded),
                      onPressed: () async {
                        print("Added to favorites");
                        await DatabaseService(uid: userId).addToFavorites(items[index].reference.documentID);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Book has been added to your favorites!"))
                        );
                      },
                    ),
                    onTap: () {
                      Map<String, dynamic> args = new Map();
                      args['userId'] = userId;
                      args['item'] = items[index];
                      Navigator.pushNamed(context, 'itemInfo', arguments: args);
                    },
                  );
                }
              )
            );

          } else {
            return Container();
          }
        } else {
          return new CircularProgressIndicator();
        }
      }
    );
  }
}
