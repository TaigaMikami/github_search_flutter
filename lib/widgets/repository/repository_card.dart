import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:github_search/model/Repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class RepositoryCard extends StatelessWidget {
  RepositoryCard({this.repository, this.animationController});

  final Repository repository;
  final AnimationController animationController;
  var parser = EmojiParser();

  String _formatDate(DateTime dateTime) {
    return (DateFormat.yMMMd()).format(dateTime);
  }

  _launchURL(url) {
    html.window.open(url, '');
  }

  @override
  Widget build(BuildContext context) {
    String description = repository.description == null ? '' : repository.description;
    String homePage = repository.homePage == null ? '' : repository.homePage;
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 15.0),
        child: RaisedButton(
          onPressed: () => _launchURL(repository.htmlUrl),
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Image.network(repository.image, width: 70.0, height: 70.0,),
                ),
                Padding(padding: EdgeInsets.only(bottom: 15.0),),
                Text(
                  repository.fullName,
                  style: Theme.of(context).textTheme.title,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            homePage
                          )
                        ]
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 55.0),
                        child: Table(
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.black38,
                              style: BorderStyle.solid,
                              width: 1.0
                            )
                          ),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                Center(
                                  child: Text(parser.emojify(':star:'), ),
                                ),
                                Text(' ${repository.stargazersCount}'),
                              ]
                            ),
                            TableRow(
                              children: [
                                Center(
                                  child: Text(parser.emojify(':fork_and_knife:')),
                                ),
                                Text(' ${repository.forksCount}'),
                              ]
                            ),
                            TableRow(
                              children: [
                                Center(
                                  child: Text(parser.emojify(':eyes:')),
                                ),
                                Text(' ${repository.watchersCount}'),
                              ]
                            ),
                            TableRow(
                              children: [
                                Center(
                                  child: Text(parser.emojify(':question:')),
                                ),
                                Text(' ${repository.openIssuesCount}'),
                              ]
                            ),
                          ]
                        )
                      ),
                      Text(
                        description,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Text(
                        'created_at : ${_formatDate(repository.createdAt)}',
                        style: TextStyle(fontSize: 11.0),
                      ),
                      Text(
                        'updated_at : ${_formatDate(repository.updatedAt)}',
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
