import 'package:flutter/material.dart';
import 'package:flutter_interview_task/providers/album_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/album.dart';
import '../../screens/photos/photos_screen.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PhotosScreen(albumId: album.id!),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(child: Text(album.title!)),
            IconButton(
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (context) => Dialog(
                //     surfaceTintColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(16.0),
                //     ),
                //     child: UserForm(title: "Update User", user: user),
                //   ),
                // );
              },
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () {
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
                          "Are you sure you want to delete this album?",
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
                          albumProvider.deleteAlbum(
                            userId: album.userId!,
                            albumId: album.id!,
                          );
                          Navigator.of(context).pop();
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
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
