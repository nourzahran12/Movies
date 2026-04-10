import 'package:flutter/material.dart';

class MovieDetailsPorvider with ChangeNotifier {
  List<Map<String, dynamic>> favouriteMoviesList = [];

  void toggleFavourite(int id, String movieCover, double rate) {
    int index = favouriteMoviesList.indexWhere((movie) => movie['id'] == id);

    if (index != -1) {
      favouriteMoviesList.removeAt(index);
    } else {
      favouriteMoviesList.add({
        "id": id,
        "coverImage": movieCover,
        "movieRate": rate,
      });
    }
    notifyListeners();
  }

  bool isFavourite(int id) {
    return favouriteMoviesList.any((movie) => movie['id'] == id);
  }

  int get favouritesCount => favouriteMoviesList.length;
}
