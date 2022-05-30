import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/base_model.dart';

class NewClubModel extends BaseModel {
  String error = 'Something wrong';

  static final Map<String, String> ageRanges = {
    'U19': 'U19',
    'U23': 'U23',
    'U28': 'U28',
    'U32': 'U32',
    'U50': 'U50'
  };

  double minLevel = 0;
  double maxLevel = 500;

  double level = 0;
  String selectedAgeRange = ageRanges.keys.first;


  onModelReady() {
    setState(ViewState.retrieved);
  }

  onLevelChanged(double newLevel) {
    level = newLevel;
    notifyListeners();
  }

  onAgeChanged(newValue) {
    selectedAgeRange = newValue;
    notifyListeners();
  }
}
