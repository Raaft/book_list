import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class SaveBooksLocallyUseCase {
  final BookRepository repository;

  SaveBooksLocallyUseCase(this.repository);

  Future<void> call(List<BookEntity> books) {
    return repository.saveBooksLocally(books);
  }
}
