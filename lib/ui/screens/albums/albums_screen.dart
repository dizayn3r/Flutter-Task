import 'package:flutter/material.dart';
import 'package:flutter_interview_task/models/album.dart';
import 'package:provider/provider.dart';

import '../../../providers/album_provider.dart';
import '../../widgets/albums/album_list_item.dart';

class AlbumsScreen extends StatefulWidget {
  final int userId;

  const AlbumsScreen({super.key, required this.userId});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAlbums();
    });
    super.initState();
  }

  getAlbums() {
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    albumProvider.getUserAlbums(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Albums"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<AlbumProvider>(
        builder: (context, provider, child) {
          return provider.loading == false
              ? ListView.builder(
                  itemCount: provider.albums.length,
                  itemBuilder: (context, index) {
                    Album album = provider.albums[index];
                    return AlbumListItem(album: album);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
