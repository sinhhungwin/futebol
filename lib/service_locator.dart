import 'package:fimii/scoped_models/cities_model.dart';
import 'package:fimii/scoped_models/countries_model.dart';
import 'package:fimii/scoped_models/home_model.dart';
import 'package:fimii/scoped_models/map_model.dart';
import 'package:fimii/scoped_models/states_model.dart';
import 'package:fimii/scoped_models/your_aqi_model.dart';
import 'package:fimii/services/api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // register services
  locator.registerLazySingleton<ApiService>(() => ApiService());

  // register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<YourAqiModel>(() => YourAqiModel());
  locator.registerFactory<CountriesModel>(() => CountriesModel());
  locator.registerFactory<StatesModel>(() => StatesModel());
  locator.registerFactory<CitiesModel>(() => CitiesModel());
  locator.registerFactory<MapModel>(() => MapModel());



}