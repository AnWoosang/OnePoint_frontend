import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkle/core/widgets/layout/app_scaffold.dart';
import 'package:fitkle/core/widgets/buttons/app_button.dart';
import 'package:fitkle/core/widgets/tabs/app_tab_bar.dart';
import 'package:fitkle/core/theme/app_colors.dart';
import 'package:fitkle/core/theme/app_text_styles.dart';
import 'package:fitkle/core/providers/auth_provider_riverpod.dart';
import 'package:fitkle/core/providers/error_provider_riverpod.dart';

class ProfileManageScreen extends ConsumerStatefulWidget {
  final String? nickname;
  const ProfileManageScreen({this.nickname, super.key});

  @override
  ConsumerState<ProfileManageScreen> createState() => _ProfileManageScreenState();
}

class _ProfileManageScreenState extends ConsumerState<ProfileManageScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userNickname = ref.watch(userNicknameProvider);
    final nickname = widget.nickname ?? userNickname ?? '교양있는까치2475';
    
    return DefaultTabController(
      length: 2,
      child: AppScaffold(
        appBar: AppBar(
          title: const Text('프로필 관리'),
          backgroundColor: AppColors.grayBackground,
          foregroundColor: AppColors.black,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileSection(nickname),
              const SizedBox(height: 32),
              _buildTabSection(),
              const SizedBox(height: 32),
              _buildTabContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(String nickname) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.grayLighter,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileAvatar(),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nickname,
                  style: AppTextStyles.subtitle1,
                ),
                const SizedBox(height: 8),
                _buildRatingSection(),
              ],
            ),
          ),
          AppButton(
            text: '프로필 등록/수정',
            type: AppButtonType.secondary,
            onPressed: () => _handleProfileEdit(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFFFF6D6), Color(0xFFFFF6D6)],
            ),
          ),
          child: const Center(
            child: Icon(Icons.person, size: 64, color: AppColors.warning),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        ...List.generate(5, (i) => const Icon(
          Icons.star, 
          size: 18, 
          color: AppColors.gray
        )),
        const SizedBox(width: 8),
        Text(
          '0.0 (0)', 
          style: AppTextStyles.body2.copyWith(
            color: AppColors.gray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return AppTabBar(
      tabs: const ['전문가 정보', '서비스'],
      selectedIndex: _currentTabIndex,
      onTap: (index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
  }

  Widget _buildTabContent() {
    return IndexedStack(
      index: _currentTabIndex,
      children: [
        _buildExpertInfoContent(),
        _buildServiceContent(),
      ],
    );
  }

  void _handleProfileEdit(BuildContext context) {
    final errorSystem = ref.read(errorSystemProvider);
    errorSystem.showErrorSnackBar(context, '프로필 편집 기능은 준비 중입니다.');
  }

  Widget _buildExpertInfoContent() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 화면이 좁으면 세로 레이아웃, 넓으면 가로 레이아웃
          if (constraints.maxWidth < 800) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '전문가 정보', 
                  style: AppTextStyles.subtitle1,
                ),
                const SizedBox(height: 32),
                const Icon(Icons.description, size: 80, color: AppColors.gray),
                const SizedBox(height: 16),
                Text(
                  '자기소개를 준비중입니다.', 
                  style: AppTextStyles.body1.copyWith(
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(height: 32),
                _buildInfoCard(),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '전문가 정보', 
                        style: AppTextStyles.subtitle1,
                      ),
                      const SizedBox(height: 32),
                      const Icon(Icons.description, size: 80, color: AppColors.gray),
                      const SizedBox(height: 16),
                      Text(
                        '자기소개를 준비중입니다.', 
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                _buildInfoCard(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '활동 정보', 
            style: AppTextStyles.subtitle1,
          ),
          const SizedBox(height: 16),
          const _InfoRow('총 작업 수', '0개'),
          const _InfoRow('만족도', '0%'),
          const _InfoRow('평균 응답 시간', '아직 몰라요'),
          const SizedBox(height: 32),
          Text(
            '전문가 정보', 
            style: AppTextStyles.subtitle1,
          ),
          const SizedBox(height: 16),
          const _InfoRow('회원구분', '개인회원'),
          const _InfoRow('연락 가능 시간', '10시 ~ 18시'),
          const _InfoRow('지역', '미입력'),
        ],
      ),
    );
  }

  Widget _buildServiceContent() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '서비스', 
                style: AppTextStyles.subtitle1,
              ),
              AppButton(
                text: '광고 신청 >',
                type: AppButtonType.text,
                onPressed: () => _handleAdRequest(context),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildServiceCard(),
        ],
      ),
    );
  }

  Widget _buildServiceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.web_asset, size: 60, color: AppColors.gray),
            const SizedBox(height: 16),
            Text(
              '서비스를 등록하여 수익을 얻어보세요!', 
              style: AppTextStyles.body1,
            ),
            const SizedBox(height: 8),
            AppButton(
              text: '+ 서비스 등록하기',
              type: AppButtonType.text,
              onPressed: () => _handleServiceRegistration(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAdRequest(BuildContext context) {
    final errorSystem = ref.read(errorSystemProvider);
    errorSystem.showErrorSnackBar(context, '광고 신청 기능은 준비 중입니다.');
  }

  void _handleServiceRegistration(BuildContext context) {
    final errorSystem = ref.read(errorSystemProvider);
    errorSystem.showErrorSnackBar(context, '서비스 등록 기능은 준비 중입니다.');
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label, 
            style: AppTextStyles.body1.copyWith(
              color: AppColors.gray,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value, 
            style: AppTextStyles.body1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}