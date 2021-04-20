import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate {
  @override
  final String searchFieldLabel;
  SearchDestination() : this.searchFieldLabel = 'Searching...';

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
      onPressed: () => this.close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
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
            this.close(context, null);
          },
        )
      ],
    );
  }
}
