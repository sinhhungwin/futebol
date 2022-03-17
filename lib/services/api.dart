import 'dart:convert';

import 'package:fimii/models/city.dart';
import 'package:fimii/models/country.dart';
import 'package:fimii/models/state.dart';
import 'package:fimii/models/weather_model.dart';
import 'package:http/http.dart' as http;
import "package:latlong/latlong.dart" as latLng;

class ApiService {
  final urlApi = "https://api.airvisual.com/";
  final keyApi = "563910f0-cb40-48b3-98f3-2245d803e913";

  Future<WeatherModel> fetchWeather(city, state, country, latLng.LatLng coordinates) async {
    Uri uri;

    if (coordinates != null) {
      uri = Uri.parse(urlApi +
        'v2/nearest_city?lat=${coordinates.latitude}&lon=${coordinates.longitude}&key=' +
        keyApi);
    } else if (city != null && state != null && country != null) {
      uri = Uri.parse(urlApi +
          'v2/city?city=$city&state=$state&country=$country&key=' +
          keyApi);
    } else {
      uri = Uri.parse(urlApi + 'v2/nearest_city?key=' + keyApi);
    }

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      return WeatherModel.fromJson(res);
    } else {
      throw Exception(response.body);
    }
  }

  Future<Country> fetchCountries() async {
    final response =
        await http.get(Uri.parse(urlApi + 'v2/countries?key=' + keyApi));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      return Country.fromJson(res);
    } else {
      throw Exception(response.body);
    }
  }

  Future<State> fetchStates(country) async {
    final response = await http
        .get(Uri.parse(urlApi + 'v2/states?country=$country&key=' + keyApi));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      return State.fromJson(res);
    } else {
      throw Exception(response.body);
    }
  }

  Future<City> fetchCities(country, state) async {
    final response = await http.get(Uri.parse(
        urlApi + 'v2/cities?state=$state&country=$country&key=' + keyApi));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      return City.fromJson(res);
    } else {
      throw Exception(response.body);
    }
  }
}
