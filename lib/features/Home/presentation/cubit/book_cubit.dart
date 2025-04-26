import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/use_cases/get_books_usecase.dart';
import 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetBooksUseCase getBooksUseCase;

  BookCubit({required this.getBooksUseCase}) : super(BookInitial());

  List<BookEntity> books = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  String? _currentSearchTerm;

  // Getters
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  // Public Methods
  Future<void> fetchBooks() async {
    _reset();
    emit(FetchBooksLoading());
    await _loadBooks();
  }

  Future<void> refreshBooks() async {
    _reset();
    emit(RefreshBooksLoading());
    await _loadBooks();
  }

  Future<void> loadMoreBooks() async {
    if (!_hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _page++;

    final result = await _tryLoadBooks(search: _currentSearchTerm, page: _page.toString());

    if (result != null) {
      if (result.isEmpty) {
        _hasMore = false;
        emit(NoMoreBooksState());
      } else {
        books.addAll(result);
        emit(FetchBooksSuccess(books: books));
      }
    }
    _isLoadingMore = false;
  }

  Future<void> searchBooks(String searchTerm) async {
    _reset();
    _currentSearchTerm = searchTerm;
    emit(SearchBooksLoading());
    await _loadBooks();
  }

  // Internal Helpers
  Future<void> _loadBooks() async {
    final result = await _tryLoadBooks(search: _currentSearchTerm, page: _page.toString());

    if (result != null) {
      books = result;
      _hasMore = result.isNotEmpty;
      if (_currentSearchTerm != null && _currentSearchTerm!.isNotEmpty) {
        emit(SearchBooksSuccess(books: books));
      } else {
        emit(FetchBooksSuccess(books: books));
      }
    }
  }

  Future<List<BookEntity>?> _tryLoadBooks({String? search, required String page}) async {
    try {
      final result = await getBooksUseCase(search: search, page: page);
      return result;
    } catch (e) {
      emit(_currentSearchTerm != null && _currentSearchTerm!.isNotEmpty
          ? SearchBooksFailure(message: e.toString())
          : FetchBooksFailure(message: e.toString()));
      return null;
    }
  }

  void _reset() {
    _page = 1;
    books = [];
    _hasMore = true;
    _isLoadingMore = false;
    _currentSearchTerm = null;
  }
}
