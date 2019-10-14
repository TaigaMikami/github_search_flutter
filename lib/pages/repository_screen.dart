import 'package:flutter/material.dart';
import 'package:github_search/model/Repository.dart';
import 'package:github_search/widgets/loading.dart';
import 'package:github_search/helpers/url_create.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class RepositoryScreen extends StatefulWidget {
  @override
  _RepositoryScreenState createState() => new _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen>  with TickerProviderStateMixin {
  final List<Repository> _repository = <Repository>[];
  final TextEditingController _textController = new TextEditingController();

  bool searching = false, api_no_limit = false;
  String sort =  "&sort=stars";
  int count = 10;
  var resBody;

  Future _getRepositories(String text) async {
    setState(() {
      searching = true;
      _repository.clear();
    });
    _textController.clear();
    var res = await http.get(Uri.encodeFull(UrlCreate.repositoryUrl(text, sort)), headers: {"Accept": "application/json"});
    setState(() {
      resBody = json.decode(res.body);
    });
    var resItems = resBody['items'];
    int itemCount = min(count, resItems.length);
    for (int i = 0; i < itemCount; i++) {
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
              child: _sortDown()
            ),
            Container(
              child: _countDown(),
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

  DropdownButton _sortDown() => DropdownButton<String> (
    items: [
      DropdownMenuItem(
        value: "&sort=stars",
        child: Text(
          "Star",
        ),
      ),
      DropdownMenuItem(
        value: "&sort=forks",
        child: Text(
          "Fork",
        ),
      ),
      DropdownMenuItem(
        value: "&sort=updated",
        child: Text(
          "Updated",
        ),
      ),
    ],
    onChanged: (value) {
      setState(() {
        sort = value;
      });
    },
    value: sort,
  );

  DropdownButton _countDown() => DropdownButton<int> (
    items: [
      DropdownMenuItem(
        value: 10,
        child: Text(
          "10",
        ),
      ),
      DropdownMenuItem(
        value: 20,
        child: Text(
          "20",
        ),
      ),
      DropdownMenuItem(
        value: 50,
        child: Text(
          "50",
        ),
      ),
    ],
    onChanged: (value) {
      setState(() {
        count = value;
      });
    },
    value: count,
  );

  Widget _buildDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: _sortDown(),
          ),
          Container(
            child: _countDown(),
          )
        ],
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

