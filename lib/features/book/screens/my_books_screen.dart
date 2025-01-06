import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/features/book/screens/add_book_screen.dart';
import 'package:library_user_app/features/book/screens/update_book_screen.dart';
import 'package:library_user_app/features/book/widgets/book_list_shimmer.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/features/book/screens/book_details_screen.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    BookController bookController = Get.find<BookController>();
    bookController.getMyAddedBookList(offset: '1', willUpdate: false);


    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!bookController.isLoading && bookController.myAddedBookList != null) {
          int nextPage = (bookController.myAddedBookList!.length ~/ bookController.pageSize!) + 1;
          bookController.showBottomLoader();
          bookController.getMyAddedBookList(offset: nextPage.toString());
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Books', backButton: false),

      floatingActionButton: FloatingActionButton(
        heroTag: 'addBook',
        backgroundColor: AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Get.to(() => const AddBookScreen());
        },
        child: const Icon(Icons.add, color: AppColor.white),
      ),

      body: GetBuilder<BookController>(builder: (bookController) {
        return bookController.myAddedBookList != null ? bookController.myAddedBookList!.isNotEmpty ? Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
                itemCount: bookController.myAddedBookList!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => BookDetailsScreen(books: bookController.myAddedBookList![index], fromHome: true));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeFifteen),
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
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                              child: CustomNetworkImage(
                                image: bookController.myAddedBookList?[index].image ?? '',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              top: 10, right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: bookController.myAddedBookList![index].available ?? false ? AppColor.primary : AppColor.errorColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                    bookController.myAddedBookList![index].available ?? false ? 'Available' : 'Not Available',
                                    style: robotoRegular.copyWith(color: AppColor.white, fontSize: 12)
                                ),
                              ),
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Title: ${bookController.myAddedBookList![index].title ?? ''}',
                                      style: robotoBold.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      'Author: ${bookController.myAddedBookList![index].author ?? ''}',
                                      style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: Dimensions.paddingSizeTen),

                              InkWell(
                                onTap: () {
                                  Get.to(() => UpdateBookScreen(book: bookController.myAddedBookList![index]));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeFive),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(Dimensions.radiusFive),
                                  ),
                                  child: const Icon(Icons.edit, color: Colors.blue),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                      ),
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
        ) : const Center(child: Text('No Books Found')) : const BookListShimmer();
      }),
    );
  }
}
