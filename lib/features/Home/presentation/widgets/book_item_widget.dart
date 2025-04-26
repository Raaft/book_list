import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/book_entity.dart';


class BookItemWidget extends StatefulWidget {
  final BookEntity book;

  const BookItemWidget({super.key, required this.book});

  @override
  State<BookItemWidget> createState() => _BookItemWidgetState();
}

class _BookItemWidgetState extends State<BookItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.book.coverImageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: widget.book.coverImageUrl!,
                    width: 60.w,
                    height: 90.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 60.w,
                      height: 90.h,
                      color: Colors.grey[300],
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.broken_image, size: 40.sp),
                  ),
                )
              else
                Container(
                  width: 60.w,
                  height: 90.h,
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 40.sp),
                ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.title,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.book.authors.isNotEmpty
                          ? widget.book.authors.first.name
                          : 'Unknown Author',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          if (widget.book.summary != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCrossFade(
                  firstChild: Text(
                    widget.book.summary!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  secondChild: Text(
                    widget.book.summary!,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? 'See Less' : 'See More',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
