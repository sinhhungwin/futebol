import 'package:fimii/scoped_models/home_model.dart';
import 'package:fimii/ui/views/matching/matching_view.dart';
import 'package:fimii/ui/views/post/post_view.dart';
import 'package:fimii/ui/views/account/account_view.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        builder: (context, child, model) => Scaffold(
              body: _screenOptions[model.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer),
                label: 'Matching',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.web_outlined),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            currentIndex: model.selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: model.onItemTapped,
          ),

        ),);
  }

  final List<Widget> _screenOptions = <Widget>[
    MatchView(),
    const PostView(),
    const AccountView()
  ];
}