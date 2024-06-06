import 'package:flutter/material.dart';

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
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PhotosScreen(albumId: album.id!),
          ),
        );
      },
      title: Text(album.title!),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
