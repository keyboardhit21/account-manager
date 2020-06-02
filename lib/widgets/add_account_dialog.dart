import 'package:flutter/material.dart';
import '../utils/dbhelper.dart';
import '../models/password.dart';


class AddAccountDialog {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DbHelper helper = DbHelper();
  int id;

  AddAccountDialog(this.id);


  Widget showDialog(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Add Account'
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 25.0),
            RaisedButton(
              child: Text('Add Account'),
              onPressed: () async {
                insertAccount();
                Navigator.pop(context);
              },
            )
          ],
        )
      ),
    );
  }

  Future insertAccount() async {
    await helper.insertAccount(Password(id: null, listId: this.id, username: usernameController.text, password: passwordController.text, date: DateTime.now().toString()));
  }
}