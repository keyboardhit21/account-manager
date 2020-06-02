class Password {

  int id;
  int listId;
  String username;
  String password;
  String date;

  Password({this.id, this.listId, this.username, this.password, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'list_id': this.listId,
      'username': this.username,
      'password': this.password,
      'date': this.date,
    };
  }

}