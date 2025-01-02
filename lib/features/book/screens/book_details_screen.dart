import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/features/book/models/book_list_model.dart';
import 'package:library_user_app/features/book/models/current_borrow_book_model.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class BookDetailsScreen extends StatefulWidget {
  final Books? books;
  final BorrowBook? borrowBook;
  final bool fromHome;
  const BookDetailsScreen({super.key, this.books, this.borrowBook, this.fromHome = false});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {

  final TextEditingController _lastPageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Book Details'),
      body: GetBuilder<BookController>(builder: (bookController) {
        return Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
                child: widget.fromHome ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                    child: CustomNetworkImage(
                      image: widget.books?.image ?? '',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeTwenty),
                  Text(
                    widget.books?.title ?? 'N/A',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeTen),
                  Text(
                    'Author: ${widget.books?.author ?? 'N/A'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeTen),

                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: widget.books?.available ?? false ? AppColor.primary : AppColor.errorColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.books?.available ?? false ? 'Available' : 'Not Available',
                      style: robotoRegular.copyWith(color: AppColor.white, fontSize: 12),
                    ),
                  ),

                ]) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                      child: CustomNetworkImage(
                        image: widget.borrowBook?.book?.image ?? '',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeTwenty),
                    Text(
                      widget.borrowBook?.book?.title ?? 'N/A',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeTen),
                    Text(
                      'Author: ${ widget.borrowBook?.book?.author ?? 'N/A'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeTen),

                    widget.borrowBook?.lastPage != 0 ? Text(
                      'Last Read Page: ${widget.borrowBook?.lastPage ?? ''}',
                      style: const TextStyle(fontSize: 18),
                    ) : const SizedBox.shrink(),
                    SizedBox(height: widget.borrowBook?.lastPage != 0 ? Dimensions.paddingSizeTen : 0),

                    Text(
                      'Borrowed At: ${_formatDate( widget.borrowBook?.borrowedAt)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeTen),
                    Text(
                      'Returned At: ${_formatDate(widget.borrowBook?.returnedAt)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

          (widget.borrowBook?.returnedAt != null) || widget.fromHome ? const SizedBox.shrink() : Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
            decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Update Last Page',
                    onTap: () {
                      Get.dialog(
                        GetBuilder<BookController>(builder: (bookController) {
                          return Dialog(
                            backgroundColor: AppColor.white,
                            child: Container(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeTwenty),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Update Last Page',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeTwenty),
                                  const Text(
                                    'Enter the last page number you read',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeTwenty),
                                  TextField(
                                    controller: _lastPageController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: 'Last Page Number',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeTwenty),
                                  CustomButton(
                                    text: 'Update',
                                    isLoading: bookController.isLastPageLoading,
                                    onTap: () {
                                      if(_lastPageController.text.isEmpty){
                                        showCustomSnackBar('Enter last page number');
                                      }else{
                                        bookController.updateLastPage(barcode: widget.borrowBook!.book!.barcode!, lastPage: int.parse(_lastPageController.text));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeFifteen),

                Expanded(
                  child: CustomButton(
                    text: 'Return Book',
                    isLoading: bookController.isLoading,
                    onTap: () {
                      bookController.returnBook(barcode: widget.books!.barcode!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ]);
      }),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'Not Return Yet';
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }
}
