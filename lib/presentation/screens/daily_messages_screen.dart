import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/colors.dart';
import '../../core/services/gemini_service.dart';

class DailyMessagesScreen extends StatefulWidget {
  const DailyMessagesScreen({Key? key}) : super(key: key);

  @override
  State<DailyMessagesScreen> createState() => _DailyMessagesScreenState();
}

class _DailyMessagesScreenState extends State<DailyMessagesScreen> {
  final GeminiService _geminiService = GeminiService();
  bool _isLoadingAi = false;

  // الرسائل الافتراضية لكل يوم من أيام الأسبوع
  final Map<int, Map<String, String>> _weeklyMessages = {
    DateTime.friday: {
      "title": "رسالة يوم الجمعة المبارك 🌸",
      "text": "قال رسول الله ﷺ: «أَكْثِرُوا عَلَيَّ مِنَ الصَّلَاةِ فِي يَوْمِ الْجُمُعَةِ وَلَيْلَةِ الْجُمُعَةِ».\n\nاللهم صلِّ وسلِّم على نبينا محمد. لا تنسوا قراءة سورة الكهف وساعة الإجابة."
    },
    DateTime.saturday: {
      "title": "رسالة السبت — بداية مباركة 🌿",
      "text": "اللهم إنا نسألك مع بداية هذا الأسبوع توفيقاً يلازم خُطانا، ونوراً يملأ قلوبنا، وتيسيراً لكل أمر عسير."
    },
    DateTime.sunday: {
      "title": "رسالة الأحد — بركة السعي 💼",
      "text": "كل عمل صالح تعمله بنية إرضاء الله هو عبادة تؤجر عليها. اجعل نيتك صالحة في يومك واحتسب الأجر."
    },
    DateTime.monday: {
      "title": "رسالة الاثنين — سنة الصيام 🕊️",
      "text": "يوم الاثنين ترفع فيه الأعمال إلى الله، فطوبى لمن رُفع عمله وهو صائم أو ذاكرٌ شاكر."
    },
    DateTime.tuesday: {
      "title": "رسالة الثلاثاء — التوكل واليقين 🤍",
      "text": "«وتوكّل على العزيزِ الرّحيم». حين توكل أمرك لله، تأكد أن الخير كلّه سيأتيك في أوانه المناسب."
    },
    DateTime.wednesday: {
      "title": "رسالة الأربعاء — غراس الاستغفار 🌧️",
      "text": "«أستغفرُ الله العظيم وأتوبُ إليه». كلمة تفتح المغاليق وتفرّج الهم وتوسّع الأرزاق وتزيل صدأ القلوب."
    },
    DateTime.thursday: {
      "title": "رسالة الخميس — مشارف الفضل 🌙",
      "text": "غداً الجمعة.. استعدوا لها بقلوب نقية، وأكثروا من الصلاة على حبيبنا المصطفى ﷺ مع غروب شمس هذا اليوم."
    },
  };

  late String currentTitle;
  late String currentText;

  @override
  void initState() {
    super.initState();
    _loadTodayMessage();
  }

  void _loadTodayMessage() {
    int weekday = DateTime.now().weekday;
    final todayData = _weeklyMessages[weekday] ?? _weeklyMessages[DateTime.friday]!;
    setState(() {
      currentTitle = todayData["title"]!;
      currentText = todayData["text"]!;
    });
  }

  // اقتراح رسالة جديدة بواسطة الذكاء الاصطناعي
  Future<void> _fetchAiMessage() async {
    setState(() => _isLoadingAi = true);
    
    try {
      final prompt = "اقترح لي رسالة إسلامية دعوية قصيرة وجميلة مع آية أو حديث تناسب هذا اليوم للنشر عبر واتساب وتيليجرام بأسلوب مؤثر وهادئ.";
      final response = await _geminiService.sendMessage(prompt);
      
      setState(() {
        currentTitle = "همسة إيمانية من سكينة AI ✨";
        currentText = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تعذر توليد رسالة، تأكد من الإنترنت أو مفتاح API")),
      );
    } finally {
      setState(() => _isLoadingAi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: SakinahColors.scaffoldBg,
        appBar: AppBar(
          title: const Text("رسائل إسلامية", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          backgroundColor: Colors.white,
          foregroundColor: SakinahColors.primaryText,
          elevation: 0.5,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // البطاقة الإيمانية
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: SakinahColors.primary.withOpacity(0.15)),
                  boxShadow: [
                    BoxShadow(
                      color: SakinahColors.primary.withOpacity(0.06),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            currentTitle,
                            style: const TextStyle(
                              color: SakinahColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.auto_awesome, color: SakinahColors.primary, size: 20),
                      ],
                    ),
                    const Divider(height: 25),
                    Text(
                      currentText,
                      style: const TextStyle(
                        fontSize: 15.5,
                        height: 1.8,
                        color: SakinahColors.primaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // أزرار النسخ والمشاركة
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SakinahColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 11),
                            ),
                            icon: const Icon(Icons.copy_rounded, size: 18),
                            label: const Text("نسخ الرسالة"),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: currentText));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("تم نسخ النص بنجاح 📋")),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: SakinahColors.softBackground,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.share_rounded, color: SakinahColors.primary),
                          onPressed: () => Share.share(currentText),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // زر الذكاء الاصطناعي
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: SakinahColors.primary, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: _isLoadingAi
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: SakinahColors.primary))
                      : const Icon(Icons.psychology_outlined, color: SakinahColors.primary),
                  label: Text(
                    _isLoadingAi ? "سكينة تفكر..." : "اقترح لي رسالة عبر سكينة AI 🤖",
                    style: const TextStyle(color: SakinahColors.primary, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _isLoadingAi ? null : _fetchAiMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
