import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/your_aqi_model.dart';
import 'package:fimii/ui/views/detail_matching_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:latlong/latlong.dart" as latLng;

import 'base_view.dart';

class NewClubView extends StatelessWidget {
  final f = DateFormat('EEEE dd,MMM', "en_US");

  String city, state, country;
  latLng.LatLng coordinates;

  NewClubView({Key key, this.city, this.state, this.country, this.coordinates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget viewOptions(YourAqiModel model, context) {
      switch (model.state) {
        case ViewState.Busy:
          return const Center(child: CircularProgressIndicator());

        case ViewState.Error:
          return Text(
            model.error.toString(),
            style: const TextStyle(color: Colors.red),
          );

        case ViewState.Retrieved:
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Name'),
                  TextField(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Description'),
                  TextField(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Level: 369'),
                  SizedBox(
                    height: 5,
                  ),

                  Text(
                      'Average: Good at handling the ball, passing, moving and good stamina'),

                  // TODO: Slider here

                  SizedBox(
                    height: 20,
                  ),

                  // Age Range
                  Text('Age Range'),

                  // TODO: Age Radio Here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('U16'),
                      Text('U19'),
                      Text('U23'),
                      Text('U28'),
                      Text('U32'),
                      Text('U50'),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Create new club'),
                  ),
                ],
              ),
            ),
          );
        case ViewState.Idle:
          // TODO: Handle this case.
          break;
      }

      return Container();
    }

    return BaseView<YourAqiModel>(
        onModelReady: (model) {
          model.onModelReady(city, state, country, coordinates);
        },
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                title: const Text('Create new club'),
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {},
              //   child: const Icon(Icons.plus_one),
              // ),
              body: viewOptions(model, context),
            ));
  }
}
