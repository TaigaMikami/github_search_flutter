import 'package:flutter/material.dart';
import 'package:github_search/model/Repository.dart';
import 'package:github_search/widgets/loading.dart';
import 'package:github_search/helpers/url_create.dart';
import 'package:github_search/widgets/repository/repository_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepositoryCompareScreen extends StatefulWidget {
  @override
  _RepositoryCompareScreen createState() => new _RepositoryCompareScreen();
}

class _RepositoryCompareScreen extends State<RepositoryCompareScreen> with TickerProviderStateMixin {
  final List<RepositoryCard> _repoCard = <RepositoryCard>[];
  final TextEditingController _textController = new TextEditingController();

  bool searching = false, api_no_limit = false;
  var resBody;

  Future _getUser(String text) async {
    setState(() {
      searching = true;
    });
    _textController.clear();
    var res = await http.get(Uri.encodeFull(UrlCreate.repositoryUrl(text)), headers: {"Accept": "application/json"});
    setState(() {
      resBody = json.decode(res.body);
    });
    var resItem = resBody['items'][0];
    if (resItem['owner']['avatar_url'] != null) {
      Repository repo = new Repository(
        fullName: resItem['full_name'],
        image: resItem['owner']['avatar_url'],
        description: resItem['description'],
        language: resItem['language'],
        stargazersCount: resItem['stargazers_count'],
        forksCount: resItem['forks_count'],
        watchersCount: resItem['watchers_count'],
        openIssuesCount: resItem['open_issues_count'],
        htmlUrl: resItem['html_url'],
        homePage: resItem['home_page'],
        createdAt: DateTime.parse(resItem['created_at']),
        updatedAt: DateTime.parse(resItem['updated_at']),
      );
      RepositoryCard repoCard = new RepositoryCard(
        repository: repo,
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      setState(() {
        _repoCard.insert(0, repoCard);
      });
      repoCard.animationController.forward();
    } else {
      api_no_limit = true;
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
                onSubmitted: _getUser,
                decoration: InputDecoration.collapsed(hintText: "username/repository"),
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
          Padding(padding: EdgeInsets.only(bottom: 10),),
          Flexible(
            child: GridView.builder(
              itemBuilder: (_, int index) => _repoCard[index],
              itemCount: _repoCard.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
              ),
            ),
          )
        ],
      ),
    );
  }
}
