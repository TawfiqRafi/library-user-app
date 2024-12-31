import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/features/book/screens/book_details_screen.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class BorrowBookHistoryScreen extends StatefulWidget {
  const BorrowBookHistoryScreen({super.key});

  @override
  State<BorrowBookHistoryScreen> createState() => _BorrowBookHistoryScreenState();
}

class _BorrowBookHistoryScreenState extends State<BorrowBookHistoryScreen> {

  final ScrollController _scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    BookController bookController = Get.find<BookController>();
    bookController.getBorrowBookHistory(offset: '1');

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!bookController.isLoading && bookController.borrowBookHistory != null) {
          int nextPage = (bookController.borrowBookHistory!.length ~/ bookController.pageSize!) + 1;
          bookController.showBottomLoader();
          bookController.getBorrowBookHistory(offset: nextPage.toString());
        }
      }
    });
  }

  Future<void> _refreshBooks() async {
    BookController bookController = Get.find<BookController>();
    await bookController.getBorrowBookHistory(offset: '1');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(title: 'Borrow Book History'),
      body: GetBuilder<BookController>(builder: (bookController) {
        return RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: _refreshBooks,
          child: bookController.borrowBookHistory != null ? bookController.borrowBookHistory!.isNotEmpty ? ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
            itemCount: bookController.borrowBookHistory!.length + 1,
            itemBuilder: (context, index) {
              if (index == bookController.borrowBookHistory!.length) {
                return bookController.isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink();
              }
              return InkWell(
                onTap: () {
                  Get.to(() => BookDetailsScreen(books: bookController.borrowBookHistory![index].book));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeFifteen),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeTen),
                  decoration: BoxDecoration(
                    color: AppColor.white,
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

                  child: Row(children: [

                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      child: CustomNetworkImage(
                        image: bookController.borrowBookHistory![index].book?.image ?? '',
                        height: 90,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeFifteen),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title: ${bookController.borrowBookHistory![index].book?.title ?? ''}',
                            style: robotoBold.copyWith(fontSize: 16),
                            overflow: TextOverflow.ellipsis, maxLines: 1,
                          ),

                          Text(
                            'Author: ${bookController.borrowBookHistory![index].book?.author ?? ''}',
                            style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                            overflow: TextOverflow.ellipsis, maxLines: 1,
                          ),

                          Text(
                            'Borrow Date: ${convertDate(date: bookController.borrowBookHistory![index].borrowedAt!)}',
                            style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                          ),

                          Text(
                            'Return Date: ${bookController.borrowBookHistory![index].returnedAt != null ? convertDate(date: bookController.borrowBookHistory![index].returnedAt!) : 'Not Returned'}',
                            style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                          ),
                        ],
                      ),
                    ),

                  ]),
                ),
              );
            },
          ) : const Center(child: Text('No Books Found')) : const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }

  String convertDate({required String date}) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    return formattedDate;
  }

}
