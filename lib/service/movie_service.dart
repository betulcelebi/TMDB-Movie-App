import 'package:dio/dio.dart';
import 'package:movie_app/model/credits_model.dart';
import 'package:movie_app/model/movie_id_model.dart';
import 'package:movie_app/model/popular_movie_model.dart';
import 'package:movie_app/model/top_rated_movie_model.dart';
import 'package:movie_app/model/upcoming_movie_model.dart';

final Dio _dio = Dio(
  BaseOptions(
    baseUrl: "https://api.themoviedb.org/3/movie/",
  ),
);

Future<PopularMovieModelResponse?> getPopularMovieService() async {
  PopularMovieModelResponse? popularMovieResponse;
  try {
    final response = await _dio.get(
        "popular?api_key=3d8b2cb826b637834c4b40f266fef79a&language=en-US&page=1");
    print("betul");

    popularMovieResponse = PopularMovieModelResponse.fromJson(response.data);

    return popularMovieResponse;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<UpComingMovieResponse?> getUpComingMovieService() async {
  UpComingMovieResponse? upComingMovieResponse;
  try {
    final response = await _dio.get(
        "upcoming?api_key=3d8b2cb826b637834c4b40f266fef79a&language=en-US&page=1");
    print("betul");

    upComingMovieResponse = UpComingMovieResponse.fromJson(response.data);

    return upComingMovieResponse;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<TopRatedMovieModelResponse?> getTopRatedMovieService() async {
  TopRatedMovieModelResponse? topRatedMovieResponse;
  try {
    final response = await _dio.get(
        "top_rated?api_key=3d8b2cb826b637834c4b40f266fef79a&language=en-US&page=1");
    print("betul");

    topRatedMovieResponse = TopRatedMovieModelResponse.fromJson(response.data);

    return topRatedMovieResponse;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<MovieIdResponse?> getMovieIdService(String? id) async {
  MovieIdResponse? movieIdResponse;
  try {
    final response = await _dio.get(
        "$id?api_key=3d8b2cb826b637834c4b40f266fef79a&language=en-US&page=1");
    print("betul");

    movieIdResponse = MovieIdResponse.fromJson(response.data);

    return movieIdResponse;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<CreditIdResponse?> getCreditIdService(String? id) async {
  CreditIdResponse? creditIdResponse;
  try {
    final response = await _dio.get(
        "$id/credits?api_key=3d8b2cb826b637834c4b40f266fef79a&language=en-US");
    print("betul");

    creditIdResponse = CreditIdResponse.fromJson(response.data);

    return creditIdResponse;
  } catch (e) {
    print(e);
  }
  return null;
}
