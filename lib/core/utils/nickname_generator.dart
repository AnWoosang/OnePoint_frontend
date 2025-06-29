import 'dart:math';

/// 랜덤 닉네임 생성 유틸리티
class NicknameGenerator {

  // todo
  // 중복된 닉네임이 있으면 랜덤으로 생성해서 중복되지 않을 때까지 생성한다.
  // 중복된 닉네임이 없으면 그대로 반환한다.

  // 중복된 닉네임이 있으면 랜덤으로 생성해서 중복되지 않을 때까지 생성한다.
  // 중복된 닉네임이 없으면 그대로 반환한다.

  // 중복된 닉네임이 있으면 랜덤으로 생성해서 중복되지 않을 때까지 생성한다.
  // 중복된 닉네임이 없으면 그대로 반환한다.

  static final Random _random = Random();
  
  // 형용사 리스트
  static const List<String> _adjectives = [
    '관대한', '친절한', '똑똑한', '재미있는', '신나는', '즐거운', '행복한', '멋진',
    '아름다운', '귀여운', '착한', '똑똑한', '영리한', '현명한', '지혜로운', '창의적인',
    '열정적인', '긍정적인', '활발한', '에너지넘치는', '유쾌한', '상냥한', '다정한',
    '성실한', '정직한', '믿음직한', '책임감있는', '인내심있는', '배려심있는'
  ];
  
  // 명사 리스트 (동물, 과일, 음식 등)
  static const List<String> _nouns = [
    '복숭아', '사과', '바나나', '오렌지', '포도', '딸기', '키위', '망고',
    '토끼', '강아지', '고양이', '햄스터', '펭귄', '코알라', '판다', '기린',
    '피자', '햄버거', '파스타', '스테이크', '샐러드', '아이스크림', '케이크',
    '커피', '차', '주스', '우유', '요거트', '치즈', '빵'
  ];
  
  /// 랜덤 닉네임 생성
  /// 
  /// [includeNumber] true면 숫자 포함, false면 숫자 없음
  /// [numberLength] 숫자 자릿수 (기본값: 4)
  static String generate({bool includeNumber = true, int numberLength = 4}) {
    final adjective = _adjectives[_random.nextInt(_adjectives.length)];
    final noun = _nouns[_random.nextInt(_nouns.length)];
    
    if (!includeNumber) {
      return '$adjective$noun';
    }
    
    // 랜덤 숫자 생성
    final number = _generateRandomNumber(numberLength);
    return '$adjective$noun$number';
  }
  
  /// 지정된 자릿수의 랜덤 숫자 생성
  static String _generateRandomNumber(int length) {
    final min = pow(10, length - 1).toInt();
    final max = pow(10, length).toInt() - 1;
    return (_random.nextInt(max - min + 1) + min).toString();
  }
  
  /// 여러 개의 랜덤 닉네임 생성
  static List<String> generateMultiple(int count, {bool includeNumber = true, int numberLength = 4}) {
    final List<String> nicknames = [];
    final Set<String> usedNicknames = {};
    
    while (nicknames.length < count) {
      final nickname = generate(includeNumber: includeNumber, numberLength: numberLength);
      if (!usedNicknames.contains(nickname)) {
        nicknames.add(nickname);
        usedNicknames.add(nickname);
      }
    }
    
    return nicknames;
  }
  
  /// 닉네임 유효성 검사
  static bool isValid(String nickname) {
    // 3글자 이상, 20글자 이하
    if (nickname.length < 3 || nickname.length > 20) return false;
    
    // 한글, 영문, 숫자만 허용
    final RegExp validPattern = RegExp(r'^[가-힣a-zA-Z0-9]+$');
    return validPattern.hasMatch(nickname);
  }
} 