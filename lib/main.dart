import 'package:flutter/material.dart';
import 'package:flutterdatabase/model/user.dart';
import './utils/database.dart';

List _user;

void main() async {
  var db = new DatabaseHelper();

  var saveddata = db.Saveuser(new User("ana", "anita"));
  print(saveddata);

  _user = await db.getUser();
  for (int i = 0; i < _user.length; i++) {
    User Us = User.map(dynamic, _user[i]);
    print("username: ${Us.Username}");
  }

  int count = await db.getCount();
  print(count);

  runApp(new MaterialApp(
    title: 'Database app',
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Database'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: new ListView.builder(
          itemCount: _user.length,
          itemBuilder: (BuildContext context, int position) {
            return new Card(
              color: Colors.white,
              child: new ListTile(
                leading: new CircleAvatar(
                  backgroundColor: Colors.green,
                  child: new Text("${User.fromMap(_user[position]).Id}"),
                ),
                title: new Text("${User.fromMap(_user[position]).Id}"),
              ),
            );
          }),
    );
  }
}
