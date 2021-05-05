import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/models/driving_response.dart';

class TrafficService {
  TrafficService._privateContructor();

  static final TrafficService _instance = TrafficService._privateContructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final baseUrl = 'https://api.mapbox.com/directions/v5';
  final apiKey =
      'pk.eyJ1Ijoibmljb2FyOSIsImEiOiJja25xN25qMmgwOG90MnBxcDlvbTdpYXNnIn0.Cb04-rTYUa_yx_CmBep5Eg';

  Future<DrivingResponse> getCoordsStartToEnd(
      LatLng initialCor, LatLng finalCor) async {
    print('initialCor $initialCor');
    print('finalCor $finalCor');
    final coordString =
        '${initialCor.longitude}, ${initialCor.latitude};${finalCor.longitude}, ${finalCor.latitude}';
    final url = '${this.baseUrl}/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this.apiKey,
      'language': 'es',
    });
    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }
}
