import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/tutor_search_provider.dart';

/// 모바일 검색 입력 페이지 (검색창을 눌렀을 때 나오는 화면)
class TutorSearchInputPageMobile extends StatefulWidget {
  const TutorSearchInputPageMobile({super.key});

  @override
  State<TutorSearchInputPageMobile> createState() => _TutorSearchInputPageMobileState();
}

class _TutorSearchInputPageMobileState extends State<TutorSearchInputPageMobile> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 페이지가 열리면 바로 포커스
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      // context.read<TutorSearchProvider>().loadRecentSearches();
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
    context.read<TutorSearchProvider>().updateQuery(query.trim());
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
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: '어떤 서비스가 필요하세요?',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onSubmitted: _performSearch,
          ),
        ),
      ),
      body: Consumer<TutorSearchProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 검색어 입력 안내
              const Expanded(
                child: Center(
                  child: Text(
                    '검색어를 입력해주세요.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 