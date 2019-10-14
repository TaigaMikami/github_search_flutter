import 'package:flutter/material.dart';
import 'package:github_search/model/Repository.dart';

class RepositoryCard extends StatelessWidget {
  RepositoryCard({this.repository, this.animationController});

  final Repository repository;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: RaisedButton(
          onPressed: null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            margin: const EdgeInsets.only(right: 5.0),
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
                      Text(
                        repository.full_name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 30.0),),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Text('${repository.stargazers_count}'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Icon(Icons.security),
                          Text('${repository.forks}'),
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
