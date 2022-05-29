import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/your_aqi_model.dart';
import 'package:fimii/ui/views/detail_matching_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:latlong/latlong.dart" as latLng;

import 'base_view.dart';

class NewPostView extends StatelessWidget {
  final f = DateFormat('EEEE dd,MMM', "en_US");

  String city, state, country;
  latLng.LatLng coordinates;

  NewPostView({Key key, this.city, this.state, this.country, this.coordinates})
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                   Expanded(
                    child: Text('Post to find opponent, find a slot to play, or post an empty football pitch'
                    , style: Theme.of(context).textTheme.subtitle2,
                    )
                  ),
                  const Divider(),
                  Row(
                    children: const [
                      Icon(Icons.photo_library),
                      SizedBox(width: 5,),
                      Icon(Icons.camera_alt)
                    ],
                  )
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
            title: const Text('Create new post'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.post_add),
          ),
          body: viewOptions(model, context),
        ));
  }


}
