import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../cubit/book_cubit.dart';
import '../cubit/book_state.dart';
import '../widgets/book_item_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/shimmer_book_item.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BookCubit>().fetchBooks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String value) {
    context.read<BookCubit>().searchBooks(value);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'Discover Books',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onSearch: _onSearchSubmitted,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocConsumer<BookCubit, BookState>(
                listenWhen: (previous, current) => current is NoMoreBooksState,
                listener: (context, state) {
                  if (state is NoMoreBooksState) {
                    _showSnackbar('No more books to load!');
                  }
                },
                builder: (context, state) {
                  if (state is FetchBooksLoading || state is RefreshBooksLoading) {
                    return  ListView.separated(
                      itemCount: 6,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (_, __) => const ShimmerBookItem(),
                    );

                  } else if (state is FetchBooksFailure || state is RefreshBooksFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 60.sp),
                          SizedBox(height: 16.h),
                          Text(
                            'Failed to load books.',
                            style: TextStyle(fontSize: 18.sp, color: Colors.red),
                          ),
                          SizedBox(height: 12.h),
                          ElevatedButton(
                            onPressed: () => context.read<BookCubit>().fetchBooks(),
                            child: Text('Retry', style: TextStyle(fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    );
                  } else {
                    final books = context.read<BookCubit>().books;
                    final hasMore = context.read<BookCubit>().hasMore;

                    if (books.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book_outlined, size: 100.sp, color: Colors.grey),
                            SizedBox(height: 16.h),
                            Text(
                              'No Books Found',
                              style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => context.read<BookCubit>().refreshBooks(),
                      child: LazyLoadScrollView(
                        onEndOfPage: () => context.read<BookCubit>().loadMoreBooks(),
                        child: ListView.separated(
                          itemCount: hasMore ? books.length + 1 : books.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            if (index < books.length) {
                              return TweenAnimationBuilder(
                                tween: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero),
                                duration: const Duration(milliseconds: 2000),
                                curve: Curves.easeOut,
                                builder: (context, offset, child) {
                                  return Transform.translate(
                                    offset: Offset(offset.dx * 70, 0),
                                    child: Opacity(
                                      opacity: 1 - offset.dx.abs(),
                                      child: BookItemWidget(book: books[index]),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Center(
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: const CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
