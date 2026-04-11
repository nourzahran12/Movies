import 'package:flutter/material.dart';

import '../firebase_service.dart';

class MovieDetailsPorvider with ChangeNotifier {
  List<Map<String, dynamic>> favouriteMoviesList = [];

  Future<void> toggleFavourite(
    int id,
    String movieCover,
    double rate,
    String userId,
    List<Map<String, dynamic>> historyList,
  ) async {
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
    await FirebaseService.saveUserData(
      userId: userId,
      wishlist: favouriteMoviesList,
      history: historyList,
    );
  }

  bool isFavourite(int id) {
    return favouriteMoviesList.any((movie) => movie['id'] == id);
  }

  int get favouritesCount => favouriteMoviesList.length;
}
