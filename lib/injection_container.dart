import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';


// Features
import 'features/Home/data/data_sources/book_local_data_source.dart';
import 'features/Home/data/data_sources/book_remote_data_source.dart';
import 'features/Home/data/repositories/book_repository_impl.dart';
import 'features/Home/domain/repositories/book_repository.dart';
import 'features/Home/domain/use_cases/get_books_usecase.dart';
import 'features/Home/domain/use_cases/save_books_locally_usecase.dart';
import 'features/Home/presentation/cubit/book_cubit.dart';


final getIt = GetIt.instance;

Future<void> getItInit() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://gutendex.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );
    return dio;
  });  getIt.registerLazySingleton<Connectivity>(() => Connectivity());


  /// Data Sources
  getIt.registerLazySingleton<BookRemoteDataSource>(
        () => BookRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<BookLocalDataSource>(
        () => BookLocalDataSourceImpl(sharedPreferences: getIt<SharedPreferences>()),
  );

  /// Repositories
  getIt.registerLazySingleton<BookRepository>(
        () => BookRepositoryImpl(
      remoteDataSource: getIt<BookRemoteDataSource>(),
      localDataSource: getIt<BookLocalDataSource>(),
      connectivity: getIt<Connectivity>(),
    ),
  );

  /// Use Cases
  getIt.registerLazySingleton(() => GetBooksUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveBooksLocallyUseCase(getIt()));

  /// Cubits
  getIt.registerFactory(() => BookCubit(getBooksUseCase: getIt()));
}
