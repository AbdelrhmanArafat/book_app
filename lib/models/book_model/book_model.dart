import 'result.dart';

class BookModel {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<Result>? results;

  const BookModel({this.count, this.next, this.previous, this.results});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    try {
      return BookModel(
        count: json['count'] as int?,
        next: json['next'] as String?,
        previous: json['previous'],
        results:
            (json['results'] as List<dynamic>?)
                ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
                .toList(),
      );
    } catch (e) {
      throw FormatException('Failed to parse BookModel: $e');
    }
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': results?.map((e) => e.toJson()).toList(),
  };

  BookModel copyWith({
    int? count,
    String? next,
    dynamic previous,
    List<Result>? results,
  }) {
    return BookModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
