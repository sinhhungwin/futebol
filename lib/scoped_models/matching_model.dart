import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/base_model.dart';

class MatchingModel extends BaseModel {

  String error = 'Something wrong';

  onModelReady() {
    setState(ViewState.retrieved);
  }
}