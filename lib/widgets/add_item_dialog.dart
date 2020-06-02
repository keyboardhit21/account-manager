import 'package:flutter/material.dart';
import '../utils/dbhelper.dart';
import '../models/item.dart';


class AddItemDialogWidget {

  TextEditingController nameController = TextEditingController();
  DbHelper helper = DbHelper();

  Widget showDialog(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Text(
          'Enter New Entry!',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Name',
          ),
        ),
        SizedBox(height: 30.0),
        RaisedButton(
          child: Text('Add'),
          onPressed: () async {
            await submit(nameController.text);
            Navigator.pop(context);
          },
        )
        ],
      ),
      )
    );
  }

  

  Future submit(String name) async {
    Item item = Item(id: null, name: name, date: DateTime.now().toString());
    helper.insertItem(item);
  }

}