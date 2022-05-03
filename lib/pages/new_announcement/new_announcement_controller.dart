import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/components/show_dialog_component.dart';

class NewAnnouncementController {
  Future<void> addImage({
    required BuildContext context,
    required List<File> images,
  }) async {
    bool? isCamera;

    await ShowDialogComponent().showDialogComponent(
      title: 'Como deseja adicionar a imagem?',
      context: context,
      widgets: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                isCamera = true;
                Navigator.of(context).pop();
              },
              child: Row(
                children: const [
                  Text(
                    'Câmera',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.add_a_photo,
                    size: 30,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                isCamera = false;
                Navigator.of(context).pop();
              },
              child: Row(
                children: const [
                  Text(
                    'Galeria',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.photo_library,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );

    final ImagePicker _picker = ImagePicker();

    if (isCamera != null) {
      XFile? newImage = await _picker.pickImage(
        source: isCamera! ? ImageSource.camera : ImageSource.gallery,
      );

      if (newImage != null) {
        images.add(File(newImage.path));
      }
    }
  }
}
