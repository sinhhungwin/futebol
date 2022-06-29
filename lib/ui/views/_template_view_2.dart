import 'package:fimii/enums/view_state.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class Template extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, child, model) {
        switch(model.state) {
          case ViewState.busy:

          case ViewState.retrieved:

          case ViewState.error:

          default:
            return const Scaffold();
        }
    });
  }
}
