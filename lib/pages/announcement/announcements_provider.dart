import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:olx/pages/announcement/announcements_model.dart';

class AnnouncementsProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Stream<QuerySnapshot<Map<String, dynamic>>>? announcementsStream;
  List<AnnouncementsModel> currentUserAnnouncementsList = [];
  listenChanges() {
    announcementsStream = _firebaseFirestore
        .collection('announcements')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('my_announcements')
        .snapshots();

    announcementsStream!.listen((event) {
      currentUserAnnouncementsList.clear();
      for (var doc in event.docs) {
        AnnouncementsModel _announcementsModel =
            AnnouncementsModel(); //se não instanciar de novo, fica com BUG
        _announcementsModel.toAnnouncement(
          doc: doc,
          announcementsModel: _announcementsModel,
        );

        if (!currentUserAnnouncementsList.contains(_announcementsModel)) {
          currentUserAnnouncementsList.add(_announcementsModel);
        }
      }
    });
  }

  Future<void> deleteAnnouncement(documentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseFirestore
          .collection('announcements')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('my_announcements')
          .doc(documentId)
          .delete(); //excluindo o anúncio

      var listOfAnnouncementsInFirebase = await _firebaseStorage
          .ref()
          .child('announcements')
          .child(_firebaseAuth.currentUser!.uid)
          .child(documentId)
          .list(); //obtendo a lista de imagens

      for (var item in listOfAnnouncementsInFirebase.items) {
        await item.delete(); //percorrendo cada item e excluindo um a um
        //depois que exlui todos items, ele apaga automaticamente o caminho das imagens
      }

      currentUserAnnouncementsList.removeWhere(
        (announcementModel) => announcementModel.id == documentId,
      );

      currentUserAnnouncementsList = [];
    } catch (e) {
      print('ERRO PARA EXCLUIR O ANÚNCIO ============= $e');
      _errorMessage = e.toString();
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
