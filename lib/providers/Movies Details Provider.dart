import 'package:flutter/material.dart';

class MovieDetails with ChangeNotifier {

  List<Map<String, dynamic>> favouriteMoviesList = [];

  void addToFavourites(int id, String movieCover, double rate) {

    if (favouriteMoviesList.any((movie) => movie['id'] == id)) return;

    favouriteMoviesList.add({
      "id": id,
      "coverImage": movieCover,
      "movieRate": rate,
    });

    notifyListeners();
  }

  bool isFavourite(int id) {
    return favouriteMoviesList.any((movie) => movie['id'] == id);
  }

  int get favouritesCount => favouriteMoviesList.length;
}