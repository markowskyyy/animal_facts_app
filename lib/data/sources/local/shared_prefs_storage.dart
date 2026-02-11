import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorage {
  static const String _animalsKey = 'animals_data';
  static const String _progressKey = 'user_progress';

  // Сохраняем список животных (изначально загружаем из assets)
  Future<void> saveAnimals(String jsonString) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_animalsKey, jsonString);
  }

  Future<String?> getAnimals() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_animalsKey);
  }

  Future<void> saveProgress(String jsonString) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_progressKey, jsonString);
  }

  Future<String?> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_progressKey);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}