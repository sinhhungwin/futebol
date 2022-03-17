import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/states_model.dart';
import 'package:fimii/ui/views/cities_view.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class StatesView extends StatelessWidget {
  String country;

  StatesView({this.country});

  @override
  Widget build(BuildContext context) {
    return BaseView<StatesModel>(
        onModelReady: (model) => model.onModelReady(country),
        builder: (context, child, model) => Scaffold(
          body: viewOptions(model, context),
        ));
  }

  Widget viewOptions(StatesModel model, context) {
    switch (model.state) {
      case ViewState.Busy:
        return const Center(child: CircularProgressIndicator());

      case ViewState.Error:
        return Text(
          model.error.toString(),
          style: const TextStyle(color: Colors.red),
        );

      case ViewState.Retrieved:
        return ListView.builder(
            itemCount: model.data.data.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitiesView(
                          state: model.data.data[index].state,
                          country: country,
                        )),
                  );
                },
                child: ListTile(
                  title: Text(model.data.data[index].state),
                  trailing: const Icon(Icons.arrow_right),
                ),
              );
            });

      default:
        return Container();
    }
  }
}
