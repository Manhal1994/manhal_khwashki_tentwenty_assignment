import 'package:injectable/injectable.dart';
import 'package:mymovie/data/models/search_model.dart';
import 'package:mymovie/data/models/video_model.dart';

import 'models/general_model.dart';

abstract class MovieRepository {
  // Get upcoming movies
  getUpComingMovies({required int page});
  // Get Movie trailer Video Link
  Future<VideosModel> getVideoLink({required int id});
  // Get Movie's geners
  Future<GenralModel?> getGeners();
  // search for Movies
  Future<SearchModel?> search({required int page, required String query});
}
