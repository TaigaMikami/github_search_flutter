import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:github_search/model/Repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class RepositoryCard extends StatelessWidget {
  RepositoryCard({this.repository, this.animationController});

  final Repository repository;
  final AnimationController animationController;

  String _formatDate(DateTime dateTime) {
    return (DateFormat.yMMMd()).format(dateTime);
  }

  _launchURL(url) {
    html.window.open(url, '');
  }

  @override
  Widget build(BuildContext context) {
    String home_page = repository.home_page == null ? '' : repository.home_page;
    String description = repository.description == null ? '' : repository.description;
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 15.0),
        child: RaisedButton(
          onPressed: () => _launchURL(repository.html_url),
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
                            repository.full_name,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Chip(
                            backgroundColor: Colors.greenAccent,
                            padding: EdgeInsets.all(0.0),
                            label: Text(repository.language, style: TextStyle(color: Colors.white, fontSize: 12.0),),
                          ),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text(
                            home_page
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
                          Icon(Icons.star, size: 15.0,),
                          Text(' ${repository.stargazers_count}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Icon(FontAwesomeIcons.codeBranch, size: 15.0,),
                          Text(' ${repository.forks_count}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Icon(FontAwesomeIcons.eye, size: 15.0,),
                          Text(' ${repository.watchers_count}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Icon(FontAwesomeIcons.infoCircle, size: 15.0,),
                          Text(' ${repository.open_issues_count}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text('created_at : ${_formatDate(repository.created_at)}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text('updated_at : ${_formatDate(repository.updated_at)}'),
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
