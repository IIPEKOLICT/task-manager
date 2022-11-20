import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseRepository {
  BaseRepository(this._endpoint);

  final String _endpoint;
  final String _token = '';
  final String _baseUrl = dotenv.get('BACKEND_URL');

  final httpClient = Client();

  get _headers {
    return { 'Authorization': _token };
  }

  Uri _getUri(String path) {
    return Uri.http('$_baseUrl/$_endpoint/$path');
  }

  Future<Response> get({String path = ''}) async {
    return httpClient.get(_getUri(path), headers: _headers);
  }

  Future<Response> post({String path = '', Object body = const Object()}) async {
    return httpClient.post(_getUri(path), headers: _headers, body: body);
  }

  Future<Response> patch({String path = '', Object body = const Object()}) async {
    return httpClient.patch(_getUri(path), headers: _headers, body: body);
  }

  Future<Response> put({String path = '', Object body = const Object()}) async {
    return httpClient.put(_getUri(path), headers: _headers, body: body);
  }

  Future<Response> delete({String path = '', Object body = const Object()}) async {
    return httpClient.delete(_getUri(path), headers: _headers, body: body);
  }
}