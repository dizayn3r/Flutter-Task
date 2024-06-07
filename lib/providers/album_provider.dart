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
      Album album = Album.fromJson(element);
      modifiedList.add(album);
    }
    setAlbums(modifiedList);
    setLoading(false);
  }

  /// Create User
  Future<bool> createAlbum({required Album album}) async {
    http.Response response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/albums"),
      body: jsonEncode(album.toJson()),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  /// Update User
  Future<bool> updateAlbum({required Album album}) async {
    http.Response response = await http.patch(
      Uri.parse("https://jsonplaceholder.typicode.com/albums${album.id}"),
      body: jsonEncode(album.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// Delete Album
  Future<bool> deleteAlbum(int albumId) async {
    http.Response response = await http.delete(
      Uri.parse("https://jsonplaceholder.typicode.com/albums/$albumId"),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
