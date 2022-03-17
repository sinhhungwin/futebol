import 'package:flutter/material.dart';

import 'base_view.dart';

class Template extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder: (context, child, model) => Scaffold(
        body: Center(child: Text(this.runtimeType.toString()),),
      ));
  }
}
