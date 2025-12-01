// lib/core/network/user_network.dart
import 'dart:convert';
import 'package:epl_zone/core/network/responses/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'network_interface.dart';
import 'network_client.dart';

class UserNetwork implements NetworkInterface {
  final http.Client _client;

  UserNetwork({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, String>> _getHeaders({Map<String, String>? headers}) async {
    final defaultHeaders = {
      'Content-Type': 'application/json',
    };

    // Add auth token if available
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }

    return {...defaultHeaders, ...?headers};
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
        headers: await _getHeaders(headers: headers),
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkFailure('Network error: $e');
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
        headers: await _getHeaders(headers: headers),
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkFailure('Network error: $e');
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
        headers: await _getHeaders(headers: headers),
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkFailure('Network error: $e');
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
        headers: await _getHeaders(headers: headers),
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return NetworkFailure('Network error: $e');
    }
  }

  NetworkResponse<T> _handleResponse<T>(
      http.Response response,
      T Function(Map<String, dynamic>)? fromJson,
      ) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      try {
        if (fromJson != null) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          return NetworkSuccess(fromJson(data), statusCode: statusCode);
        } else {
          return NetworkSuccess(response.body as T, statusCode: statusCode);
        }
      } catch (e) {
        return NetworkFailure('JSON parsing error: $e', statusCode: statusCode);
      }
    } else {
      String message = 'Request failed with status $statusCode';
      try {
        final errorData = jsonDecode(response.body);
        message = errorData['errorMessage'] ?? errorData['message'] ?? message;
      } catch (e) {
        message = response.body.isNotEmpty ? response.body : message;
      }
      return NetworkFailure(message, statusCode: statusCode);
    }
  }
}