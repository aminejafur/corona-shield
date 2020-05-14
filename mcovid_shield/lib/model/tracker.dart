class Tracker {
  int _id;
  String _phone;
  String _cin;
  String _mac;
  String _collisions;
  String _moreinfo;

  Tracker(
      this._phone, this._cin, this._mac, this._collisions, this._moreinfo
      );

  Tracker.map(dynamic obj) {
    this._id = obj['id'];
    this._phone = obj['phone'];
    this._cin = obj['cin'];
    this._mac = obj['mac'];
    this._collisions = obj['collisions'];
    this._moreinfo = obj['moreinfo'];
  }

  int get id => _id;
  String get phone => _phone;
  String get cin => _cin;
  String get mac => _mac;
  String get collisions => _collisions;
  String get moreinfo => _moreinfo;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['phone']  = _phone;
    map['cin']  = _cin;
    map['mac']  = _mac;
    map['collisions']  = _collisions;
    map['moreinfo'] = _moreinfo;

    return map;
  }

  Tracker.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._phone = map['phone'];
    this._cin = map['cin'];
    this._mac = map['mac'];
    this._collisions = map['collisions'];
    this._moreinfo = map['moreinfo'];
  }
}
