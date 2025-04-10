// lib/services/event_service.dart
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:machinetest_10042025/models/meeting_model.dart';
import 'package:machinetest_10042025/services/exceptions/custom_exception.dart';

class EventService {
  static const String _baseUrl =
      'https://yescrm.bigleap.tech/api/meeting-calender-list';

  final String token = '175|FgpWC1lFOkQKWkZC6zl73d27WHmzVZvd6pCHa3Fxeb69b6bd';
  final http.Client client;

  EventService({required this.client});

  Future<MeetingModel> fetchEventsForMonth(DateTime selectedmonth) async {
    try {
      final year = selectedmonth.year;
      final month = selectedmonth.month;
      String url = '$_baseUrl?year=$year&month=$month';
      print('URL: $url');
      final response = await client.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      return _handleResponse(response, (body) {
        return meetingModelFromJson(response.body);
      });
    } on SocketException {
      throw NetworkException('No internet connection');
    } on TimeoutException {
      throw NetworkException('Request timed out');
    } on FormatException {
      throw DataParsingException('Invalid data format from server');
    } catch (e) {
      throw EventServiceException('Failed to fetch events: ${e.toString()}');
    }
  }

//
//
//
//
  T _handleResponse<T>(http.Response response, T Function(String) bodyParser) {
    switch (response.statusCode) {
      case 200:
        return bodyParser(response.body);
      case 400:
        throw BadRequestException('Invalid request: ${response.body}');
      case 401:
        throw UnauthorizedException('Authentication required');
      case 403:
        throw ForbiddenException('Access denied');
      case 404:
        throw NotFoundException('Resource not found');
      case 500:
        throw ServerException('Server error: ${response.body}');
      default:
        throw ApiException(
          'Request failed with status ${response.statusCode}',
          response.statusCode,
        );
    }
  }
}
