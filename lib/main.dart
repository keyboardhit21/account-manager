import 'package:flutter/material.dart';
import './utils/dbhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/set_password.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import './pages/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  Login({Key key,}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  DbHelper helper = DbHelper();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    hasAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 90.0,),
                Center(
                  child: Icon(
                    Icons.lock,
                    size: 100.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Center(
                  child: Text(
                    'Account Manager',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ) ,
                ),
                SizedBox(height: 50.0,),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 100.0,),
                RaisedButton(
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.green[400],
                  onPressed: () async {
                    login();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future hasAccount() async {
    SharedPreferences prefs = await _prefs;
    print(prefs.get('hasAccount'));
    if(!prefs.get('hasAccount')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPassword(),
        ),
      );
    }
  }

  Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var passwordByte = utf8.encode(passwordController.text);
    var passwordHash = sha1.convert(passwordByte).toString();
    if(passwordHash == prefs.get('password')) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), ModalRoute.withName('/'));
    }
  }
  
}