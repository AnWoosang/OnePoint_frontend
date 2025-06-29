import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/tutor_search_provider_riverpod.dart';
import 'package:fitkle/features/search/domain/entities/tutor_search_params.dart';

/// 모바일 검색 입력 페이지 (검색창을 눌렀을 때 나오는 화면)
class TutorSearchInputPageMobile extends ConsumerStatefulWidget {
  const TutorSearchInputPageMobile({super.key});

  @override
  ConsumerState<TutorSearchInputPageMobile> createState() => _TutorSearchInputPageMobileState();
}

class _TutorSearchInputPageMobileState extends ConsumerState<TutorSearchInputPageMobile> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 페이지가 열리면 바로 포커스
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    
    // 검색 실행하고 뒤로가기
    final searchState = ref.read(searchProvider);
    final newParams = searchState.searchParams.copyWith(
      query: query.trim(),
      page: 1,
    );
    ref.read(searchProvider.notifier).searchTutors(newParams);
    context.pop();
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
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '튜터를 검색해보세요',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onSubmitted: _performSearch,
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _controller.clear();
                _focusNode.requestFocus();
              },
            ),
        ],
      ),
      body: const Center(
        child: Text(
          '검색어를 입력하고 엔터를 눌러주세요',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
} 