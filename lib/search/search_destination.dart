import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:map_app/models/search_response.dart';
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
    return Text('data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
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
    return this._buildResultSuggestions();
  }

  Widget _buildResultSuggestions() {
    this
        ._trafficService
        .getSuggestionsByQuery(this.query.trim(), this.proximity);

    return StreamBuilder(
      stream: this._trafficService.suggestionsStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final places = snapshot.data.features;
        if (places.length == 0) {
          return ListTile(
            title: Text('Could not find results for $query'),
          );
        }

        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (_, __) {
            return Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            final place = places[index];

            return ListTile(
              leading: Icon(Icons.place),
              title: Text(place.placeName),
              subtitle: Text(place.placeNameEs),
              onTap: () {
                this.close(
                  context,
                  SearchResult(
                      cancelled: false,
                      manual: false,
                      location: LatLng(
                        place.center[1],
                        place.center[0],
                      ),
                      destinationName: place.placeName,
                      description: place.placeNameEs),
                );
              },
            );
          },
        );
      },
    );
  }
}
