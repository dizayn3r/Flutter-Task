import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_interview_task/models/photo.dart';
import 'package:http/http.dart' as http;

class PhotosScreen extends StatefulWidget {
  final int albumId;

  const PhotosScreen({super.key, required this.albumId});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<Photo> photos = [];

  @override
  void initState() {
    getPhotos();
    super.initState();
  }

  getPhotos() async {
    http.Response response = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/albums/${widget.albumId}/photos",
      ),
    );
    List<dynamic> temp = jsonDecode(response.body);
    List<Photo> modifiedList = [];
    for (var element in temp) {
      Photo photo = Photo.fromJson(element);
      modifiedList.add(photo);
    }
    setState(() {
      photos = modifiedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: photos.isNotEmpty
          ? GridView.count(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                photos.length,
                (index) {
                  Photo photo = photos[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(photo.thumbnailUrl!),
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_photo_alternate_rounded),
      ),
    );
  }
}
