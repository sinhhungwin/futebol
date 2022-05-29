import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/cities_model.dart';
import 'package:fimii/ui/views/matching_view.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class CitiesView extends StatelessWidget {
  String country;
  String state;

  CitiesView({this.country, this.state});

  @override
  Widget build(BuildContext context) {
    return BaseView<CitiesModel>(
        onModelReady: (model) => model.onModelReady(country, state),
        builder: (context, child, model) => Scaffold(
          body: viewOptions(model, context),
        ));
  }

  Widget viewOptions(CitiesModel model, context) {
    switch (model.state) {
      case ViewState.Busy:
        return Center(child: CircularProgressIndicator());

      case ViewState.Error:
        return Text(
          model.error.toString(),
          style: TextStyle(color: Colors.red),
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
                        builder: (context) => MatchView(
                          city: model.data.data[index].city,
                          state: state,
                          country: country,
                        )),
                  );
                },
                child: ListTile(
                  title: Text(model.data.data[index].city),
                  trailing: Icon(Icons.arrow_right),
                ),
              );
            });
    }

    return Container();
  }
}
