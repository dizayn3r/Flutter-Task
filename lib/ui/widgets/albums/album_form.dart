import 'package:flutter/material.dart';
import 'package:flutter_interview_task/core/extensions/space_extension.dart';
import 'package:flutter_interview_task/providers/album_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/album.dart';
import '../show_snackbar.dart';

class AlbumForm extends StatefulWidget {
  final String title;
  final int userId;
  final Album? album;

  const AlbumForm({super.key, required this.title, this.album, required this.userId});

  @override
  State<AlbumForm> createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  final _albumFormKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.album?.title ?? "";
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    return Form(
      key: _albumFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title Input Field
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter album title";
                    }
                    return null;
                  },
                  onSaved: (value) => titleController.text = value!.trim(),
                ).bottomSpacing(16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          titleController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Colors.white,
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: const Text("Reset"),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool validate = _albumFormKey.currentState!.validate();
                          if (validate) {
                            Album album = Album();
                            if (widget.album == null) {
                              albumProvider.createAlbum(album: album).then((value) {
                                if (value) {
                                  showSnackBar(
                                    context: context,
                                    text: "Album created successfully!",
                                    color: Colors.green,
                                  );
                                }
                                Navigator.of(context).pop();
                              });
                            } else {
                              albumProvider.updateAlbum(album: album).then((value) {
                                if (value) {
                                  showSnackBar(
                                    context: context,
                                    text: "Album updated successfully!",
                                    color: Colors.green,
                                  );
                                }
                                Navigator.of(context).pop();
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
