import 'package:fimii/enums/view_state.dart';
import 'package:fimii/models/weather_model.dart';
import 'package:fimii/scoped_models/base_model.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';

class YourAqiModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String error = 'Something wrong';

  WeatherModel data;

  Future<bool> onModelReady(city, state, country, coordinates) async {
    setState(ViewState.Busy);
    data = await apiService.fetchWeather(city, state, country, coordinates).catchError((e) {
      error = e.toString();
      setState(ViewState.Error);
    });

    if (state == ViewState.Error) return false;

    setState(ViewState.Retrieved);

    return true;
  }
}