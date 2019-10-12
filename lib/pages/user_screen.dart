import 'package:flutter/material.dart';
import 'package:github_search/model/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => new _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  final List<User> _user = <User>[];
  final TextEditingController _textController = new TextEditingController();

  bool searching = false, api_no_limit = false;
  String url = "https://api.github.com/users/";
  String user = "";
  var resBody;

  Future _getUser(String text) async {
    setState(() {
      searching = true;
    });
    _textController.clear();
    var res = await http.get(Uri.encodeFull(url + text), headers: {"Accept": "application/json"});
    print("ほげ $res");
    setState(() {
      resBody = json.decode(res.body);
    });
    print(resBody);
    if (resBody['avatar_url'] != null) {
      String username = resBody['name'] == null ? text : resBody['name'];
      User user = new User(
        name: username,
        image: resBody['avatar_url'],
        public_repos: resBody['public_repos'],
        followers: resBody['followers'],
        following: resBody['following'],
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      setState(() {
        _user.insert(0, user);
      });
      print(_user.length);
      user.animationController.forward();
    } else {
      api_no_limit = true;
    }
    print("after id");
    searching = false;
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _getUser,
                decoration: InputDecoration.collapsed(hintText: "Enter Github Username"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => _getUser(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loading(){
    if(searching){
      return new Container(
        height: 60.0,
        child:new Center(
          child:new CircularProgressIndicator()
        ),
      );
    }else if(api_no_limit) {
      return new Card(
        child: new Container(
          height: 80.0,
          color: Colors.red,
          child: new Center(
            child: new Text(
              "API LIMIT EXCEDED",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22.0
              ),
            ),
          )
        ),
      );
    }else{
      return new Container(

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
          Divider(height: 2.0,),
          loading(),
          Flexible(
            child: ListView.builder(
              itemBuilder: (_, int index) => _user[index],
              itemCount: _user.length,
              padding: EdgeInsets.all(8.0),
            ),
          )
        ],
      ),
    );
  }
}
