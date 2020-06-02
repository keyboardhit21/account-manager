class Item {

  int id;
  String name;
  String date;

  Item({this.id, this.name, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'date': this.date,
    };
  }

}
