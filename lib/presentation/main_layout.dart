import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'screens/prayer_screen.dart';
import 'screens/ai_chat_screen.dart';
import 'screens/athkar_screen.dart';
import 'screens/quran_screen.dart';
import 'screens/daily_messages_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    PrayerScreen(),
    AiChatScreen(),
    AthkarScreen(),
    QuranScreen(),
    DailyMessagesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: SakinahColors.primary,
          unselectedItemColor: SakinahColors.secondaryText,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          elevation: 8,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.mosque), label: "الصلاة"),
            BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: "سكينة AI"),
            BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: "الأذكار"),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "القرآن"),
            BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: "رسائل"),
          ],
        ),
      ),
    );
  }
}
