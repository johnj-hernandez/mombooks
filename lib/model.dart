class NoteFB {
  String _uid;
  String _titulo;
  String _descripcion;
  String _fecha;
  String _public;
  DateTime _date;
  double _hour;

  NoteFB(this._uid, this._titulo, this._descripcion, this._date, this._fecha, this._public, this._hour);

  NoteFB.map(dynamic obj) {
    this._uid = obj['uid'];
    this._titulo = obj['titulo'];
    this._descripcion = obj['descripcion'];
    this._fecha = obj['fecha'];
    this._date = obj['date'];
    this._public = obj['public'];
    this._hour = obj['hour'];
  }

  String get uid => _uid;
  String get titulo => _titulo;
  String get descripcion => _descripcion;
  DateTime get date => _date;
  String get fecha => _fecha;
  String get public => _public;
  double get hout => _hour;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_uid != null) {
      map['uid'] = _uid;
    }
    map['titulo'] = _titulo;
    map['descripcion'] = _descripcion;
    map['date'] = _date;
    map['fecha'] = _fecha;
    map['public'] = _public;
    map['hour'] = _hour;
    return map;
  }

  NoteFB.fromMap(Map<String, dynamic> map) {
    this._uid = map['uid'];
    this._titulo = map['titulo'];
    this._descripcion = map['descripcion'];
    this._date = map['date'];
    this._fecha = map['fecha'];
    this._public = map['public'];
    this._hour = map['hour'];
  }
}