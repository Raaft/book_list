import '../../domain/entities/book_entity.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class FetchBooksLoading extends BookState {}

class FetchBooksSuccess extends BookState {
  final List<BookEntity> books;

  FetchBooksSuccess({required this.books});
}

class FetchBooksFailure extends BookState {
  final String message;

  FetchBooksFailure({required this.message});
}

class LoadMoreBooksLoading extends BookState {}

class LoadMoreBooksFailure extends BookState {
  final String message;

  LoadMoreBooksFailure({required this.message});
}

class RefreshBooksLoading extends BookState {}

class RefreshBooksSuccess extends BookState {
  final List<BookEntity> books;

  RefreshBooksSuccess({required this.books});
}

class RefreshBooksFailure extends BookState {
  final String message;

  RefreshBooksFailure({required this.message});
}

class SearchBooksLoading extends BookState {}

class SearchBooksSuccess extends BookState {
  final List<BookEntity> books;

  SearchBooksSuccess({required this.books});
}

class SearchBooksFailure extends BookState {
  final String message;

  SearchBooksFailure({required this.message});
}

// ✨ لازم تضيفه:
class NoMoreBooksState extends BookState {}
