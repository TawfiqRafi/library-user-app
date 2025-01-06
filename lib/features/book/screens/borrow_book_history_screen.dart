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
import 'package:shimmer/shimmer.dart';

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
    bookController.getBorrowBookHistory(offset: '1', willUpdate: false);

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(title: 'Borrow Book History'),
      body: GetBuilder<BookController>(builder: (bookController) {
        return bookController.borrowBookHistory != null ? bookController.borrowBookHistory!.isNotEmpty ? Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
                itemCount: bookController.borrowBookHistory!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => BookDetailsScreen(borrowBook: bookController.borrowBookHistory![index]));
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
              ),
            ),

            bookController.isLoading ? const Center(child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSizeFifteen),
              child: CircularProgressIndicator(),
            )) : const SizedBox.shrink(),

          ],
        ) : const Center(child: Text('No Books Found')) : _buildShimmerEffect();
      }),
    );
  }

  String convertDate({required String date}) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    return formattedDate;
  }

}

Widget _buildShimmerEffect() {
  return ListView.builder(
    padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: const Row(
          children: [
            ShimmerWidget.rectangular(height: 90, width: 100),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.rectangular(height: 16, width: double.infinity),
                  SizedBox(height: 8),
                  ShimmerWidget.rectangular(height: 14, width: 150),
                  SizedBox(height: 8),
                  ShimmerWidget.rectangular(height: 14, width: 120),
                  SizedBox(height: 8),
                  ShimmerWidget.rectangular(height: 14, width: 150),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const ShimmerWidget.rectangular({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  const ShimmerWidget.circular({
    super.key,
    required this.height,
    required this.width,
  }) : borderRadius = const BorderRadius.all(Radius.circular(50));

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
