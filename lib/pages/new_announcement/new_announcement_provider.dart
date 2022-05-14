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

  static List<String> _urlImagesDownload = [];
  Future<void> saveAnnouncement({
    required List<File> images,
    required NewAnnouncementModel newAnnouncementModel,
  }) async {
    _isLoading = true;
    notifyListeners();

    String newAnnouncementId = _firebaseFirestore
        .collection('images')
        .doc()
        .id; //pegando o id antes de salvar a imagem. Coloquei aqui o ID pra ter o mesmo id no firebaseStorage e firestore

    await _uploadImage(
      newAnnouncementId: newAnnouncementId,
      images: images,
      newAnnouncementModel: newAnnouncementModel,
    );

    await _saveAnnouncementModel(
      newAnnouncementId: newAnnouncementId,
      newAnnouncementModel: newAnnouncementModel,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _uploadImage({
    required List<File> images,
    required String newAnnouncementId,
    required NewAnnouncementModel newAnnouncementModel,
  }) async {
    _urlImagesDownload.clear();
    UploadTask? uploadTasks;

    List<dynamic> imageNamesList =
        []; //salvo o nome dos arquivos em uma lista pra depois conseguir pegar a url de download de cada uma
    String? imageName;

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

    await uploadTasks!.whenComplete(() async {
      //só tenta obter as URLs de download depois que já fez todos uploads
      for (var image in imageNamesList) {
        String imageUrl = await _firebaseStorage
            .ref()
            .child('announcements')
            .child(_firebaseAuth.currentUser!.uid)
            .child(newAnnouncementId)
            .child(image)
            .getDownloadURL();

        _urlImagesDownload.add(imageUrl);
        print(_urlImagesDownload);
      }
    });
    notifyListeners();
  }

  Future<void> _saveAnnouncementModel({
    required String newAnnouncementId,
    required NewAnnouncementModel newAnnouncementModel,
  }) async {
    await _firebaseFirestore
        .collection('announcements')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('my_announcements')
        .doc(newAnnouncementId)
        .set(newAnnouncementModel.toMap(_urlImagesDownload));
  }
}
