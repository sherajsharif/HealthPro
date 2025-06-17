import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/auth/auth_controller.dart';
import 'package:ri_medicare/routes/app_pages.dart';
import 'package:ri_medicare/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? geminiApiKey;

  try {
    await dotenv.load(fileName: ".env");
    if (dotenv.env.isNotEmpty) {
      geminiApiKey = dotenv.env['GEMINI_API_KEY'];
      print('Environment loaded successfully.');
      print('Retrieved GEMINI_API_KEY: $geminiApiKey');
    } else {
      print('Dotenv loaded, but environment is empty.');
    }
  } catch (e) {
    print('Error loading .env file: $e');
  }

  // Initialize AuthController regardless of .env loading success, as it might not directly depend on dotenv
  Get.put(AuthController());

  // Only run the app if the API key is available, or handle the case where it's not.
  // For now, we'll run the app, and the chatbot_widget will handle the empty key.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ri Medicare',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
    );
  }
}

