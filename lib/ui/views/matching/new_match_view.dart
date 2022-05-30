import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/matching_model.dart';
import 'package:fimii/ui/views/matching/detail_matching_view.dart';
import 'package:flutter/material.dart';
import '../base_view.dart';

class NewMatchView extends StatelessWidget {
  const NewMatchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Club Picker
                          Row(
                            children: [
                              Text(
                                'Pick your club',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const SizedBox(
                                width: 40,
                              ),
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
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Cirkus FC'),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Text('Pitch',
                              style: Theme.of(context).textTheme.headline2),
                          ElevatedButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => ))
                              },
                              child: const Text('Choose pitch')),

                          const SizedBox(
                            height: 20,
                          ),
                          Text('Time',
                              style: Theme.of(context).textTheme.headline2),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Choose time')),

                          const SizedBox(
                            height: 20,
                          ),
                          Text('Contact',
                              style: Theme.of(context).textTheme.headline2),
                          const TextField(),

                          const SizedBox(
                            height: 20,
                          ),
                          Text('Description',
                              style: Theme.of(context).textTheme.headline2),
                          const TextField(),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Apply'))
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
          appBar: AppBar(
            title: const Text('Create new match'),
          ),
              body: viewOptions(model, context),
            ));
  }
}
