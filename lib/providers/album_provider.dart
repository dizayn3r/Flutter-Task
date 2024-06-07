import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/album.dart';

class AlbumProvider with ChangeNotifier {
  /// Process Indicator
  bool _loading = false;

  bool get loading => _loading;

  /// Albums List
  List<Album> _albums = [];

  List<Album> get albums => _albums;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setAlbums(List<Album> value) {
    _albums = value;
  }

  /// Get User Albums
  getUserAlbums(int userId) async {
    setLoading(true);
    http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users/$userId/albums"));
    List<dynamic> temp = jsonDecode(response.body);
    List<Album> modifiedList = [];
    for (var element in temp) {
      Album user = Album.fromJson(element);
      modifiedList.add(user);
    }
    setAlbums(modifiedList);
    setLoading(false);
  }

  /// Delete Album
  Future<bool> deleteAlbum({required int userId, required int albumId}) async {
    http.Response response = await http.delete(
      Uri.parse("https://jsonplaceholder.typicode.com/users/$userId/albums/$albumId"),
    );
    if (response.statusCode == 200) {
      _removeAlbum(userId);
      return true;
    } else {
      return false;
    }
  }

  /// TODO: This is for testing purpose
  _removeAlbum(int userId) {
    setLoading(true);
    _albums.removeWhere((element) => element.id == userId);
    setLoading(false);
  }
}
