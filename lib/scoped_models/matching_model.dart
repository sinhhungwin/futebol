import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/base_model.dart';

class MatchingModel extends BaseModel {
  String error = 'Something wrong';

  Map<String, String> filterPitchChoices = {'home': 'Home', 'away': 'Away'};
  Map<String, String> dayOfWeekChoices = {'1': 'Sunday', '2': 'Monday', '3': 'Tuesday', '4': 'Wednesday', '5': 'Thursday', '6': 'Friday', '7': 'Saturday'};
  Map<String, String> distanceChoices = {'5': '5km', '10': '10km', '15': '15km', '20': '20km', '50': '50km'};
  Map<String, String> districtChoices = {'default': 'Choose district'};
  Map<String, String> dateChoices = {'default': 'Choose date'};

  String filterPitchValue;
  String dayOfWeekValue;
  String distanceValue;
  String districtValue;
  String dateValue;


  onModelReady() {
    setState(ViewState.retrieved);

    filterPitchValue = filterPitchChoices.keys.first;
    dayOfWeekValue = dayOfWeekChoices.keys.first;
    distanceValue = distanceChoices.keys.first;
    districtValue = districtChoices.keys.first;
    dateValue = dateChoices.keys.first;
  }


  onFilterPitchValueChanged(newValue) {
    filterPitchValue = newValue;
    notifyListeners();
  }

  onDayOfWeekValueChanged(newValue) {
    dayOfWeekValue = newValue;
    notifyListeners();
  }

  onDistanceValueChanged(newValue) {
    distanceValue = newValue;
    notifyListeners();
  }

  onDistrictValueChanged(newValue) {
    districtValue = newValue;
    notifyListeners();
  }

  onDateValueChanged(newValue) {
    dateValue = newValue;
    notifyListeners();
  }
}