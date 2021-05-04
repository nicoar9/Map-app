import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  TrafficService._privateContructor();

  static final TrafficService _instance = TrafficService._privateContructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();

  Future getCoordsStartToEnd(LatLng initialCor, LatLng finalCor) async {
    print('initialCor $initialCor');
    print('finalCor $finalCor');
  }
}
