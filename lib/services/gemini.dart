import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Gemini {
  late String googleGeminiApiKey;

  Future<void> initializeGemini() async {
    await dotenv.load();
    googleGeminiApiKey = await getApiKey();
  }

  Future<String> getApiKey() async {
    String? apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      return "null";
    }
    return apiKey;
  }

  Future<String?> geminiTextPrompt(String userPrompt) async {
    try {
      await initializeGemini(); // googleGeminiApiKey'yi başlatmak için
      final model =
          GenerativeModel(model: 'gemini-1.0-pro', apiKey: googleGeminiApiKey);
      final prompt = TextPart(userPrompt);
      final response = await model.generateContent([Content.text(prompt.text)]);
      print("Resimsiz geldi");
      print(response.text);
      return response.text;
    } catch (e) {
      print("Error generating content: $e");
      return null;
    }
  }

  Future<String?> geminImageAndTextPrompt(
      String userPrompt, String imagePath) async {
    try {
      await initializeGemini();
      final model =
          GenerativeModel(model: 'gemini-1.0-pro', apiKey: googleGeminiApiKey);
      final prompt = TextPart(userPrompt);
      final image = await File(imagePath).readAsBytes();

      final imageParts = [DataPart('image/jpeg', image)];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
      print("Gemini Image And Text Prompt");
      print(response.text);
      return response.text;
    } catch (e) {
      print("Error generating content: $e");
      return null;
    }
  }
}
