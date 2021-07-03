import 'package:flutter/material.dart';
import 'package:my_book_store/screens/loginScreen.dart';
import 'package:my_book_store/screens/registerScreen.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  void toggleScreen() {
    setState(() {
      _isLogin = !_isLogin;      
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin ? LoginScreen(toggleScreen: toggleScreen,) : RegisterScreen(toggleScreen: toggleScreen,);
  }
}