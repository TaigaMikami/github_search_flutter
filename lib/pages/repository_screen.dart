import 'package:flutter/material.dart';
import 'package:github_search/model/Repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepositoryScreen extends StatefulWidget {
  @override
  _RepositoryScreenState createState() => new _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen>  with TickerProviderStateMixin {
  final List<Repository> _repository = <Repository>[];
  final TextEditingController _textController = new TextEditingController();

  bool searching = false, api_no_limit = false;
  String url = "https://api.github.com/search/repositories?q=";
  var resBody;

  Future _getRepositories(String text) async {
    setState(() {
      searching = true;
    });
    _textController.clear();
    var res = await http.get(Uri.encodeFull(url + text), headers: {"Accept": "application/json"});
    setState(() {
      resBody = json.decode(res.body);
    });
    var resItems = resBody['items'];
    for (int i = 0; i < 10; i++) {
      if (resItems[i]['owner']['avatar_url'] != null) {
        Repository repo = new Repository(
          full_name: resItems[i]['full_name'],
          image: resItems[i]['owner']['avatar_url'],
          stargazers_count: resItems[i]['stargazers_count'],
          forks: resItems[i]['forks'],
          html_url: resItems[i]['html_url'],
          animationController: AnimationController(
            duration: Duration(milliseconds: 700),
            vsync: this,
          ),
        );
        setState(() {
          _repository.insert(_repository.length, repo);
        });
        repo.animationController.forward();
      } else {
        api_no_limit = true;
      }
    }
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
                onSubmitted: _getRepositories,
                decoration: InputDecoration.collapsed(hintText: "Enter Github Repository Name"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => _getRepositories(_textController.text),
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
              itemBuilder: (_, int index) => _repository[index],
              itemCount: _repository.length,
              padding: EdgeInsets.all(8.0),
            ),
          )
        ],
      ),
    );
  }
}

