import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/matching_model.dart';
import 'package:fimii/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class DetailMatchView extends StatelessWidget {
  const DetailMatchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MatchingModel>(
        onModelReady: (model) {
          model.onModelReady();
        },
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(
            title: const Text('Matching...'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.sports_soccer),
          ),
          body: viewOptions(model, context),
        ));
  }

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
                      children: [
                        Card(
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

                              // Detail
                              Text('Detail', style: Theme.of(context).textTheme.headline2,),

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

                              // City and District
                              Row(
                                children: const [
                                  Text('📍 Khương Đình, Thanh Xuân'),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              // Contact
                              Text('Contact', style: Theme.of(context).textTheme.headline2,),

                              Row(
                                children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://upload.wikimedia.org/wikipedia/vi/thumb/a/a1/Man_Utd_FC_.svg/1200px-Man_Utd_FC_.svg.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('0957172...'),
                                      Text('Join this match to see phone number')
                                    ],
                                  )
                                    ],

                              )

                            ],
                          ),
                        ),
                      ),
                      ],
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
}
