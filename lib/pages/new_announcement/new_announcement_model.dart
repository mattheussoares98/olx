class NewAnnouncementModel {
  String? _state;
  String? _typeOfAnnouncement;
  String? _name;
  String? _price;
  String? _phoneNumber;
  String? _description;
  List<String> _urlImagesDownload = [];

  NewAnnouncementModel();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'state': _state,
      'typeOfAnnouncement': _typeOfAnnouncement,
      'name': _name,
      'price': _price,
      'phoneNumber': _phoneNumber,
      'description': _description,
      'images': _urlImagesDownload,
    };
    return map;
  }

  String get state => _state!;
  String get typeOfAnnouncement => _typeOfAnnouncement!;
  String get name => _name!;
  String get price => _price!;
  String get phoneNumber => _phoneNumber!;
  String get description => _description!;
  List<String> get urlImagesDownload => _urlImagesDownload;

  set state(value) => _state = value;
  set urlImagesDownload(value) => _urlImagesDownload = value;
  set typeOfAnnouncement(value) => _typeOfAnnouncement = value;
  set name(value) => _name = value;
  set price(value) => _price = value;
  set phoneNumber(value) => _phoneNumber = value;
  set description(value) => _description = value;
}
