import 'package:flutter/material.dart';
import 'package:github_search/model/User.dart';
import 'package:github_search/widgets/loading.dart';
import 'package:github_search/widgets/user/user_list.dart';
import 'package:github_search/helpers/url_create.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => new _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  final List<UserList> _userList = <UserList>[];
  final TextEditingController _textController = new TextEditingController();

  bool searching = false, api_no_limit = false;
  var resBody;

  Future _getUser(String text) async {
    setState(() {
      searching = true;
    });
    _textController.clear();
    var res = await http.get(Uri.encodeFull(UrlCreate.userUrl(text)), headers: {"Accept": "application/json"});
    print("ほげ $res");
    setState(() {
      resBody = json.decode(res.body);
    });
    if (resBody['avatar_url'] != null) {
      String username = resBody['name'] == null ? text : resBody['name'];
      User user = new User(
        name: username,
        image: resBody['avatar_url'],
        public_repos: resBody['public_repos'],
        followers: resBody['followers'],
        following: resBody['following'],

      );
      UserList userList = new UserList(
        user: user,
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      setState(() {
        _userList.insert(0, userList);
      });
      print(_userList.length);
      userList.animationController.forward();
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
          Loading(searching: searching, api_no_limit: api_no_limit,),
          Flexible(
            child: ListView.builder(
              itemBuilder: (_, int index) => _userList[index],
              itemCount: _userList.length,
              padding: EdgeInsets.all(8.0),
            ),
          )
        ],
      ),
    );
  }
}
