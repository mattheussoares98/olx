import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:olx/pages/announcement/announcements_model.dart';

class AnnouncementsProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream? teste;

  Stream<QuerySnapshot<Map<String, dynamic>>>? announcementsStream;

  List<AnnouncementsModel> announcementsList = [];

  AnnouncementsModel _announcementsModel = AnnouncementsModel();
  listenChanges() {
    announcementsList.clear();
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
        announcementsList.add(_announcementsModel);
      }
    });
  }
}
