import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/route_names.dart';
import '../../../constants/search_constants.dart';
import '../../providers/tutor_search_provider_riverpod.dart';
import '../../widgets/mobile/tutor_search_result_card_mobile.dart';
import 'package:fitkle/features/search/domain/entities/tutor_search_params.dart';

/// 모바일 검색 결과 페이지
class TutorSearchResultPageMobile extends ConsumerStatefulWidget {
  final String searchQuery;
  
  const TutorSearchResultPageMobile({
    super.key,
    required this.searchQuery,
  });

  @override
  ConsumerState<TutorSearchResultPageMobile> createState() => _TutorSearchResultPageMobileState();
}

class _TutorSearchResultPageMobileState extends ConsumerState<TutorSearchResultPageMobile> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.searchQuery;
    
    // 무한 스크롤 리스너
    _scrollController.addListener(() {
      final searchState = ref.read(searchProvider);
      if (_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent - 200 && 
          !searchState.isLoading) {
        ref.read(searchProvider.notifier).loadMoreResults();
      }
    });
    
    // 검색 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchState = ref.read(searchProvider);
      final newParams = searchState.searchParams.copyWith(
        query: widget.searchQuery,
        page: 1,
      );
      ref.read(searchProvider.notifier).searchTutors(newParams);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      final searchState = ref.read(searchProvider);
      final newParams = searchState.searchParams.copyWith(
        query: query,
        page: 1,
      );
      ref.read(searchProvider.notifier).searchTutors(newParams);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: '튜터를 검색해보세요',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onSubmitted: (_) => _performSearch(),
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _controller.clear();
              },
            ),
        ],
      ),
      body: _buildSearchResults(searchState),
    );
  }

  Widget _buildSearchResults(SearchState searchState) {
    if (searchState.isLoading && searchState.searchResults.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (searchState.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              '검색 중 오류가 발생했습니다.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            if (searchState.errorMessage != null)
              Text(
                searchState.errorMessage!,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final newParams = searchState.searchParams.copyWith(
                  query: widget.searchQuery,
                  page: 1,
                );
                ref.read(searchProvider.notifier).searchTutors(newParams);
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    final tutors = searchState.searchResults;
    if (tutors.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '검색 결과가 없습니다.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tutors.length + (searchState.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= tutors.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final tutor = tutors[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => context.go('/tutor/${tutor.id}'),
              child: TutorSearchResultCardMobile(tutor: tutor),
            ),
          ),
        );
      },
    );
  }
} 