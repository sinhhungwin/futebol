import 'package:fimii/scoped_models/base_model.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';

class TemplateModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  onModelReady() {

  }
}