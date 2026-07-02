import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/utils/url_launcher.dart';
import '../../services/whatsapp_service.dart';
import '../../widgets/common/navbar.dart';
import '../../widgets/common/footer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  void _sendViaWhatsApp() {
    final msg =
        'Name: ${_nameCtrl.text}\nPhone: ${_phoneCtrl.text}\nMessage: ${_msgCtrl.text}';
    WhatsAppService.openChat(message: msg);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              color: AppColors.dark,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Contact Us',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white)),
                  const SizedBox(height: 6),
                  Text('We are here to help you',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ),

            // Body
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 80, vertical: 48),
              child: isMobile
                  ? Column(
                      children: [
                        _ContactInfoPanel(),
                        const SizedBox(height: 42),
                        _ContactForm(
                          nameCtrl: _nameCtrl,
                          phoneCtrl: _phoneCtrl,
                          msgCtrl: _msgCtrl,
                          onSend: _sendViaWhatsApp,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _ContactInfoPanel()),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 2,
                          child: _ContactForm(
                            nameCtrl: _nameCtrl,
                            phoneCtrl: _phoneCtrl,
                            msgCtrl: _msgCtrl,
                            onSend: _sendViaWhatsApp,
                          ),
                        ),
                      ],
                    ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _ContactInfoPanel extends StatelessWidget {
  const _ContactInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get In Touch',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        Container(
          margin: const EdgeInsets.only(top: 6, bottom: 20),
          width: 40,
          height: 3,
          color: AppColors.primary,
        ),

        _InfoTile(
          icon: Icons.location_on_outlined,
          title: 'Store Address',
          value: '${AppStrings.storeName}\n${AppStrings.storeAddress}',
          onTap: UrlLauncherUtil.openMaps,
        ),

        const SizedBox(height: 16),

        _InfoTile(
          icon: Icons.phone_outlined,
          title: AppStrings.callUs,
          value: AppStrings.phone,
          onTap: UrlLauncherUtil.callPhone,
        ),

        const SizedBox(height: 16),

        _InfoTile(
          imagePath: 'assets/icons/whatsapp.png',
          title: AppStrings.whatsApp,
          value: AppStrings.phone,
          onTap: UrlLauncherUtil.openWhatsApp,
        ),

        const SizedBox(height: 16),

        _InfoTile(
          icon: Icons.email_outlined,
          title: AppStrings.emailUs,
          value: AppStrings.email,
          onTap: UrlLauncherUtil.sendEmail,
        ),

        const SizedBox(height: 28),

        Text(
          'Working Hours',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.textDark),
        ),

        const SizedBox(height: 10),

        const _HoursRow(
          'Monday – Saturday',
          '8:00 AM – 9:00 PM',
        ),

        const _HoursRow(
          'Sunday',
          '9:00 AM – 6:00 PM',
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _InfoTile({
    super.key,
    this.icon,
    this.imagePath,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: imagePath != null
                    ? Image.asset(
                        imagePath!,
                        width: 30,
                        height: 30,
                        fit: BoxFit.contain,
                      )
                    : Icon(
                        icon,
                        color: AppColors.primary,
                        size: 20,
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _HoursRow extends StatelessWidget {
  final String day;
  final String hours;

  const _HoursRow(this.day, this.hours);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textGrey)),
          Text(hours,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController msgCtrl;
  final VoidCallback onSend;

  const _ContactForm({
    required this.nameCtrl,
    required this.phoneCtrl,
    required this.msgCtrl,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send Us a Message',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          const Text('We\'ll reply via WhatsApp',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
          const SizedBox(height: 24),

          _Field(label: 'Your Name', controller: nameCtrl, hint: 'e.g. Ramesh Kumar'),
          const SizedBox(height: 16),
          _Field(label: 'Phone Number', controller: phoneCtrl, hint: '+91 98765 43210',
              keyboardType: TextInputType.phone),
          const SizedBox(height: 16),
          _Field(
            label: 'Message',
            controller: msgCtrl,
            hint: 'Type your message here...',
            maxLines: 4,
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onSend,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
             icon: Image.asset(
              'assets/icons/whatsapp.png',
              width: 40,
              height: 40,
            ),
              label: const Text(
                'Send via WhatsApp',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;

  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 13),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}
