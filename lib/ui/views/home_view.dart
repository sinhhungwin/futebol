import 'package:fimii/scoped_models/home_model.dart';
import 'package:fimii/ui/views/countries_view.dart';
import 'package:fimii/ui/views/map_view.dart';
import 'package:fimii/ui/views/your_aqi_view.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        builder: (context, child, model) => Scaffold(
              body: _screenOptions[model.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Your AQI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                label: 'Cities',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
            ],
            currentIndex: model.selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: model.onItemTapped,
          ),

        ),);
  }

  List<Widget> _screenOptions = <Widget>[
    YourAqiView(),
    CountriesView(),
    MapView()
  ];
}