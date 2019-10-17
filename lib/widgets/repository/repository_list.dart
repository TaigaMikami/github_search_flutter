import 'package:flutter/material.dart';
import 'package:github_search/model/Repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:intl/intl.dart';
import 'package:github_search/helpers/language_badge.dart';
import 'dart:html' as html;

class RepositoryList extends StatelessWidget {
  RepositoryList({this.repository, this.animationController});

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
    String language = repository.language == null ? 'others' : repository.language;
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: Image.network(repository.image, width: 100.0, height: 100.0,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            repository.fullName,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
//                          Badge(
//                            badgeColor: Colors.deepPurple,
//                            shape: BadgeShape.square,
//                            borderRadius: 20,
//                            toAnimate: true,
//                            badgeContent: Text(
//                              language,
//                              style: TextStyle(color: Colors.white, fontSize: 10.0),
//                            ),
//                          ),
                          LanguageBadge(language: language),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text(
                            homePage
                          )
                        ]
                      ),
                      Text(
                        description,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20.0),),
                      Row(
                        children: <Widget>[
                          Text(parser.emojify(':star:')),
                          Text(' ${repository.stargazersCount}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text(parser.emojify(':fork_and_knife:')),
                          Text(' ${repository.forksCount}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text(parser.emojify(':eyes:')),
                          Text(' ${repository.watchersCount}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text(parser.emojify(':question:')),
                          Text('${repository.openIssuesCount}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text('created_at : ${_formatDate(repository.createdAt)}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text('updated_at : ${_formatDate(repository.updatedAt)}'),
                        ],
                      )
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
