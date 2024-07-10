import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationApi {
  static Future<String?> translateText(
      String recognizedText, String targetLanguageCode) async {
    try {
      final langIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
      final languageCode =
          await langIdentifier.identifyLanguage(recognizedText);
      langIdentifier.close();

      final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.values.firstWhere(
          (element) => element.bcpCode == languageCode,
        ),
        targetLanguage: TranslateLanguage.values.firstWhere(
          (element) => element.bcpCode == targetLanguageCode,
        ),
      );

      final translatedText = await translator.translateText(recognizedText);
      translator.close();

      return translatedText;
    } catch (e) {
      return null;
    }
  }

  // Define a list of supported languages
  static List<Map<String, String>> supportedLanguages = [
    {"name": "Arabic", "code": "ar"},
    {"name": "English", "code": "en"},
    {"name": "French", "code": "fr"},
    {"name": "Hausa*", "code": "ha"},
    {"name": "Igbo*", "code": "ig"},
    {"name": "Yoruba*", "code": "yo"},
  ];
}


// class TranslationApi {
//   static Future<String?> translateText(String recognizedText) async {
//     try {
//       final langIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
//       final languageCode =
//           await langIdentifier.identifyLanguage(recognizedText);
//       langIdentifier.close();
//       final translator = OnDeviceTranslator(
//           sourceLanguage: TranslateLanguage.values.firstWhere(
//             (element) => element.bcpCode == languageCode,
//           ),
//           targetLanguage: TranslateLanguage.arabic);
//       final translatedText = await translator.translateText(recognizedText);
//       translator.close();
//       return translatedText;
//     } catch (e) {
//       return null;
//     }
//   }
// }
