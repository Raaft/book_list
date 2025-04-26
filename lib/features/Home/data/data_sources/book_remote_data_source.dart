import 'package:dio/dio.dart';

import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<Map<String, dynamic>> fetchBooks(
      {required String page, String? search});
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio;

  BookRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> fetchBooks(
      {required String page, String? search}) async {
    final response = await dio.get(
      '/books',
      queryParameters: {
      'page':page,
      if(search!=null)  'search': search,
      },
    );

    final List<BookModel> books = (response.data['results'] as List)
        .map((json) => BookModel.fromJson(json))
        .toList();

    return {
      'books': books,
      'next': response.data['next'], // next URL for pagination
    };
  }
}
