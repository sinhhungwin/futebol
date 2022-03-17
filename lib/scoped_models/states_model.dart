import 'package:fimii/enums/view_state.dart';
import 'package:fimii/models/state.dart';
import 'package:fimii/scoped_models/base_model.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';

class StatesModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String error = 'Something wrong';

  State data;

  onModelReady(country) async{
    setState(ViewState.Busy);
    data = await apiService.fetchStates(country).catchError((e) {
      error = e.toString();
      setState(ViewState.Error);
    });

    if (state == ViewState.Error) return false;

    setState(ViewState.Retrieved);

    return true;

  }
}