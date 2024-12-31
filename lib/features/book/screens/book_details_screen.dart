import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/features/book/models/book_list_model.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';

class BookDetailsScreen extends StatelessWidget {
  final Books? books;
  const BookDetailsScreen({super.key, this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Book Details'),
      body: GetBuilder<BookController>(
        builder: (bookController) {
          return Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                        child: CustomNetworkImage(
                          image: books?.image ?? '',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeTwenty),
                      Text(
                        books?.title ?? 'N/A',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeTen),
                      Text(
                        'Author: ${books?.author ?? 'N/A'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeTen),
                      Text(
                        'Created At: ${_formatDate(books?.createdAt)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeTen),
                      Text(
                        'Updated At: ${_formatDate(books?.updatedAt)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
              decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
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
                          Dialog(
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
                                    onTap: () {
                                      // Update logic here
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                        bookController.returnBook(barcode: books!.barcode!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]);
        }
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }
}
