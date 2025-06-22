import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/theme/app_colors.dart';
import 'package:one_point/features/search/presentation/widgets/mobile/search_app_bar.dart';
import 'package:one_point/features/search/presentation/widgets/mobile/recent_search_section.dart';
import 'package:one_point/features/search/presentation/widgets/mobile/recommended_keywords.dart';
import 'package:one_point/features/search/presentation/widgets/mobile/trending_keywords.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  List<String> _recentSearches = ['아이폰', '스마트워치', '노트북', '무선 이어폰'];

  final List<String> _recommendedKeywords = [
    '전자담배', '액상', '세트상품', '추천', '니코틴', '무니코틴', '신상품', '인기상품'
  ];

  final List<Map<String, dynamic>> _trendingSearches = [
    {'keyword': '코로나', 'status': 'up'},
    {'keyword': '비트코인', 'status': 'new'},
    {'keyword': 'AI', 'status': 'down'},
    {'keyword': '드라마', 'status': 'up'},
    {'keyword': '영화', 'status': 'up'},
    {'keyword': '연예인', 'status': 'down'},
    {'keyword': '주식', 'status': 'new'},
    {'keyword': '부동산', 'status': 'down'},
    {'keyword': '우주', 'status': 'up'},
    {'keyword': '기후', 'status': 'up'},
  ];

  final String _currentTime = '04.09.20:00 기준';

  void _clearRecentSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  void _removeRecentSearch(String search) {
    setState(() {
      _recentSearches.remove(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // 키보드 내리기
      child: Scaffold(
        backgroundColor: AppColors.grayLighter,
        //검색바
        appBar: SearchAppBar(controller: _searchController),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            children: [
              //최근 검색어
              RecentSearchSection(
                recentSearches: _recentSearches,
                onClearAll: _clearRecentSearches,
                onRemove: _removeRecentSearch,
              ),
              SizedBox(height: 24.h),
              //추천 키워드
              RecommendedKeywords(keywords: _recommendedKeywords),
              SizedBox(height: 24.h),
              //급상승 검색어
              TrendingKeywords(
                trending: _trendingSearches,
                currentTime: _currentTime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
