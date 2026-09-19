import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({Key? key}) : super(key: key);

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  // عداد تنازلي تجريبي للصلاة القادمة
  Duration remainingTime = const Duration(hours: 2, minutes: 14, seconds: 32);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() => remainingTime = remainingTime - const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: SakinahColors.scaffoldBg,
        body: RefreshIndicator(
          color: SakinahColors.primary,
          onRefresh: () async => await Future.delayed(const Duration(seconds: 1)),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                // بطاقة الصلاة القادمة
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [SakinahColors.primary, SakinahColors.secondary],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: SakinahColors.primary.withOpacity(0.35),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "الصلاة القادمة",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "صلاة العصر",
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _formatDuration(remainingTime),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // قائمة مواقيت اليوم
                _buildPrayerTile("الفجر", "04:45 ص", Icons.nightlight_round, false),
                _buildPrayerTile("الشروق", "06:05 ص", Icons.wb_sunny_outlined, false),
                _buildPrayerTile("الظهر", "12:15 م", Icons.wb_sunny, false),
                _buildPrayerTile("العصر", "03:35 م", Icons.brightness_medium, true),
                _buildPrayerTile("المغرب", "06:10 م", Icons.wb_twilight, false),
                _buildPrayerTile("العشاء", "07:40 م", Icons.bedtime, false),

                const SizedBox(height: 32),

                // تذييل الصفحة (حقوق الملكية)
                Column(
                  children: const [
                    Text("جميع الحقوق محفوظة © 2025",
                        style: TextStyle(color: SakinahColors.secondaryText, fontSize: 12)),
                    SizedBox(height: 4),
                    Text("عزام المبرمج — عزام عدنان المخلافي",
                        style: TextStyle(
                            color: SakinahColors.primaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text("منصة سكينة",
                        style: TextStyle(color: SakinahColors.primary, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerTile(String name, String time, IconData icon, bool isNext) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isNext ? SakinahColors.softBackground : SakinahColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNext ? SakinahColors.primary : Colors.black12,
          width: isNext ? 1.5 : 0.6,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: isNext ? SakinahColors.primary : SakinahColors.secondaryText),
          const SizedBox(width: 14),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
              color: SakinahColors.primaryText,
            ),
          ),
          const Spacer(),
          Text(
            time,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
              color: isNext ? SakinahColors.primary : SakinahColors.primaryText,
            ),
          ),
          if (isNext) ...[
            const SizedBox(width: 8),
            const Icon(Icons.notifications_active, color: SakinahColors.primary, size: 20),
          ]
        ],
      ),
    );
  }
}
