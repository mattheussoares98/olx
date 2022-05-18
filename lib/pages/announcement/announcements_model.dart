import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementsModel {
  String? _state;
  String? _type;
  String? _name;
  String? _price;
  String? _phoneNumber;
  String? _description;
  List<dynamic>? _urlImagesDownload;
  String? _id;

  AnnouncementsModel();

  Map<String, dynamic> toMap(List<String> urlImagesDownload) {
    Map<String, dynamic> map = {
      'state': _state,
      'type': _type,
      'name': _name,
      'price': _price,
      'phoneNumber': _phoneNumber,
      'description': _description,
      'images': urlImagesDownload,
    };
    return map;
  }

  void toAnnouncement({
    required QueryDocumentSnapshot<Map<String, dynamic>> doc,
  }) {
    _state = doc['state'];
    _type = doc['type'];
    _name = doc['name'];
    _price = doc['price'];
    _phoneNumber = doc['phoneNumber'];
    _description = doc['description'];
    _urlImagesDownload = doc['images'];
    _id = doc.id;
  }

  String get state => _state!;
  String get id => _id!;
  String get type => _type!;
  String get name => _name!;
  String get price => _price!;
  String get phoneNumber => _phoneNumber!;
  String get description => _description!;
  List<dynamic> get urlImagesDownload => _urlImagesDownload!;

  set state(value) => _state = value;
  set id(value) => _id = value;
  set urlImagesDownload(value) => _urlImagesDownload = value;
  set type(value) => _type = value;
  set name(value) => _name = value;
  set price(value) => _price = value;
  set phoneNumber(value) => _phoneNumber = value;
  set description(value) => _description = value;
}
