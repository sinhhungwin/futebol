import 'package:fimii/enums/view_state.dart';
import 'package:fimii/models/city.dart';
import 'package:fimii/scoped_models/base_model.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';

class CitiesModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String error = 'Something wrong';

  City data;

  onModelReady(country, state) async{
    setState(ViewState.Busy);
    data = await apiService.fetchCities(country, state).catchError((e) {
      error = e.toString();
      setState(ViewState.Error);
    });

    if (state == ViewState.Error) return false;

    setState(ViewState.Retrieved);

    return true;

  }
}