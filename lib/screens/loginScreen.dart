import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_book_store/services/AuthService.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  AuthService _authService = AuthService();
  String _email;
  String _password;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/books.png",
                width: 220,
                height: 220,
              ),
              Text(
                  "BookHaven",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Books are the wings of your mind. ",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        hintText: "example@gmail.com",
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.email_outlined,size: 28, color: Colors.grey),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 60,
                        ),
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50)
                          ),
                        )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "Email is required";
                        }
                        RegExp isEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if(!isEmail.hasMatch(value)){
                          return "Email is invalid!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                           _email = value;                     
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: !_isLoading,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "********",
                        fillColor: Colors.white,
                          prefixIcon: Icon(Icons.vpn_key_outlined,size: 26, color: Colors.grey),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 60,
                          ),
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)
                            ),
                          )
                      ),
                      validator: (value){
                        if(value.isEmpty) 
                          return "Password is required";
                        if(value.length < 6)
                          return "Password should be more than 5 characters";
                        // Regex pattern for determining uppercase characters
                        RegExp hasUpper = RegExp(r'[A-Z]');
                        // Regex pattern for determining lowercase characters
                        RegExp hasLower = RegExp(r'[a-z]');
                        // Regex pattern for determining digits
                        RegExp hasDigit = RegExp(r'\d');
                        // Regex patter for determining special characters
                        RegExp hasPunct = RegExp(r'[_!@#\$&*~-]');
                        if (!hasUpper.hasMatch(value))
                          return 'Password must have at least one uppercase character';
                        if (!hasLower.hasMatch(value))
                          return 'Password must have at least one lowercase character';
                        if (!hasDigit.hasMatch(value))
                          return 'Password must have at least one number';
                        if (!hasPunct.hasMatch(value))
                          return 'Password need at least one special character like !@#\$&*~-';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                           _password = value;                     
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height:30,
              ),
              _isLoading ? Center( child: CircularProgressIndicator()) : Container(),
              ElevatedButton(
                onPressed: _isLoading ? null : () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      _isLoading = true;
                    });
                    print("All forms are validated");
                    FirebaseUser user = await _authService.loginUser(_email, _password);
                    if(user != null) {
                      Navigator.pushReplacementNamed(context, 'dash', arguments: user.uid);
                    } else {
                      print('Error logging in!');
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  } else {
                    print("Please check your input");
                  }
                },
                child: Text("SIGN IN"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                    ),
                ),
              ),
              SizedBox(
                height:10,
              ),
              OutlinedButton(
                  onPressed: _isLoading ? null : (){
                    widget.toggleScreen();
                  },
                  child: Text("Don't have an account?"),
                style: OutlinedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  side: BorderSide(color: Colors.lightBlueAccent),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}