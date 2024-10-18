import 'package:flutter/material.dart';
import 'package:flutter_application_1/Member,dart';


class FavoriteProvider extends ChangeNotifier {
  final List<Member> _favorites = [];

  List<Member> get favorites => _favorites;

  bool isExist(Member member) {
    return _favorites.contains(member);
  }

  void toggleFavorite(Member member) {
    if (isExist(member)) {
      _favorites.remove(member);
    } else {
      _favorites.add(member);
    }
    notifyListeners();
  }
}
