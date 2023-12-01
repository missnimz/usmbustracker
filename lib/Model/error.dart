class Error {
  String? errors;

  Error({this.errors});

  Error.fromJson(Map<String, dynamic> json) {
    errors = json['Errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Errors'] = errors;
    return data;
  }
}