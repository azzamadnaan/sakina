import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'AQ.Ab8RN6K1fhrZPyILkcUb8MDE3RSuGX9ZIl0HMX-IkW4xy_TJtg';

  static const String _systemInstruction = """
أنت 'سكينة AI'، رفيق ومساعد ديني إسلامي رحيم، هادئ، ومتخصص.
القواعد الصارمة التي تلتزم بها دائماً:
1. تجيب باللغة العربية الفصحى البسيطة والمحببة لقلب المستخدم بأسلوب روحاني مطمئن.
2. تستشهد بالقرآن الكريم وصحيح السنة النبوية مع كل توجيه.
3. التخصص: (تفسير القرآن، السنة النبوية، الأذكار، السيرة النبوية، الأخلاق والتزكية والدعم الروحي).
4. في حال السؤال عن المحرمات أو الفواحش (كالخمر، الزنا، القمار، الربا، المخدرات): ترفض الإجابة بلطف وتدعو بالهداية والاعتصام بالله.
5. في المسائل الفقهية الدقيقة أو المعقدة: تذكر الخلاصة وتوجه المستخدم دائماً لاستفتاء أهل العلم الموثوقين ودور الإفتاء الرسمية.
6. لا تخض في أي جدل سياسي أو فكري عقيم.
""";

  late final GenerativeModel _model;
  ChatSession? _chatSession;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(_systemInstruction),
    );
    _chatSession = _model.startChat();
  }

  Future<String> sendMessage(String userPrompt) async {
    try {
      final response = await _chatSession?.sendMessage(Content.text(userPrompt));
      return response?.text ?? "عذراً يا طيب، لم أستطع إجابتك حالياً. أعد المحاولة لاحقاً 🌸";
    } catch (e) {
      return "تعذر الاتصال بخادم المعرفة، تأكد من اتصال الإنترنت ثم حاول ثانية.";
    }
  }
}
