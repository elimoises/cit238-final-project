import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_book_store/services/AuthService.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  String _firstName;
  String _lastName;
  String _email;
  String _password;
  bool _didAgree = false;

  AuthService _authService = AuthService();

  bool _isLoading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "REGISTER",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: "First Name",
                        hintText: "Enter First Name",
                        fillColor: Colors.white,
                          prefixIcon: Icon(Icons.person_outline,size: 28, color: Colors.grey),
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
                          return "First name is required";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _firstName = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        hintText: "Enter Last Name",
                        fillColor: Colors.white,
                          prefixIcon: Icon(Icons.person_outline,size: 28, color: Colors.grey),
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
                          return "Last name is required";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _lastName = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                      decoration: InputDecoration(
                          labelText: "Confirm Email",
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
                        if(value != _email) {
                          return "Email must match!";
                        }
                        return null;
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: !_isLoading,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
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
                        if(value != _password) {
                          return "Password must match!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FormField(
                      enabled: !_isLoading,
                      initialValue: _didAgree,
                      validator: (value) {
                        if(!value)
                          return "Agree to the terms to proceed!";
                        return null;
                      },
                      builder: (FormFieldState<bool> state) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: state.value, 
                                  onChanged: (val){
                                    _didAgree = val;
                                    state.didChange(val);
                                  }
                                ),
                                Text("I agree to the terms and conditions.")
                              ],
                            ),
                            state.errorText == null
                            ? Text("")
                            : Text(state.errorText, style: TextStyle(color: Colors.red))
                          ],
                        );
                      }
                    )

                  ],
                ),
              ),
              _isLoading ? Center( child: CircularProgressIndicator()) : Container(),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _isLoading ? null : () async {
                  if(_formKey.currentState.validate()) {
                    print("User is ready to register");
                    setState(() {
                      _isLoading = true;          
                    });
                    FirebaseUser user = await _authService.registerUser(_firstName, _lastName, _email, _password);
                    if(user != null) {
                      Navigator.pushReplacementNamed(context, 'dash', arguments: user.uid);
                    } else {
                      print('Error logging in!');
                      setState(() {
                      _isLoading = false;          
                    });
                    }
                  } else {
                    print("Please validate your info");
                  }
                },
                child: Text("SIGN UP"),

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
                child: Text("Already have an account?"),
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