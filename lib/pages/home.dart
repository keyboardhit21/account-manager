import 'package:flutter/material.dart';
import '../utils/dbhelper.dart';
import '../models/item.dart';
import '../widgets/add_item_dialog.dart';
import 'package:intl/intl.dart';
import '../pages/account.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DbHelper helper = DbHelper();
  List<Item> item = List<Item>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    getItems();

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: (this.item.length == null) ? 0 : item.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.library_books),
              title: Text(
                item[index].name,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22.0,
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMMd().format(DateTime.parse(item[index].date)).toString(),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Account(item[index]),
                  )
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  helper.deleteItem(item[index]);
                },
              ),
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AddItemDialogWidget().showDialog(context);
          });
        },
      ),
    );
  }

  Future getItems() async {
    item = await helper.getItem();
    setState(() {
      this.item = item;
    });
  }


}