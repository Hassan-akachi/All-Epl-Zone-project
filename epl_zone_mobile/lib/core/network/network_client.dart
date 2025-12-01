import 'package:epl_zone/core/network/network_interface.dart';
import 'dart:convert';
import 'package:epl_zone/core/network/responses/network_response.dart';
import 'package:http/http.dart' as http;
import 'network_client.dart';

class NetworkClient implements NetworkInterface {
  final http.Client _client;

  NetworkClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> _getDefaultHeaders([Map<String, String>? additionalHeaders]) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  @override
  Future<NetworkResponse<T>> get<T>(
      String url, {
        Map<String, String>? headers,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: _getDefaultHeaders(headers),
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkException<T>(
        message: 'Network error occurred',
        exception: e,
      );
    }
  }

  @override
  Future<NetworkResponse<T>> post<T>(
      String url, {
        Map<String, String>? headers,
        Map<String, dynamic>? body,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: _getDefaultHeaders(headers),
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkException<T>(
        message: 'Network error occurred',
        exception: e,
      );
    }
  }

  @override
  Future<NetworkResponse<T>> put<T>(
      String url, {
        Map<String, String>? headers,
        Map<String, dynamic>? body,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    try {
      final response = await _client.put(
        Uri.parse(url),
        headers: _getDefaultHeaders(headers),
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkException<T>(
        message: 'Network error occurred',
        exception: e,
      );
    }
  }

  @override
  Future<NetworkResponse<T>> delete<T>(
      String url, {
        Map<String, String>? headers,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    try {
      final response = await _client.delete(
        Uri.parse(url),
        headers: _getDefaultHeaders(headers),
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkException<T>(
        message: 'Network error occurred',
        exception: e,
      );
    }
  }

  NetworkResponse<T> _handleResponse<T>(
      http.Response response,
      T Function(Map<String, dynamic>)? fromJson,
      ) {
    try {
      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        if (response.body.isEmpty) {
          return NetworkSuccess<T>(
            {} as T,
            statusCode: statusCode,
          );
        }

        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

        if (fromJson != null) {
          final data = fromJson(jsonData);
          return NetworkSuccess<T>(
             data,
            statusCode: statusCode,
          );
        }

        return NetworkSuccess<T>(
          jsonData as T,
          statusCode: statusCode,
        );
      } else {
        String errorMessage = 'Request failed';

        try {
          final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
          errorMessage = jsonData['errorMessage'] as String? ??
              jsonData['message'] as String? ??
              'Request failed';
        } catch (_) {
          errorMessage = response.body.isNotEmpty
              ? response.body
              : 'Request failed with status code $statusCode';
        }

        return NetworkFailure<T>(
           errorMessage,
          statusCode: statusCode,
        );
      }
    } catch (e) {
      return NetworkException<T>(
        message: 'Failed to parse response',
        exception: e,
      );
    }
  }
}
