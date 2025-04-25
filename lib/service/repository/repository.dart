import 'package:book_app/models/book_model/book_model.dart';
import 'package:book_app/models/book_model/result.dart';
import 'package:book_app/service/api/dio_helper.dart';

class Repository {
  final DioHelper dioHelper;

  Repository(this.dioHelper);

  Future<List<BookModel>> getAllBooks({int page = 1}) async {
    try {
      final response = await dioHelper.getAllBooks(page: page);

      if (response.containsKey('results')) {
        final List<dynamic> booksData = response['results'] as List<dynamic>;
        return booksData.map((bookJson) {
          return BookModel(
            count: response['count'] as int?,
            next: response['next'] as String?,
            previous: response['previous'],
            results: [Result.fromJson(bookJson as Map<String, dynamic>)],
          );
        }).toList();
      } else {
        throw Exception('Invalid response format: missing results field');
      }
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }
}
