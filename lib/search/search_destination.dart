import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:map_app/models/search_result.dart';
import 'package:map_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;
  SearchDestination(this.proximity)
      : this.searchFieldLabel = 'Searching...',
        this._trafficService = TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => this.query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, SearchResult(cancelled: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    this._trafficService.getQueryResults(this.query.trim(), proximity);

    return Text('data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('place location manually'),
          onTap: () {
            print('Manually');
            this.close(context, SearchResult(cancelled: false, manual: true));
          },
        )
      ],
    );
  }
}
