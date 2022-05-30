import 'package:fimii/scoped_models/account_model.dart';
import 'package:fimii/scoped_models/home_model.dart';
import 'package:fimii/scoped_models/map_model.dart';
import 'package:fimii/scoped_models/matching_model.dart';
import 'package:fimii/scoped_models/new_club_model.dart';
import 'package:fimii/scoped_models/post_model.dart';
import 'package:fimii/services/api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // register services
  locator.registerLazySingleton<ApiService>(() => ApiService());

  // register models
  locator.registerFactory<AccountModel>(() => AccountModel());
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<MapModel>(() => MapModel());
  locator.registerFactory<MatchingModel>(() => MatchingModel());
  locator.registerFactory<NewClubModel>(() => NewClubModel());
  locator.registerFactory<PostModel>(() => PostModel());
}