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
        vertical: 40,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _VisitStore(),
                const SizedBox(height: 32),
                _ContactInfo(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _VisitStore()),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: _ContactInfo()),
              ],
            ),
    );
  }
}

class _VisitStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Big dark square icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.store, color: AppColors.primary, size: 42),
        ),
        const SizedBox(width: 16),

        // Text beside icon
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.visitTitle,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              Text(AppStrings.storeName,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark)),
              const SizedBox(height: 4),
              Text(AppStrings.storeAddress,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                      height: 1.6)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: UrlLauncherUtil.openMaps,
                child: const Text(AppStrings.getDirections,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600)),
              ),
            ],
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
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark)),
        const SizedBox(height: 20),
        LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 500;
          if (isMobile) {
            return Column(
              children: [
                _ContactTile(
                  icon: Icons.phone,
                  title: AppStrings.callUs,
                  value: AppStrings.phone,
                  onTap: UrlLauncherUtil.callPhone,
                ),
                const SizedBox(height: 10),
                _ContactTile(
                  icon: Icons.chat,
                  title: AppStrings.whatsApp,
                  value: AppStrings.phone,
                  onTap: UrlLauncherUtil.openWhatsApp,
                ),
                const SizedBox(height: 10),
                _ContactTile(
                  icon: Icons.email_outlined,
                  title: AppStrings.emailUs,
                  value: AppStrings.email,
                  onTap: UrlLauncherUtil.sendEmail,
                ),
              ],
            );
          }
          return Row(
            children: [
              Expanded(child: _ContactTile(
                icon: Icons.phone,
                title: AppStrings.callUs,
                value: AppStrings.phone,
                onTap: UrlLauncherUtil.callPhone,
              )),
              const SizedBox(width: 12),
              Expanded(child: _ContactTile(
                icon: Icons.chat,
                title: AppStrings.whatsApp,
                value: AppStrings.phone,
                onTap: UrlLauncherUtil.openWhatsApp,
              )),
              const SizedBox(width: 12),
              Expanded(child: _ContactTile(
                icon: Icons.email_outlined,
                title: AppStrings.emailUs,
                value: AppStrings.email,
                onTap: UrlLauncherUtil.sendEmail,
              )),
            ],
          );
        },
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.divider),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
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
                          fontSize: 11, color: AppColors.textGrey),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}