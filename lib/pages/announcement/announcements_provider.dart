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
  AnnouncementsModel _announcementsModel = AnnouncementsModel();
  List<AnnouncementsModel> currentUserAnnouncementsList = [];
  listenChanges() {
    currentUserAnnouncementsList.clear();
    announcementsStream = _firebaseFirestore
        .collection('announcements')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('my_announcements')
        .snapshots();

    announcementsStream!.listen((event) {
      for (var doc in event.docs) {
        _announcementsModel =
            AnnouncementsModel(); //se não instanciar de novo, fica com BUG
        _announcementsModel.toAnnouncement(
          doc: doc,
          announcementsModel: _announcementsModel,
        );
        currentUserAnnouncementsList.add(_announcementsModel);
      }
    });
  }

  Future<void> deleteAnnouncement(documentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      // await _firebaseFirestore
      //     .collection('announcements')
      //     .doc(_firebaseAuth.currentUser!.uid)
      //     .collection('my_announcements')
      //     .doc(documentId)
      //     .delete();

      var x = await _firebaseStorage
          .ref()
          .child('announcements')
          .child(_firebaseAuth.currentUser!.uid)
          .child(documentId);

      // print(x);
      // print('x.fullPath = ${x.fullPath}');
      // print('x.name = ${x.name}');
      // print('x.parent = ${x.parent}');
      // print('x.root = ${x.root}');
      // print('x.bucket = ${x.bucket}');

      var list = await x.list();
      print(list.items[0].fullPath);
      print(list.items[0].name);

      // await x.child('1652814695917').delete();

      // await x.child(x.name).delete();

      // currentUserAnnouncementsList.removeWhere(
      //   (announcementModel) => announcementModel.id == documentId,
      // );
    } catch (e) {
      print('ERRO PARA EXCLUIR O ANÚNCIO ============= $e');
      _errorMessage = e.toString();
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
