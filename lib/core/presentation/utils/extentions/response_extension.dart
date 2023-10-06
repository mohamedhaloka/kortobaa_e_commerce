import 'dart:convert';

import 'package:dio/dio.dart';

extension ResponseErrorMessage on Response<dynamic>? {
  String? getErrorMessage() {
    if (this == null) return null;
    final data = this!.data;
    if (data is Map<String, dynamic>) {
      if (data.containsKey('detail')) {
        return data['detail'];
      }
    }

    return json.encode(data);
  }
}
