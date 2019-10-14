import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({this.searching, this.api_no_limit});

  final bool searching;
  final bool api_no_limit;

  @override
  Widget build(BuildContext context) {
    if(searching){
      return new Container(
        height: 60.0,
        child:new Center(
          child:new CircularProgressIndicator()
        ),
      );
    } else if(api_no_limit) {
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
}

