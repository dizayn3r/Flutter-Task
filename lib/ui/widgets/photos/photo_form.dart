import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_interview_task/core/extensions/space_extension.dart';
import 'package:image_picker/image_picker.dart';

import '../show_snackbar.dart';

class PhotoForm extends StatefulWidget {
  const PhotoForm({super.key});

  @override
  State<PhotoForm> createState() => _PhotoUserState();
}

class _PhotoUserState extends State<PhotoForm> {
  File? _image;
  final imagePicker = ImagePicker();

  getFromGallery(context) async {
    final picker = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picker != null) {
        _image = File(picker.path);
      } else {
        showSnackBar(context: context, text: "No File selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                "Add Photo",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Image Box
              _image == null
                  ? InkWell(
                      onTap: () => getFromGallery(context),
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          Icons.image_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 60.0,
                        ),
                      ).bottomSpacing(16.0),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(_image!),
                    ).bottomSpacing(16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
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
                        if (_image != null) {
                          setState(() {
                            _image = null;
                            Navigator.of(context).pop();
                          });
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
    );
  }
}
