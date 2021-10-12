import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps/models/traffic_response.dart';

class TrafficService {
  TrafficService._privateContructor();
  static final TrafficService _instance = TrafficService._privateContructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey =
      'pk.eyJ1IjoiY2FybG9zZXNwNzEiLCJhIjoiY2t1bjhhMDdwM3l1ZDJwcTZjeHhqZmhsNiJ9.b_MOqnaPpUJhls3EMx-aDg';

  Future<TrafficResponse> getCoords(LatLng start, LatLng destination) async {
    final coordString =
        '${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}';
    final url =
        '$_baseUrl/mapbox/driving/$coordString?alternatives=true&geometries=polyline6&steps=false&access_token=$_apiKey';

    final response = await _dio.get(url);

    final data = TrafficResponse.fromJson(response.data);

    return data;
  }
}
