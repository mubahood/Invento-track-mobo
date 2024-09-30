import 'dart:convert';

import 'Utils.dart';

class ResponseModel {
  int code = 0;
  String message = "";
  dynamic data = null;

  dynamic raw;

  ResponseModel(this.raw) {
    if (raw == null) {
      return;
    }

    if (!raw.runtimeType.toString().toLowerCase().contains('map')) {
      if (raw.toString().isEmpty) {
        return;
      }
      try {
        raw = fromJson(json.decode(raw));
      } catch (e) {
        return;
      }
      return;
    }
    code = Utils.int_parse(raw['code'].toString());
    message = raw['message'].toString();
    data = raw['data'];
  }

  //from json
  fromJson(dynamic m) {
    if (m == null) {
      return;
    }
    code = Utils.int_parse(m['code'].toString());
    message = m['message'].toString();
    data = m['data'];
  }
}
