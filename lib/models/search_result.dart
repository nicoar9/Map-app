import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool cancelled;
  final bool manual;
  final LatLng location;
  final String destinationName;
  final String description;

  SearchResult(
      {@required this.cancelled,
      this.manual,
      this.location,
      this.destinationName,
      this.description});
}
