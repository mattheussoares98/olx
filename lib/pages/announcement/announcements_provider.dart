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

  Stream<QuerySnapshot<Map<String, dynamic>>>? _myAnnouncementsStream;
  final myAnnouncementStreamController =
      StreamController<QuerySnapshot<Map<String, dynamic>>>.broadcast();
  List<AnnouncementsModel> myAnnouncementsList = [];

  Future<void> listenMyAnnouncements() {
    _myAnnouncementsStream = _firebaseFirestore
        .collection('announcements')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('my_announcements')
        .snapshots();

    _myAnnouncementsStream!.listen((event) {
      myAnnouncementStreamController.add(event);
      myAnnouncementsList.clear();
      for (var doc in event.docs) {
        AnnouncementsModel _announcementsModel =
            AnnouncementsModel(); //se não instanciar de novo, fica com BUG
        _announcementsModel.toAnnouncement(
          doc: doc,
        );

        if (!myAnnouncementsList.contains(_announcementsModel)) {
          myAnnouncementsList.add(_announcementsModel);
        }
      }
    });

    return Future.delayed(
        const Duration()); //coloquei esse retorno de um Future pra conseguir usar
    //um RefreshIndicator no MyAnnouncementsPage pra tentar carregar novamente os anúncios
  }

  final List<dynamic> _typesOfAnnouncements = [];
  List<dynamic> get typesOfAnnouncements => _typesOfAnnouncements;
  final List<dynamic> _states = [];
  List<dynamic> get states => _states;

  listenStatesAndTypesOfAnnouncements() async {
    if (_firebaseAuth.currentUser == null) {
      return;
    }
    var allStates = await _firebaseFirestore.collection('states').get();

    List states = allStates.docs[0].data()['states'];
    for (var state in states) {
      _states.add(state);
    }

    var allTypesOfAnnouncements =
        await _firebaseFirestore.collection('typesOfAnnouncements').get();
    List typesOfAnnouncements = allTypesOfAnnouncements.docs[0].data()['types'];
    for (var type in typesOfAnnouncements) {
      _typesOfAnnouncements.add(type);
    }

    notifyListeners();
  }

  filterTypeAnnouncement(String type) async {
    _allAnnouncementsList.clear();
    if (type == 'Tipo de anúncio') {
      var announcements =
          await _firebaseFirestore.collection('allAnnouncements').get();

      for (var announcement in announcements.docs) {
        AnnouncementsModel _announcementsModel =
            AnnouncementsModel(); //se não instanciar de novo, fica com BUG

        _announcementsModel.toAnnouncement(doc: announcement);

        _allAnnouncementsList.add(_announcementsModel);
      }
    } else {
      var announcements = await _firebaseFirestore
          .collection('allAnnouncements')
          .where('type', isEqualTo: type)
          .get();

      for (var announcement in announcements.docs) {
        AnnouncementsModel _announcementsModel =
            AnnouncementsModel(); //se não instanciar de novo, fica com BUG

        _announcementsModel.toAnnouncement(doc: announcement);

        _allAnnouncementsList.add(_announcementsModel);
      }
    }
    notifyListeners();
  }

  filterState(String state) async {
    _allAnnouncementsList.clear();
    if (state == 'Estado') {
      var announcements =
          await _firebaseFirestore.collection('allAnnouncements').get();

      for (var announcement in announcements.docs) {
        AnnouncementsModel announcementsModel = AnnouncementsModel();

        announcementsModel.toAnnouncement(doc: announcement);

        _allAnnouncementsList.add(announcementsModel);
      }
    } else {
      var announcements = await _firebaseFirestore
          .collection('allAnnouncements')
          .where('state', isEqualTo: state)
          .get();

      for (var announcement in announcements.docs) {
        print('teste');
        AnnouncementsModel announcementsModel = AnnouncementsModel();

        announcementsModel.toAnnouncement(doc: announcement);

        _allAnnouncementsList.add(announcementsModel);
      }
    }

    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? _allAnnouncementsStream;
  final allAnnouncementStreamController =
      StreamController<QuerySnapshot<Map<String, dynamic>>>.broadcast();
  final List<AnnouncementsModel> _allAnnouncementsList = [];
  List<AnnouncementsModel> get allAnnouncementsList => _allAnnouncementsList;

  Future<void> listenAllAnnouncements() {
    _allAnnouncementsStream =
        _firebaseFirestore.collection('allAnnouncements').snapshots();

    _allAnnouncementsStream!.listen((event) {
      allAnnouncementStreamController.add(event);
      _allAnnouncementsList.clear();
      for (var doc in event.docs) {
        AnnouncementsModel _announcementsModel =
            AnnouncementsModel(); //se não instanciar de novo, fica com BUG
        _announcementsModel.toAnnouncement(
          doc: doc,
        );

        if (!_allAnnouncementsList.contains(_announcementsModel)) {
          _allAnnouncementsList.add(_announcementsModel);
        }
      }
    });

    return Future.delayed(
        const Duration()); //coloquei esse retorno de um Future pra conseguir usar
    //um RefreshIndicator no MyAnnouncementsPage pra tentar carregar novamente os anúncios
  }

  _deleteImagesInStorage(String documentId) async {
    var imagesInStorage = await _firebaseStorage
        .ref()
        .child('announcements')
        .child(_firebaseAuth.currentUser!.uid)
        .child(documentId)
        .list(); //obtendo a lista de imagens

    for (var item in imagesInStorage.items) {
      await item.delete(); //percorrendo cada item e excluindo um a um
      //depois que exlui todos items, ele apaga automaticamente o caminho das imagens
    }
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
          .delete(); //excluindo meu anúncio

      await _firebaseFirestore
          .collection('allAnnouncements')
          .doc(documentId)
          .delete(); //excluindo de todos anúncios também

      myAnnouncementsList.removeWhere(
        (announcementModel) => announcementModel.id == documentId,
      );

      _deleteImagesInStorage(
          documentId); //coloquei em uma função separada pra não precisar usar
      //o await aqui. Assim, não fica esperando o término da exclusão das
      //imagens para fechar o AlertDialog na página MyAnnouncementsPage
    } catch (e) {
      print('ERRO PARA EXCLUIR O ANÚNCIO ============= $e');
      _errorMessage = e.toString();
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
