import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/book_model.dart';

abstract class BookLocalDataSource {
  Future<void> cacheBooks(List<BookModel> books);
  Future<List<BookModel>> getCachedBooks();
}



class BookLocalDataSourceImpl implements BookLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const cachedBooksKey = 'CACHED_BOOKS';

  BookLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    final List<String> booksJson = books.map((book) => json.encode(book.toJson())).toList();
    await sharedPreferences.setStringList(cachedBooksKey, booksJson);
  }

  @override
  Future<List<BookModel>> getCachedBooks() async {
    final List<String>? booksJson = sharedPreferences.getStringList(cachedBooksKey);

    if (booksJson != null) {
      return booksJson
          .map((bookString) => BookModel.fromJson(json.decode(bookString)))
          .toList();
    } else {
      throw Exception('No cached books found');
    }
  }
}
