import 'dart:convert';

import 'package:clean_architecture/config/injection_container.dart';
import 'package:clean_architecture/config/persist.dart';
import 'package:http/http.dart' as http;

export 'package:http/http.dart';

mixin HttpClientMixin {
  final baseUrl = Persist.url;
  final http.Client client = sl<http.Client>();

  void setAuthHeader(Map<String, String> headers) {
    headers['Authorization'] = 'Bearer token';
  }

  ///Validate response utf8
  (int, Map<String, dynamic>) request(http.Response? response) {
    if (response == null) return (500, {'error': 'no encontrada'});

    final int code = response.statusCode;

    if (code != 200) {
      try {
        return (code, {'error': jsonDecode(_responseUtf8(response))});
      } catch (e) {
        return (code, {'error': 'no encontrada'});
      }
    }

    if (response.contentLength! > 0) {
      return (code, {'get': jsonDecode(_responseUtf8(response))});
    }

    return (code, {'get': null});
  }

  ///Parse the response with Utf8 format to common string.
  String _responseUtf8(http.Response response) {
    final List<int> bytes = response.body.codeUnits;
    try {
      return utf8.decode(bytes);
    } catch (e) {
      return 'error';
    }
  }
}
