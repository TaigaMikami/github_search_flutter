import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class LanguageBadge extends StatelessWidget {
  LanguageBadge({this.language});

  final String language;
  Color badgeColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    switch(language) {
      case 'JavaScript':
        badgeColor = Color(0xffF1E05A);
        break;
      case 'Java':
        badgeColor = Color(0xffB07219);
        break;
      case 'Python':
        badgeColor = Color(0xff3572A5);
        break;
      case 'Ruby':
        badgeColor = Color(0xff701516);
        break;
      case 'PHP':
        badgeColor = Color(0xff4F5D95);
        break;
      case 'C++':
        badgeColor = Color(0xffF34B7D);
        break;
      case 'C':
        badgeColor = Color(0xff555555);
        break;
      case 'C#':
        badgeColor = Color(0xff158601);
        break;
      case 'Objective-C':
        badgeColor = Color(0xff438EFF);
        break;
      case 'Shell':
        badgeColor = Color(0xff88E051);
        break;
      case 'R':
        break;
      case 'Go':
        badgeColor = Color(0xff00ADD8);
        break;
      case 'Dart':
        badgeColor = Color(0xff00B4AB);
        break;
      case 'TypeScript':
        badgeColor = Color(0xff2B7489);
        break;
      case 'Rust':
        badgeColor = Color(0xffDEA584);
        break;
      case 'Swift':
        badgeColor = Color(0xffFFAC45);
        break;
      case 'Scala':
        badgeColor = Color(0xffC22D40);
        break;
      case 'Haskell':
        badgeColor = Color(0xff5E5086);
        break;
      default:
        badgeColor = Color(0xff82937F);
        break;
    }

    return Badge(
      badgeColor: badgeColor,
      shape: BadgeShape.square,
      borderRadius: 20,
      badgeContent: Text(
        language,
        style: TextStyle(color: Colors.white, fontSize: 10.0),
      ),
    );
  }
}
