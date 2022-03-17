import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/countries_model.dart';
import 'package:fimii/ui/views/states_view.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class CountriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<CountriesModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) => Scaffold(
              body: viewOptions(model, context),
            ));
  }

  Widget viewOptions(CountriesModel model, context) {
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
                        builder: (context) => StatesView(
                              country: model.data.data[index].country,
                            )),
                  );
                },
                child: ListTile(
                  leading: SizedBox(
                    height: 20,
                    child: Image.asset(
                      'assets/flags/${model.data.data[index].country.toLowerCase()}.jpg'.replaceAll(' ', '-'),
                      errorBuilder: (_, __, ___) => const SizedBox(height: 10,),
                    ),
                  ),
                  title: Text(model.data.data[index].country),
                  trailing: const Icon(Icons.arrow_right),
                ),
              );
            });

      default:
        return Container();
    }
  }
}
