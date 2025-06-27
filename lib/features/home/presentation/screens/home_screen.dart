import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_point/core/widgets/layout/page_scaffold.dart';
import 'package:one_point/core/utils/responsive.dart';
import 'package:one_point/features/home/presentation/widgets/main_banner_widget.dart';
import 'package:one_point/features/home/presentation/widgets/popular_service_section.dart';
import 'package:one_point/features/home/presentation/widgets/community_section.dart';
import 'package:one_point/features/home/presentation/widgets/portfolio_section.dart';
import 'package:one_point/features/home/presentation/widgets/home_hero_section.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.getResponsiveHorizontalPadding(context);

    return PageScaffold(
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
              child: const HomeHeroSection(),
            ),
            const MainBannerWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: const PopularServiceSection(),
                        ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: const CommunitySection(),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: const PortfolioSection(),
            ),
            // TODO: 여기에 다른 섹션들을 추가할 예정입니다.
          ],
        ),
      ),
    );
  }
}
