// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Movie extends DataClass implements Insertable<Movie> {
  final int id;
  final int page;
  final String response;
  Movie({required this.id, required this.page, required this.response});
  factory Movie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Movie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      page: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}page'])!,
      response: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}response'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['page'] = Variable<int>(page);
    map['response'] = Variable<String>(response);
    return map;
  }

  MoviesCompanion toCompanion(bool nullToAbsent) {
    return MoviesCompanion(
      id: Value(id),
      page: Value(page),
      response: Value(response),
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Movie(
      id: serializer.fromJson<int>(json['id']),
      page: serializer.fromJson<int>(json['page']),
      response: serializer.fromJson<String>(json['response']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'page': serializer.toJson<int>(page),
      'response': serializer.toJson<String>(response),
    };
  }

  Movie copyWith({int? id, int? page, String? response}) => Movie(
        id: id ?? this.id,
        page: page ?? this.page,
        response: response ?? this.response,
      );
  @override
  String toString() {
    return (StringBuffer('Movie(')
          ..write('id: $id, ')
          ..write('page: $page, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, page, response);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movie &&
          other.id == this.id &&
          other.page == this.page &&
          other.response == this.response);
}

class MoviesCompanion extends UpdateCompanion<Movie> {
  final Value<int> id;
  final Value<int> page;
  final Value<String> response;
  const MoviesCompanion({
    this.id = const Value.absent(),
    this.page = const Value.absent(),
    this.response = const Value.absent(),
  });
  MoviesCompanion.insert({
    this.id = const Value.absent(),
    required int page,
    required String response,
  })  : page = Value(page),
        response = Value(response);
  static Insertable<Movie> custom({
    Expression<int>? id,
    Expression<int>? page,
    Expression<String>? response,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (page != null) 'page': page,
      if (response != null) 'response': response,
    });
  }

  MoviesCompanion copyWith(
      {Value<int>? id, Value<int>? page, Value<String>? response}) {
    return MoviesCompanion(
      id: id ?? this.id,
      page: page ?? this.page,
      response: response ?? this.response,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesCompanion(')
          ..write('id: $id, ')
          ..write('page: $page, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }
}

class $MoviesTable extends Movies with TableInfo<$MoviesTable, Movie> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MoviesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _pageMeta = const VerificationMeta('page');
  late final GeneratedColumn<int?> page = GeneratedColumn<int?>(
      'page', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _responseMeta = const VerificationMeta('response');
  late final GeneratedColumn<String?> response = GeneratedColumn<String?>(
      'response', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, page, response];
  @override
  String get aliasedName => _alias ?? 'movies';
  @override
  String get actualTableName => 'movies';
  @override
  VerificationContext validateIntegrity(Insertable<Movie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    } else if (isInserting) {
      context.missing(_responseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Movie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Movie.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MoviesTable createAlias(String alias) {
    return $MoviesTable(_db, alias);
  }
}

class Gener extends DataClass implements Insertable<Gener> {
  final int id;
  final String response;
  Gener({required this.id, required this.response});
  factory Gener.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Gener(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      response: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}response'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['response'] = Variable<String>(response);
    return map;
  }

  GenersCompanion toCompanion(bool nullToAbsent) {
    return GenersCompanion(
      id: Value(id),
      response: Value(response),
    );
  }

  factory Gener.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Gener(
      id: serializer.fromJson<int>(json['id']),
      response: serializer.fromJson<String>(json['response']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'response': serializer.toJson<String>(response),
    };
  }

  Gener copyWith({int? id, String? response}) => Gener(
        id: id ?? this.id,
        response: response ?? this.response,
      );
  @override
  String toString() {
    return (StringBuffer('Gener(')
          ..write('id: $id, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, response);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gener &&
          other.id == this.id &&
          other.response == this.response);
}

class GenersCompanion extends UpdateCompanion<Gener> {
  final Value<int> id;
  final Value<String> response;
  const GenersCompanion({
    this.id = const Value.absent(),
    this.response = const Value.absent(),
  });
  GenersCompanion.insert({
    this.id = const Value.absent(),
    required String response,
  }) : response = Value(response);
  static Insertable<Gener> custom({
    Expression<int>? id,
    Expression<String>? response,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (response != null) 'response': response,
    });
  }

  GenersCompanion copyWith({Value<int>? id, Value<String>? response}) {
    return GenersCompanion(
      id: id ?? this.id,
      response: response ?? this.response,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenersCompanion(')
          ..write('id: $id, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }
}

class $GenersTable extends Geners with TableInfo<$GenersTable, Gener> {
  final GeneratedDatabase _db;
  final String? _alias;
  $GenersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _responseMeta = const VerificationMeta('response');
  late final GeneratedColumn<String?> response = GeneratedColumn<String?>(
      'response', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, response];
  @override
  String get aliasedName => _alias ?? 'geners';
  @override
  String get actualTableName => 'geners';
  @override
  VerificationContext validateIntegrity(Insertable<Gener> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    } else if (isInserting) {
      context.missing(_responseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gener map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Gener.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $GenersTable createAlias(String alias) {
    return $GenersTable(_db, alias);
  }
}

class SearchResult extends DataClass implements Insertable<SearchResult> {
  final int id;
  final String query;
  final String response;
  SearchResult({required this.id, required this.query, required this.response});
  factory SearchResult.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchResult(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      query: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}query'])!,
      response: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}response'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['query'] = Variable<String>(query);
    map['response'] = Variable<String>(response);
    return map;
  }

  SearchResultsCompanion toCompanion(bool nullToAbsent) {
    return SearchResultsCompanion(
      id: Value(id),
      query: Value(query),
      response: Value(response),
    );
  }

  factory SearchResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SearchResult(
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
      response: serializer.fromJson<String>(json['response']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
      'response': serializer.toJson<String>(response),
    };
  }

  SearchResult copyWith({int? id, String? query, String? response}) =>
      SearchResult(
        id: id ?? this.id,
        query: query ?? this.query,
        response: response ?? this.response,
      );
  @override
  String toString() {
    return (StringBuffer('SearchResult(')
          ..write('id: $id, ')
          ..write('query: $query, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, query, response);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchResult &&
          other.id == this.id &&
          other.query == this.query &&
          other.response == this.response);
}

class SearchResultsCompanion extends UpdateCompanion<SearchResult> {
  final Value<int> id;
  final Value<String> query;
  final Value<String> response;
  const SearchResultsCompanion({
    this.id = const Value.absent(),
    this.query = const Value.absent(),
    this.response = const Value.absent(),
  });
  SearchResultsCompanion.insert({
    this.id = const Value.absent(),
    required String query,
    required String response,
  })  : query = Value(query),
        response = Value(response);
  static Insertable<SearchResult> custom({
    Expression<int>? id,
    Expression<String>? query,
    Expression<String>? response,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (query != null) 'query': query,
      if (response != null) 'response': response,
    });
  }

  SearchResultsCompanion copyWith(
      {Value<int>? id, Value<String>? query, Value<String>? response}) {
    return SearchResultsCompanion(
      id: id ?? this.id,
      query: query ?? this.query,
      response: response ?? this.response,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchResultsCompanion(')
          ..write('id: $id, ')
          ..write('query: $query, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }
}

class $SearchResultsTable extends SearchResults
    with TableInfo<$SearchResultsTable, SearchResult> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SearchResultsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _queryMeta = const VerificationMeta('query');
  late final GeneratedColumn<String?> query = GeneratedColumn<String?>(
      'query', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _responseMeta = const VerificationMeta('response');
  late final GeneratedColumn<String?> response = GeneratedColumn<String?>(
      'response', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, query, response];
  @override
  String get aliasedName => _alias ?? 'search_results';
  @override
  String get actualTableName => 'search_results';
  @override
  VerificationContext validateIntegrity(Insertable<SearchResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    } else if (isInserting) {
      context.missing(_responseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SearchResult.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchResultsTable createAlias(String alias) {
    return $SearchResultsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MoviesTable movies = $MoviesTable(this);
  late final $GenersTable geners = $GenersTable(this);
  late final $SearchResultsTable searchResults = $SearchResultsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [movies, geners, searchResults];
}
