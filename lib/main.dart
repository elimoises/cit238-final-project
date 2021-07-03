import 'package:flutter/material.dart';
import 'package:my_book_store/screens/authScreen.dart';
import 'package:my_book_store/screens/dashboardScreen.dart';
import 'package:my_book_store/screens/itemInfoScreen.dart';
import 'package:my_book_store/screens/loginScreen.dart';
import 'package:my_book_store/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'splash',
      routes: {
        'splash': (context) => SplashScreen(),
        'auth' : (context) => AuthScreen(),
        'dash' : (context) => DashboardScreen(),
        'login': (context) => LoginScreen(),
        'itemInfo' : (context) => ItemInfoScreen(),
      },

    );
  }
}