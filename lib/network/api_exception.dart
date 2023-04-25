class ApiException implements Exception {
  String _message='';

  ApiException([String message = 'Invalid value']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
