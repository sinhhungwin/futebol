import 'package:fimii/scoped_models/base_model.dart';

class HomeModel extends BaseModel {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }


}