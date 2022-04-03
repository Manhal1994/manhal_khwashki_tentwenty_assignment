part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GetSeachResults extends SearchEvent {
  final String query;
  final int page;
  GetSeachResults({required this.query, required this.page});
}
