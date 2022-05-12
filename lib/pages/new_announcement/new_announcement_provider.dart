import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:olx/pages/new_announcement/new_announcement_model.dart';

class NewAnnouncementProvider with ChangeNotifier {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // final NewAnnouncementModel _newAnnouncementModel = NewAnnouncementModel();

  Future<void> saveAnnouncement({
    required List<File> images,
    required NewAnnouncementModel newAnnouncementModel,
  }) async {
    _isLoading = true;
    notifyListeners();
    await _uploadImage(
      images: images,
      newAnnouncementModel: newAnnouncementModel,
    );
    await _saveAnnouncementModel(newAnnouncementModel);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _uploadImage({
    required List<File> images,
    required NewAnnouncementModel newAnnouncementModel,
  }) async {
    UploadTask? uploadTasks;
    String newAnnouncementId = _firebaseFirestore
        .collection('images')
        .doc()
        .id; //pegando o id antes de salvar a imagem

    List<String> imageNamesList =
        []; //salvo o nome dos arquivos em uma lista pra depois conseguir pegar a url de download de cada uma
    String? imageName;
    List<String> urlImagesDownload =
        []; //adiciono a url de download de cada imagem nessa lista pra conseguir salvar essas urls no firestore

    try {
      for (var image in images) {
        imageName = DateTime.now().millisecondsSinceEpoch.toString();
        imageNamesList.add(imageName);
        uploadTasks = _firebaseStorage
            .ref()
            .child('announcements')
            .child(_firebaseAuth.currentUser!.uid)
            .child(newAnnouncementId)
            .child(imageName)
            .putFile(image);
      }
    } catch (e) {
      print('ERRO PARA FAZER O UPLOAD DAS IMAGENS ===== $e');
      _errorMessage = e.toString();
      e;
    }

    uploadTasks!.whenComplete(() async {
      //só tenta obter as URLs de download depois que já fez todos uploads
      for (var image in imageNamesList) {
        String imageUrl = await _firebaseStorage
            .ref()
            .child('my_announcements')
            .child(newAnnouncementId)
            .child(image)
            .getDownloadURL();

        urlImagesDownload.add(
            imageUrl); //adiciona a URL de download de todas imagens nessa lista pra conseguir salvar as URLs do firestore
      }
      newAnnouncementModel.urlImagesDownload = urlImagesDownload;
    });
  }

  Future<void> _saveAnnouncementModel(
    NewAnnouncementModel newAnnouncementModel,
  ) async {
    print(newAnnouncementModel.urlImagesDownload[0]);
    await _firebaseFirestore
        .collection('announcements')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('my_announcements')
        .doc()
        .set(newAnnouncementModel.toMap());
  }
}
