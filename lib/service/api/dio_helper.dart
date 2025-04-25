import 'dart:developer';
import 'package:book_app/service/api/end_points.dart';
import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio;

  DioHelper(this.dio) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio.options = options;
  }

  Future<Map<String, dynamic>> getAllBooks({int page = 1}) async {
    try {
      final Response response = await dio.get(
        endpoint,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('Dio Error: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
