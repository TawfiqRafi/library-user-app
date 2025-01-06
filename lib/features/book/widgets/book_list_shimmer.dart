import 'package:flutter/material.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class BookListShimmer extends StatelessWidget {
  const BookListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeFifteen),
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 15,
                        width: 150,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
