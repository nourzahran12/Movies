import 'package:flutter/material.dart';

class WatchHistory with ChangeNotifier {

  List<Map<String, dynamic>> watchHistoryMoviesList = [];

  void addToFavourites(int id, String movieCover, double rate) {

    if (watchHistoryMoviesList.any((movie) => movie['id'] == id)) return;

    watchHistoryMoviesList.add({
      "id": id,
      "coverImage": movieCover,
      "movieRate": rate,
    });

    notifyListeners();
  }

  bool isFavourite(int id) {
    return watchHistoryMoviesList.any((movie) => movie['id'] == id);
  }

  int get watchHistoryCount => watchHistoryMoviesList.length;
}