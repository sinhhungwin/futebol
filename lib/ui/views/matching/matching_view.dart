import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/matching_model.dart';
import 'package:fimii/ui/views/matching/detail_matching_view.dart';
import 'package:fimii/ui/views/matching/new_match_view.dart';
import 'package:flutter/material.dart';
import '../base_view.dart';

class MatchView extends StatelessWidget {
  const MatchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget matchingCard = GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailMatchView()));
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

    Widget viewOptions(MatchingModel model, context) {
      switch (model.state) {
        case ViewState.busy:
          return const Center(child: CircularProgressIndicator());

        case ViewState.error:
          return Text(
            model.error.toString(),
            style: const TextStyle(color: Colors.red),
          );

        case ViewState.retrieved:
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
        case ViewState.idle:
        // TODO: Handle this case.
          break;
      }

      return Container();
    }


    return BaseView<MatchingModel>(
        onModelReady: (model) {
          model.onModelReady();
        },
        builder: (context, child, model) => Scaffold(
          endDrawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: const EdgeInsets.all(8.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Filter (0)'),
                    TextButton(onPressed: () {}, child: const Text('Cancel filters'),),
                  ],
                ),
                const SizedBox(height: 15,),
                const Text('Pitch'),
                CupertinoRadioChoice(
                    choices: model.filterPitchChoices,
                    onChange: model.onFilterPitchValueChanged,
                    initialKeyValue: model.filterPitchValue),

                const SizedBox(height: 15,),
                const Text('Day of Week'),
                CupertinoRadioChoice(
                    choices: model.dayOfWeekChoices,
                    onChange: model.onDayOfWeekValueChanged,
                    initialKeyValue: model.dayOfWeekValue),


                const SizedBox(height: 15,),
                const Text('Distance'),
                CupertinoRadioChoice(
                    choices: model.distanceChoices,
                    onChange: model.onDistanceValueChanged,
                    initialKeyValue: model.distanceValue),


                const SizedBox(height: 15,),
                const Text('District'),
                CupertinoRadioChoice(
                    choices: model.districtChoices,
                    onChange: model.onDistrictValueChanged,
                    initialKeyValue: model.distanceValue),


                const SizedBox(height: 15,),
                const Text('Date'),
                CupertinoRadioChoice(
                    choices: model.dateChoices,
                    onChange: model.onDateValueChanged,
                    initialKeyValue: model.dateValue),

                const SizedBox(height: 25,),
                ElevatedButton(onPressed: () {}, child: const Text('Apply'))

              ],
            ),
          ),
              appBar: AppBar(
                actions: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.filter_alt),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
                  ),
                ],
                title: const Text('Matching...'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewMatchView()));
                },
                child: const Icon(Icons.plus_one),
              ),
              body: viewOptions(model, context),
            ));
  }


}
