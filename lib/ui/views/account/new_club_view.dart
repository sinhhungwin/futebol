import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/new_club_model.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import '../base_view.dart';

class NewClubView extends StatelessWidget {
  const NewClubView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget viewOptions(NewClubModel model, context) {
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
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Name'),
                  const TextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Description'),
                  const TextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Level: ${model.level.toInt()}'),
                  const SizedBox(
                    height: 5,
                  ),

                  const Text(
                      'Average: Good at handling the ball, passing, moving and good stamina'),

                  Slider(value: model.level, onChanged: model.onLevelChanged, min: model.minLevel, max: model.maxLevel,),
                  const SizedBox(
                    height: 20,
                  ),

                  // Age Range
                  const Text('Age Range'),
                  const SizedBox(height: 5,),
                  CupertinoRadioChoice(
                      choices: NewClubModel.ageRanges,
                      onChange: (selectedGender) {},
                      initialKeyValue: model.selectedAgeRange),

                  const SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Create new club'),
                  ),
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

    return BaseView<NewClubModel>(
        onModelReady: (model) {
          model.onModelReady();
        },
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                title: const Text('Create new club'),
              ),
              body: viewOptions(model, context),
            ));
  }
}
