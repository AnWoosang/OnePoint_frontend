// import 'package:shared_preferences/shared_preferences.dart';
// 
// /// 최근 검색어 관리 서비스
// class RecentSearchService {
//   static const String _key = 'recent_searches';
//   static const int _maxCount = 10; // 최대 10개까지 저장
// 
//   /// 최근 검색어 목록 가져오기
//   Future<List<String>> getRecentSearches() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getStringList(_key) ?? [];
//   }
// 
//   /// 검색어 추가
//   Future<void> addRecentSearch(String query) async {
//     if (query.trim().isEmpty) return;
//     
//     final prefs = await SharedPreferences.getInstance();
//     List<String> searches = prefs.getStringList(_key) ?? [];
//     
//     // 이미 있는 검색어면 제거 (중복 방지)
//     searches.remove(query);
//     
//     // 맨 앞에 추가
//     searches.insert(0, query);
//     
//     // 최대 개수 제한
//     if (searches.length > _maxCount) {
//       searches = searches.take(_maxCount).toList();
//     }
//     
//     await prefs.setStringList(_key, searches);
//   }
// 
//   /// 검색어 삭제
//   Future<void> removeRecentSearch(String query) async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> searches = prefs.getStringList(_key) ?? [];
//     searches.remove(query);
//     await prefs.setStringList(_key, searches);
//   }
// 
//   /// 전체 삭제
//   Future<void> clearRecentSearches() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_key);
//   }
// } 