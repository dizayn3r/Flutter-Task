import 'package:flutter/material.dart';
import 'package:flutter_interview_task/models/photo.dart';
import 'package:flutter_interview_task/providers/photo_provider.dart';
import 'package:flutter_interview_task/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../widgets/photos/photo_form.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPhotos();
    });
    super.initState();
  }

  getPhotos() async {
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    photoProvider.getAlbumPhotos(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    int crossAxisCount = orientation == Orientation.portrait ? 3 : 5;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos"),
      ),
      body: Consumer<PhotoProvider>(
        builder: (context, provider, child) {
          return !provider.loading
              ? GridView.count(
                  padding: const EdgeInsets.all(16.0),
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: List.generate(
                    provider.photos.length,
                    (index) {
                      Photo photo = provider.photos[index];
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(photo.thumbnailUrl!),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  surfaceTintColor: Colors.white,
                                  icon: const Icon(
                                    Icons.delete_forever_rounded,
                                    color: Colors.red,
                                  ),
                                  title: Column(
                                    children: [
                                      const Text("Delete"),
                                      Text(
                                        "Are you sure you want to delete this photo?",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.red,
                                      ),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        provider.deletePhoto(photo.id!).then((value) {
                                          if (value) {
                                            Navigator.of(context).pop();
                                            showSnackBar(context: context, text: "Photo deleted!", color: Colors.green);
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(4.0),
                                ),
                              ),
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: PhotoForm(),
                );
              });
        },
        child: const Icon(Icons.add_photo_alternate_rounded),
      ),
    );
  }
}
