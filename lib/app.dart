import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/Home/presentation/cubit/book_cubit.dart';
import 'features/Home/presentation/pages/book_list_screen.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => getIt<BookCubit>(), // sl = service locator
          ),
        ], child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Task',

          home: BookListScreen(),
        ));
      },
    );
  }
}
