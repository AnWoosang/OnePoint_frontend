import 'package:flutter/material.dart';
import 'dart:async';

class MainBannerWidget extends StatefulWidget {
  const MainBannerWidget({super.key});

  @override
  State<MainBannerWidget> createState() => _MainBannerWidgetState();
}

class _MainBannerWidgetState extends State<MainBannerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _bannerImages = [
    'https://picsum.photos/seed/banner1/1200/300',
    'https://picsum.photos/seed/banner2/1200/300',
    'https://picsum.photos/seed/banner3/1200/300',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // TODO: 반응형으로 높이 조절 필요
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _bannerImages.length,
            itemBuilder: (context, index) {
              return Image.network(
                _bannerImages[index],
                fit: BoxFit.cover,
              );
            },
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_bannerImages.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
} 