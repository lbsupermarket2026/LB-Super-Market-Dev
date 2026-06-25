import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/utils/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 48,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_VisitStore(), const SizedBox(height: 32), _ContactInfo()],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _VisitStore()),
                const SizedBox(width: 60),
                Expanded(flex: 2, child: _ContactInfo()),
              ],
            ),
    );
  }
}

class _VisitStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Store Icon
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.store, color: AppColors.primary, size: 32),
        ),
        const SizedBox(height: 16),

        Text(AppStrings.visitTitle,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),

        Text(AppStrings.storeName,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 4),

        Text(AppStrings.storeAddress,
            style: const TextStyle(
                fontSize: 13, color: AppColors.textGrey, height: 1.6)),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: UrlLauncherUtil.openMaps,
          child: const Text(
            AppStrings.getDirections,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.contactTitle,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 20),

        Row(
          children: [
            _ContactTile(
              icon: Icons.phone,
              title: AppStrings.callUs,
              value: AppStrings.phone,
              onTap: UrlLauncherUtil.callPhone,
            ),
            const SizedBox(width: 24),
            _ContactTile(
              icon: Icons.chat,
              title: AppStrings.whatsApp,
              value: AppStrings.phone,
              onTap: UrlLauncherUtil.openWhatsApp,
            ),
            const SizedBox(width: 24),
            _ContactTile(
              icon: Icons.email_outlined,
              title: AppStrings.emailUs,
              value: AppStrings.email,
              onTap: UrlLauncherUtil.sendEmail,
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.divider),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 10),

          // Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textGrey)),
            ],
          ),
        ],
      ),
    );
  }
}
