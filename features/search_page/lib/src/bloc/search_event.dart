part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class InitEvent extends SearchEvent {
  const InitEvent();
}

class SearchPhotosEvent extends SearchEvent {
  final String query;

  const SearchPhotosEvent({required this.query});
}

