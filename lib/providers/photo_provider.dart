import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/photo.dart';

class PhotoProvider with ChangeNotifier {
  /// Process Indicator
  bool _loading = false;

  bool get loading => _loading;

  /// Photos List
  List<Photo> _photos = [];

  List<Photo> get photos => _photos;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setPhotos(List<Photo> value) {
    _photos = value;
  }

  /// Get Album Photos
  getAlbumPhotos(int albumId) async {
    setLoading(true);
    http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/$albumId/photos"));
    if (response.statusCode == 200) {
      List<dynamic> temp = jsonDecode(response.body);
      List<Photo> modifiedList = [];
      for (var element in temp) {
        Photo photo = Photo.fromJson(element);
        modifiedList.add(photo);
      }
      setPhotos(modifiedList);
    }
    setLoading(false);
  }

  /// Delete Photo
  Future<bool> deletePhoto(int photoId) async {
    http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos/$photoId"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
