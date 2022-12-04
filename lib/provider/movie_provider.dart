import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/credits_model.dart';
import 'package:movie_app/model/movie_id_model.dart';
import 'package:movie_app/model/popular_movie_model.dart';
import 'package:movie_app/model/top_rated_movie_model.dart';
import 'package:movie_app/model/upcoming_movie_model.dart';
import 'package:movie_app/service/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  PopularMovieModelResponse? popularMovieResponse = PopularMovieModelResponse();
  TopRatedMovieModelResponse? topRatedMovieResponse =
      TopRatedMovieModelResponse();
  UpComingMovieResponse? upComingMovieResponse = UpComingMovieResponse();
  MovieIdResponse? movieIdResponse = MovieIdResponse();
  CreditIdResponse? creditIdResponse = CreditIdResponse();

  bool isLoadingPopularMovie = false;
  bool isLoadingTopRatedMovie = false;
  bool isLoadingUpComingMovie = false;
  bool isLoadingMovieId = false;
  bool isLoadingCreditId = false;

  getPopularMovieData() async {
    isLoadingPopularMovie = true;
    popularMovieResponse = await getPopularMovieService();
    isLoadingPopularMovie = false;
    notifyListeners();
  }

  getUpComingMovieData() async {
    isLoadingUpComingMovie = true;
    upComingMovieResponse = await getUpComingMovieService();
    isLoadingUpComingMovie = false;
    notifyListeners();
  }

  getTopRatedMovieData() async {
    isLoadingTopRatedMovie = true;
    topRatedMovieResponse = await getTopRatedMovieService();
    isLoadingTopRatedMovie = false;
    notifyListeners();
  }

  getMovieIdData(String? id) async {
    isLoadingMovieId = true;
    movieIdResponse = await getMovieIdService(id);
    isLoadingMovieId = false;
    notifyListeners();
  }

  getCreditIdData(String? id) async {
    isLoadingCreditId = true;
    creditIdResponse = await getCreditIdService(id);
    isLoadingCreditId = false;
    notifyListeners();
  }
}
