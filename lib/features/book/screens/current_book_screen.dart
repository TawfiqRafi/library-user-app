import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class CurrentBookScreen extends StatefulWidget {
  const CurrentBookScreen({super.key});

  @override
  State<CurrentBookScreen> createState() => _CurrentBookScreenState();
}

class _CurrentBookScreenState extends State<CurrentBookScreen> {

  final ScrollController _scrollController = ScrollController();
  final refreshIndicatorKey1 = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    BookController bookController = Get.find<BookController>();
    if (bookController.currentBorrowedBooks == null) {
      bookController.getCurrentBorrowedBooks(offset: '1');
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!bookController.isLoading && bookController.currentBorrowedBooks != null) {
          int nextPage = (bookController.currentBorrowedBooks!.length ~/ bookController.pageSize!) + 1;
          bookController.showBottomLoader();
          bookController.getCurrentBorrowedBooks(offset: nextPage.toString());
        }
      }
    });
  }

  Future<void> _refreshBooks() async {
    BookController bookController = Get.find<BookController>();
    print('refreshing');
    await bookController.getCurrentBorrowedBooks(offset: '1');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(title: 'Current Borrow Book', backButton: false),
      body: GetBuilder<BookController>(builder: (bookController) {
        return RefreshIndicator(
          key: refreshIndicatorKey1,
          onRefresh: _refreshBooks,
          child: bookController.currentBorrowedBooks != null ? bookController.currentBorrowedBooks!.isNotEmpty ? ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
            itemCount: bookController.currentBorrowedBooks!.length + 1,
            itemBuilder: (context, index) {
              if (index == bookController.currentBorrowedBooks!.length) {
                return bookController.isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink();
              }
              return Container(
                margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeFifteen),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: CustomNetworkImage(
                      image: bookController.currentBorrowedBooks![index].book?.image ?? '',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title: ${bookController.currentBorrowedBooks![index].book?.title ?? ''}',
                          style: robotoBold.copyWith(fontSize: 16),
                        ),
                        Text(
                          'Author: ${bookController.currentBorrowedBooks![index].book?.author ?? ''}',
                          style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                        ),
                      ],
                    ),
                  ),
                ],
                ),
              );
            },
          ) : const Center(child: Text('No Books Found')) : const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
