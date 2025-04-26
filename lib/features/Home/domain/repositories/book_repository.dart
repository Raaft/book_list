import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getBooks({required String page, String? search});
  Future<void> saveBooksLocally(List<BookEntity> books);
  Future<List<BookEntity>> getBooksFromCache();
}
