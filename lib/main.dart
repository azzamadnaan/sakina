import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/colors.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SakinahApp());
}

class SakinahApp extends StatelessWidget {
  const SakinahApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سكينة',
      debugShowCheckedModeBanner: false,
      
      // ضبط التوجيه للغة العربية
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [Locale('ar', 'SA')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        fontFamily: 'Cairo', // تأكد من إضافة الخط في pubspec أو استخدام نظام الجهاز
        scaffoldBackgroundColor: SakinahColors.scaffoldBg,
        primaryColor: SakinahColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: SakinahColors.primary,
          primary: SakinahColors.primary,
          secondary: SakinahColors.secondary,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: SakinahColors.primaryText,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}
