class UniversalData {
  UniversalData({
    this.data,
    this.error = "",
    this.statusCode = 0,
  });

  dynamic data;
  String error;
  int statusCode;
}
