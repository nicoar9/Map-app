part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnEnabledManualMarker extends SearchEvent {}

class OnDisabledManualMarker extends SearchEvent {}
