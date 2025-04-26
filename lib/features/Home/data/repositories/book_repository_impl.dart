import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../data_sources/book_local_data_source.dart';
import '../data_sources/book_remote_data_source.dart';

import '../models/author_model.dart';
import '../models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;
  final Connectivity connectivity;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  @override
  Future<List<BookEntity>> getBooks({required String page, String? search}) async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult.first != ConnectivityResult.none) {

      final remoteResponse = await remoteDataSource.fetchBooks(
        page: page,
        search: search,
      );

      final books = remoteResponse['books'] as List<BookModel>;

      await localDataSource.cacheBooks(books);

      return books;
    } else {
      final cachedBooks = await localDataSource.getCachedBooks();
      return cachedBooks;
    }
  }

  @override
  Future<void> saveBooksLocally(List<BookEntity> books) async {
    final bookModels = books.map((book) {
      return BookModel(
        id: book.id,
        title: book.title,
        authors: book.authors.map((author) => AuthorModel(
          name: author.name,
          birthYear: author.birthYear,
          deathYear: author.deathYear,
        )).toList(),
        summary: book.summary,
        coverImageUrl: book.coverImageUrl,
        downloadCount: book.downloadCount,
      );
    }).toList();

    await localDataSource.cacheBooks(bookModels);
  }

  @override
  Future<List<BookEntity>> getBooksFromCache() async {
    final cached = await localDataSource.getCachedBooks();
    return cached;
  }
}
