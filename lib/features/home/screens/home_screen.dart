import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    BookController bookController = Get.find<BookController>();
    if (bookController.booksList == null) {
      bookController.getBookList(offset: '1');
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!bookController.isLoading && bookController.booksList != null) {
          int nextPage = (bookController.booksList!.length ~/ bookController.pageSize!) + 1;
          bookController.showBottomLoader();
          bookController.getBookList(offset: nextPage.toString());
        }
      }
    });
  }

  Future<void> _refreshBooks() async {
    BookController bookController = Get.find<BookController>();
    await bookController.getBookList(offset: '1', willUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Theme.of(context).disabledColor.withValues(alpha: 0.5),
        elevation: 2,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Welcome to 6am Tech Library', style: robotoBold.copyWith(fontSize: 18)),
      ),
      body: GetBuilder<BookController>(builder: (bookController) {
        return RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: _refreshBooks,
          child: bookController.booksList != null ? bookController.booksList!.isNotEmpty ? ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
            itemCount: bookController.booksList!.length + 1,
            itemBuilder: (context, index) {
              if (index == bookController.booksList!.length) {
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
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                          child: CustomNetworkImage(
                            image: bookController.booksList![index].image ?? '',
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
                            color: bookController.booksList![index].available ?? false ? AppColor.primary : AppColor.errorColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            bookController.booksList![index].available ?? false ? 'Available' : 'Not Available',
                            style: robotoRegular.copyWith(color: AppColor.white, fontSize: 12)
                          ),
                          ),
                        ),

                      ],
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title: ${bookController.booksList![index].title ?? ''}',
                            style: robotoBold.copyWith(fontSize: 16),
                          ),
                          Text(
                            'Author: ${bookController.booksList![index].author ?? ''}',
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
