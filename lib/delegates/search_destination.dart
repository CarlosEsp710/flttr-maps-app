import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:maps/models/search_result.dart';
import 'package:maps/models/search_response.dart';
import 'package:maps/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  // ignore: overridden_fields
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;
  final List<SearchResult> history;

  SearchDestination(this.proximity, this.history)
      : searchFieldLabel = 'Buscar...',
        _trafficService = TrafficService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, SearchResult(canel: true)),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _trafficService.getResults(query.trim(), proximity);
    return _buildResultSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text('Colocar ubicación manualmente'),
            onTap: () =>
                close(context, SearchResult(canel: false, manual: true)),
          ),
          ...history
              .map((result) => ListTile(
                    leading: const Icon(Icons.place),
                    title: Text(result.name!),
                    subtitle: Text(result.description!),
                    onTap: () => close(context, result),
                  ))
              .toList(),
        ],
      );
    }

    return _buildResultSuggestions();
  }

  Widget _buildResultSuggestions() {
    if (query.isEmpty) return Container();

    _trafficService.getSuggestions(query.trim(), proximity);
    // _trafficService.getResults(query.trim(), proximity)
    return StreamBuilder(
      stream: _trafficService.suggestionsStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final places = snapshot.data!.features;

        if (places!.isEmpty) {
          return ListTile(title: Text('No hay resultados con $query'));
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_, i) => const Divider(),
          itemCount: places.length,
          itemBuilder: (_, i) => ListTile(
            leading: const Icon(Icons.place),
            title: Text(places[i].textEs!),
            subtitle: Text(places[i].placeNameEs!),
            onTap: () => close(
                context,
                SearchResult(
                  canel: false,
                  manual: false,
                  position: LatLng(
                    places[i].center![1],
                    places[i].center![0],
                  ),
                  name: places[i].textEs,
                  description: places[i].placeNameEs,
                )),
          ),
        );
      },
    );
  }
}
