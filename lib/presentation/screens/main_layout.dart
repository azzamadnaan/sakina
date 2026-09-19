import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'prayer_screen.dart';
import 'ai_chat_screen.dart';
import 'athkar_screen.dart';
import 'quran_screen.dart';
import 'daily_messages_screen.dart';

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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: SakinahColors.primary,
            unselectedItemColor: SakinahColors.secondaryText,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.mosque), label: "الصلاة"),
              BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: "سكينة AI"),
              BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: "الأذكار"),
              BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "القرآن"),
              BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: "رسائل"),
            ],
          ),
        ),
      ),
    );
  }
}
