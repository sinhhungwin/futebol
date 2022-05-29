import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/your_aqi_model.dart';
import 'package:fimii/ui/views/detail_matching_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:latlong/latlong.dart" as latLng;

import 'base_view.dart';

class MatchView extends StatelessWidget {
  final f = DateFormat('EEEE dd,MMM', "en_US");

  String city, state, country;
  latLng.LatLng coordinates;

  MatchView({Key key, this.city, this.state, this.country, this.coordinates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget matchingCard = GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMatchView()));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Matching clubs row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/vi/thumb/a/a1/Man_Utd_FC_.svg/1200px-Man_Utd_FC_.svg.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text('💪 101 (Super Weak)'),
                      const Text('⭐ 4.33'),
                      const Text('🤝 100')
                    ],
                  ),
                  const Text('VS'),
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/img/question-mark.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text('Waiting for opponent...'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              // Time Row
              Row(
                children: const [
                  Text('⌚ Monday, 23/05 20:30'),
                  Text('in about 3 hours')
                ],
              ),

              // Place Row
              Row(
                children: const [Text('🌎 sân Đầm Hồng 1'), Text('~5.12km')],
              ),
              const SizedBox(
                height: 10,
              ),

              const Divider(),

              // Like, Comment and Sharing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Like
                  Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        size: 25,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("4"),
                    ],
                  ),

                  // Comments
                  Row(
                    children: const [
                      Icon(
                        Icons.web,
                        size: 25,
                        color: Colors.lightBlueAccent,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("2"),
                    ],
                  ),

                  // Share
                  Row(
                    children: const [
                      Icon(
                        Icons.share,
                        size: 25,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Share"),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [matchingCard, matchingCard, matchingCard],
                      ),
                    ),
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Matching...'),
                    Row(
                      children: const [
                        Icon(Icons.filter_alt),
                        Text('Filtering (0)'),
                      ],
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.plus_one),
              ),
              body: viewOptions(model, context),
            ));
  }


}
