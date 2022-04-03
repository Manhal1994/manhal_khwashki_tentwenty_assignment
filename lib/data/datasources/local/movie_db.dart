import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:moor/ffi.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
part 'movie_db.g.dart';

class Movies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get page => integer()();
  TextColumn get response => text()();
}

class Geners extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get response => text()();
}

class SearchResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get query => text()();
  TextColumn get response => text()();
}

@UseMoor(tables: [Movies, Geners, SearchResults])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  // Get the upcoming movies from movieDB.
  Future<String?>? getUpcomingMovies(int page) async {
    var results =
        await (select(movies)..where((tbl) => tbl.page.equals(page))).get();
    if (results.isNotEmpty) {
      return results[results.length - 1].response;
    } else {
      return null;
    }
  }

  Future<String?>? getGeners() async {
    var results = await (select(geners)).get();
    if (results.isNotEmpty) {
      return results[results.length - 1].response;
    } else {
      return null;
    }
  }

  Future<String?>? getSearchResults({required String query}) async {
    var results = await (select(searchResults)
          ..where((tbl) => tbl.query.equals(query)))
        .get();
    if (results.isNotEmpty) {
      return results[results.length - 1].response;
    } else {
      return null;
    }
  }

  Future<dynamic> cacheUpcomingMovies(
      {required int page, required String response}) async {
    return into(movies)
      ..insert(MoviesCompanion(
          page: Value<int>(page), response: Value<String>(response)));
  }

  Future<dynamic> cacheGeners({required String response}) async {
    return into(geners)
      ..insert(GenersCompanion(response: Value<String>(response)));
  }

  Future<dynamic> cacheSearchResults(
      {required String query, required String response}) async {
    return into(searchResults)
      ..insert(SearchResultsCompanion(
          response: Value<String>(response), query: Value<String>(query)));
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
