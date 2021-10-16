import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:maps/helpers/debouncer.dart';
import 'package:maps/models/info_response.dart';
import 'package:maps/models/search_response.dart';
import 'package:maps/models/traffic_response.dart';

class TrafficService {
  TrafficService._privateContructor();
  static final TrafficService _instance = TrafficService._privateContructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final debouncer =
      Debouncer<String>(duration: const Duration(milliseconds: 500));

  final StreamController<SearchResponse> _suggestionsStreamController =
      StreamController<SearchResponse>.broadcast();

  Stream<SearchResponse> get suggestionsStream =>
      _suggestionsStreamController.stream;

  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1IjoiY2FybG9zZXNwNzEiLCJhIjoiY2t1bjhhMDdwM3l1ZDJwcTZjeHhqZmhsNiJ9.b_MOqnaPpUJhls3EMx-aDg';

  Future<TrafficResponse> getCoords(LatLng start, LatLng destination) async {
    final coordString =
        '${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}';
    final url =
        '$_baseUrlDir/mapbox/driving/$coordString?alternatives=true&geometries=polyline6&steps=false&access_token=$_apiKey';

    final response = await _dio.get(url);

    final data = TrafficResponse.fromJson(response.data);

    return data;
  }

  Future<SearchResponse> getResults(String search, LatLng proximity) async {
    final url = '$_baseUrlGeo/mapbox.places/$search.json';

    try {
      final response = await _dio.get(
          '$url?access_token=$_apiKey&autocomplete=true&proximity=${proximity.longitude},${proximity.latitude}&language=es');

      final searchResponse = searchResponseFromJson(response.data);

      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSuggestions(String search, LatLng proximity) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await getResults(value, proximity);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      debouncer.value = search;
    });

    Future.delayed(const Duration(milliseconds: 201))
        .then((_) => timer.cancel());
  }

  Future<InfoResponse> getCoordsInfo(LatLng coords) async {
    final url = '$_baseUrlGeo/mapbox.places';
    final response = await _dio.get(
        '$url/${coords.longitude},${coords.latitude}.json?access_token=$_apiKey&language=es');

    final infoResponse = infoResponseFromJson(response.data);

    return infoResponse;
  }
}
