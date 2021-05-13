import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/helpers/debouncer.dart';
import 'package:map_app/models/driving_response.dart';
import 'package:map_app/models/search_response.dart';

class TrafficService {
  TrafficService._privateContructor();

  static final TrafficService _instance = TrafficService._privateContructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500));

  final StreamController<SearchResponse> _suggestionsStreamController =
      new StreamController<SearchResponse>.broadcast();

  void dispose() {
    this._suggestionsStreamController.close();
  }

  Stream<SearchResponse> get suggestionsStream =>
      this._suggestionsStreamController.stream;

  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1Ijoibmljb2FyOSIsImEiOiJja25xN25qMmgwOG90MnBxcDlvbTdpYXNnIn0.Cb04-rTYUa_yx_CmBep5Eg';

  Future<DrivingResponse> getCoordsStartToEnd(
      LatLng initialCor, LatLng finalCor) async {
    final coordString =
        '${initialCor.longitude}, ${initialCor.latitude};${finalCor.longitude}, ${finalCor.latitude}';
    final url = '${this._baseUrlDir}/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',
    });
    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }

  Future<SearchResponse> getQueryResults(
      String search, LatLng proximity) async {
    print('SEARCHING!!!');

    final url = '${this._baseUrlGeo}/mapbox.places/$search.json';

    try {
      final resp = await this._dio.get(url, queryParameters: {
        'access_token': this._apiKey,
        'autocomplete': 'true',
        'proximity': '${proximity.longitude},${proximity.latitude}',
        'language': 'es',
      });

      final searchResponse = searchResponseFromJson(resp.data);
      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSuggestionsByQuery(String search, LatLng proximity) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.getQueryResults(value, proximity);
      this._suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = search;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
