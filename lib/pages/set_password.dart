import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool errorText = false;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(
                  'It seems you haven\'t set your password yet. Please enter your password!',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100.0),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 40.0),
                TextField(
                  obscureText: true,
                  controller: passwordConfirmController,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 100.0),   
                RaisedButton(
                  child: Text('Set Password'),
                  onPressed: () {
                    setPassword();
                  },
                ),
                SizedBox(height: 20.0),
                (errorText) ? Text(
                    'Passwords do not match',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ) : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future setPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(passwordController.text == passwordConfirmController.text) {
      var bytes = utf8.encode(passwordController.text);
      var hash = sha1.convert(bytes);
      prefs.setBool('hasAccount', true);
      prefs.setString('password', hash.toString());
      Navigator.pop(context);
    }
    else {
      setState(() {
        errorText = true;
      });
    }
  }
}