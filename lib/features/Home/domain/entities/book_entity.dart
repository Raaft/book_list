class AuthorEntity {
  final String name;
  final int? birthYear;
  final int? deathYear;

  const AuthorEntity({
    required this.name,
    this.birthYear,
    this.deathYear,
  });
}

class BookEntity {
  final int id;
  final String title;
  final List<AuthorEntity> authors;
  final String? summary;
  final String? coverImageUrl;
  final int downloadCount;

  const BookEntity({
    required this.id,
    required this.title,
    required this.authors,
    this.summary,
    this.coverImageUrl,
    required this.downloadCount,
  });
}
