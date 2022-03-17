import 'package:fimii/enums/view_state.dart';
import 'package:fimii/models/country.dart';
import 'package:fimii/scoped_models/base_model.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';

class CountriesModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String error = 'Something wrong';

  Country data;

  onModelReady() async{
    setState(ViewState.Busy);
    data = await apiService.fetchCountries().catchError((e) {
      error = e.toString();
      setState(ViewState.Error);
    });

    if (state == ViewState.Error) return false;

    setState(ViewState.Retrieved);

    return true;

  }
}