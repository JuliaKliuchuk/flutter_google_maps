class ResponseModel {
  final int _status;
  final String _data;

  ResponseModel(
    this._status,
    this._data,
  );

  int get status => _status;
  String get data => _data;
}
