class Collision {
  int _id;
  int _idUser;
  String _deviceName;
  String _dateCollision;
  String _mac;

  Collision(
      this._idUser, this._deviceName, this._dateCollision, this._mac
      );

  Collision.map(dynamic obj) {
    this._id = obj['id'];
    this._idUser = obj['idUser'];
    this._deviceName = obj['deviceName'];
    this._dateCollision = obj['dateCollision'];
    this._mac = obj['mac'];
  }

  int get id => _id;
  int get idUser => _idUser;
  String get deviceName => _deviceName;
  String get date => _dateCollision;
  String get mac => _mac;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['idUser']  = _idUser;
    map['deviceName']  = _deviceName;
    map['dateCollision']  = _dateCollision;
    map['mac']  = _mac;

    return map;
  }

  Collision.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._idUser = map['idUser'];
    this._deviceName = map['deviceName'];
    this._dateCollision = map['dateCollision'];
    this._mac = map['mac'];
  }
}
