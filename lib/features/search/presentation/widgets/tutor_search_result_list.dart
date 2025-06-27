import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'tutor_search_result_card.dart';

class TutorSearchResultList extends StatelessWidget {
  final List<dynamic> tutorList;
  final bool isLoading;
  final double categoryWidth;

  const TutorSearchResultList({
    super.key,
    required this.tutorList,
    required this.isLoading,
    required this.categoryWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= tutorList.length) {
            return isLoading
                ? Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox.shrink();
          }

          final item = tutorList[index];
          return Padding(
            padding: EdgeInsets.only(left: categoryWidth + 32),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => context.go('/tutor/${item.id}'),
                  child: TutorSearchResultCard(tutor: item),
                ),
              ),
            ),
          );
        },
        childCount: tutorList.length + (isLoading ? 1 : 0),
      ),
    );
  }
} 