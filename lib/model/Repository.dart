import 'package:flutter/material.dart';

class Repository extends StatelessWidget {
  Repository({this.full_name, this.image, this.stargazers_count, this.forks, this.html_url, this.animationController});

  final String full_name;
  final String image;
  final int stargazers_count;
  final int forks;
  final String html_url;
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
        margin: EdgeInsets.only(bottom: 20.0),
        child: RaisedButton(
          color: Colors.white,
          onPressed: null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            margin: const EdgeInsets.only(right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: Image.network(image, width: 100.0, height: 100.0,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        full_name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 30.0),),
                      Row(
                        children: <Widget>[
                          Text('Stars : $stargazers_count'),
                          Padding(padding: EdgeInsets.only(right: 15.0),),
                          Text('Forks : $forks'),
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
