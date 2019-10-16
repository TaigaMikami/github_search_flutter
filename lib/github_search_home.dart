import 'package:flutter/material.dart';
import 'package:github_search/pages/repository_compare_screen.dart';
import 'package:github_search/pages/repository_screen.dart';
import 'package:github_search/pages/gist_screen.dart';
import 'package:github_search/pages/user_screen.dart';

class GithubSearchHome extends StatefulWidget {

  @override
  _GithubSearchHomeState createState() => _GithubSearchHomeState();
}

class _GithubSearchHomeState extends State<GithubSearchHome> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> screenTabs = <Tab>[
    Tab(text: 'Repository',),
    Tab(text: 'Compare',),
    Tab(text: 'Gist',),
    Tab(text: 'User',),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: screenTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Search"),
        elevation: 0.7,
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black38,
          tabs: screenTabs,
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          RepositoryScreen(),
          RepositoryCompareScreen(),
          GistScreen(),
          UserScreen(),
        ],
      ),
    );
  }
}
