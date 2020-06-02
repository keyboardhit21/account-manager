import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/password.dart';
import '../utils/dbhelper.dart';
import '../widgets/add_account_dialog.dart';

class Account extends StatefulWidget {

  final Item item;

  Account(this.item);

  @override
  _AccountState createState() => _AccountState(this.item);
}

class _AccountState extends State<Account> {

  Item item;
  DbHelper helper = DbHelper();
  List<Password> list = List<Password>();

  _AccountState(this.item);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    helper;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    getList();

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: (this.list.length == null) ? 0 : list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  helper.deleteAccount(list[index]);
                },
              ),
              leading: Icon(Icons.account_circle, size: 50.0,),
              title: Text(
                'username: ' + list[index].username,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                ),
              ),
              subtitle: Text(
                'pass: ' + list[index].password,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AddAccountDialog(this.item.id).showDialog(context);
          } );
        },
      ),
    );
  }

  Future getList() async {
    list = await helper.getAccount(this.item.id);
    setState(() {
      this.list = list;
    });
  }
}