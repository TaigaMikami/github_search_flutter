import 'package:flutter/material.dart';
import 'package:github_search/model/User.dart';
import 'dart:html' as html;

class UserList extends StatelessWidget {
  UserList({this.user, this.animationController});
  final User user;
  final AnimationController animationController;

  _launchURL(url) {
    html.window.open(url, '');
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: RaisedButton(
          onPressed: () => _launchURL(user.htmlUrl),
          padding: EdgeInsets.all(0.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right:16.0),
                  child: new Image.network(user.image,width: 100.0,height: 100.0,),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        user.name,
                        style: Theme.of(context).textTheme.title
                      ),
                      new Padding(padding: EdgeInsets.only(bottom: 30.0)),
                      new Text('Public Repo : ${user.publicRepos}'),
                      new Padding(padding: EdgeInsets.only(bottom: 6.0)),
                      new Row(
                        children: <Widget>[
                          new Text('Followers : ${user.followers}'),
                          new Padding(padding: EdgeInsets.only(right: 15.0)),
                          new Text('Following : ${user.following}')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
