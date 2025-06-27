import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/route_names.dart';
import '../../../constants/search_constants.dart';
import '../../providers/tutor_search_provider.dart';
import '../../widgets/mobile/tutor_search_result_card_mobile.dart';

/// 모바일 검색 결과 페이지
class TutorSearchResultPageMobile extends StatefulWidget {
  final String searchQuery;
  
  const TutorSearchResultPageMobile({
    super.key,
    required this.searchQuery,
  });

  @override
  State<TutorSearchResultPageMobile> createState() => _TutorSearchResultPageMobileState();
}

class _TutorSearchResultPageMobileState extends State<TutorSearchResultPageMobile> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.searchQuery;
    
    // 무한 스크롤 리스너
    _scrollController.addListener(() {
      final provider = context.read<TutorSearchProvider>();
      if (_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent - 200 && 
          !provider.isLoadingMore) {
        provider.loadMoreTutors();
      }
    });
    
    // 검색 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TutorSearchProvider>().updateQuery(widget.searchQuery);
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
      context.read<TutorSearchProvider>().updateQuery(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.searchQuery,
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onSubmitted: (_) => _performSearch(),
          ),
        ),
      ),
      body: Column(
        children: [
          // 필터 섹션
          _buildFilterSection(),
          
          // 검색 결과
          Expanded(
            child: Consumer<TutorSearchProvider>(
              builder: (context, provider, child) {
                return _buildSearchResults(provider);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildFilterDropdown('서비스', kTutorCategories.skip(1).toList()),
          const SizedBox(width: 12),
          _buildFilterDropdown('지역', kRegions.skip(1).toList()),
          const Spacer(),
          _buildSortDropdown(),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '리뷰 많은순',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildSearchResults(TutorSearchProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.status == SearchStatus.error) {
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performSearch,
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    final tutors = provider.tutors;
    if (tutors.isEmpty) {
      return const Center(
        child: Text(
          '검색 결과가 없습니다.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tutors.length + (provider.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == tutors.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final tutor = tutors[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
              context.go(RoutePaths.tutorDetail(tutor.id));
            },
            child: TutorSearchResultCardMobile(tutor: tutor),
          ),
        );
      },
    );
  }
} 