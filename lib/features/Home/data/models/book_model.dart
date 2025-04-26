import '../../domain/entities/book_entity.dart';
import 'author_model.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    required List<AuthorModel> super.authors,
    super.summary,
    super.coverImageUrl,
    required super.downloadCount,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      authors: (json['authors'] as List)
          .map((author) => AuthorModel.fromJson(author))
          .toList(),
      summary: (json['summaries'] != null && (json['summaries'] as List).isNotEmpty)
          ? (json['summaries'][0] as String)
          : null,
      coverImageUrl: json['formats']?['image/jpeg'],
      downloadCount: json['download_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors.map((e) => (e as AuthorModel).toJson()).toList(),
      'summary': summary,
      'coverImageUrl': coverImageUrl,
      'downloadCount': downloadCount,
    };
  }
}
