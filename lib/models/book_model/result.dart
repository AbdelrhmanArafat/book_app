import 'author.dart';
import 'formats.dart';

class Result {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<String>? summaries;
  final List<dynamic>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;

  const Result({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    try {
      return Result(
        id: json['id'] as int?,
        title: json['title'] as String?,
        authors:
            (json['authors'] as List<dynamic>?)
                ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
                .toList(),
        summaries:
            (json['summaries'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        translators: json['translators'] as List<dynamic>?,
        subjects:
            (json['subjects'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        bookshelves:
            (json['bookshelves'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        languages:
            (json['languages'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        copyright: json['copyright'] as bool?,
        mediaType: json['media_type'] as String?,
        formats:
            json['formats'] == null
                ? null
                : Formats.fromJson(json['formats'] as Map<String, dynamic>),
        downloadCount: json['download_count'] as int?,
      );
    } catch (e) {
      throw FormatException('Failed to parse Result: $e');
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'authors': authors?.map((e) => e.toJson()).toList(),
    'summaries': summaries,
    'translators': translators,
    'subjects': subjects,
    'bookshelves': bookshelves,
    'languages': languages,
    'copyright': copyright,
    'media_type': mediaType,
    'formats': formats?.toJson(),
    'download_count': downloadCount,
  };

  Result copyWith({
    int? id,
    String? title,
    List<Author>? authors,
    List<String>? summaries,
    List<dynamic>? translators,
    List<String>? subjects,
    List<String>? bookshelves,
    List<String>? languages,
    bool? copyright,
    String? mediaType,
    Formats? formats,
    int? downloadCount,
  }) {
    return Result(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      summaries: summaries ?? this.summaries,
      translators: translators ?? this.translators,
      subjects: subjects ?? this.subjects,
      bookshelves: bookshelves ?? this.bookshelves,
      languages: languages ?? this.languages,
      copyright: copyright ?? this.copyright,
      mediaType: mediaType ?? this.mediaType,
      formats: formats ?? this.formats,
      downloadCount: downloadCount ?? this.downloadCount,
    );
  }
}
