import 'dart:convert';
import 'package:cloudwalknasa/models/apod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

/// NasaApi class is responsible for making API calls to NASA's Astronomy Picture of the Day (APOD) service.
///
/// You must initialize the class with [init] method by providing a valid API key.
/// Once initialized, you can use the [getApod] method to retrieve APOD data.
class NasaApi {
  static final NasaApi _instance = NasaApi._internal();
  late final String _apiKey;
  final Uri baseUrl = Uri.parse("https://api.nasa.gov/planetary/apod");
  bool _isInitialized = false;

  factory NasaApi() => _instance;

  NasaApi._internal();

  static NasaApi get instance => _instance;

  void init(String apiKey) {
    _apiKey = apiKey;
    _isInitialized = true;
  }

  get checkInit => !_isInitialized
      ? throw Exception("NasaApi is not initialized. Call init() method first.")
      : null;

  /// Retrieves the Astronomy Picture of the Day (APOD) based on the provided parameters.
  ///
  /// [date]: A specific date for which the APOD image is to be retrieved. Format: YYYY-MM-DD. Defaults to today.
  /// [startDate]: The start of a date range, when requesting data for a range of dates. Format: YYYY-MM-DD. Cannot be used with [date].
  /// [endDate]: The end of the date range, when used with [startDate]. Format: YYYY-MM-DD. Defaults to today.
  /// [count]: If specified, this many randomly chosen images will be returned. Cannot be used with [date] or [startDate] and [endDate].
  /// [thumbs]: If true, returns the URL of the video thumbnail. If the APOD is not a video, this parameter is ignored. Defaults to false.
  Future<Apod?> getApod({
    String? date,
    String? startDate,
    String? endDate,
    int? count,
    bool? thumbs,
  }) async {
    checkInit;

    final Map<String, dynamic> params = {
      "api_key": _apiKey,
      if (date != null) "date": date,
      if (startDate != null) "start_date": startDate,
      if (endDate != null) "end_date": endDate,
      if (count != null) "count": count.toString(),
      if (thumbs != null) "thumbs": thumbs.toString(),
    };

    final Uri uri = baseUrl.replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Apod.fromJson(jsonDecode(response.body));
    }

    Logger().e("Failed to load APOD: ${response.statusCode} ${response.body}");
    return null;
  }
}