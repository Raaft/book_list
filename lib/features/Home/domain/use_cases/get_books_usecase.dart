import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<BookEntity>> call({required String page, String? search}) {
    return repository.getBooks(page: page, search: search);
  }
}
