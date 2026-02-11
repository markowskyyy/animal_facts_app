import 'dart:convert';
import 'package:animal_facts_app/data/sources/local/shared_prefs_storage.dart';
import 'package:animal_facts_app/domain/entities/animal.dart';
import 'package:animal_facts_app/domain/repositories/animal_repository.dart';
import 'package:flutter/services.dart';


class AnimalRepositoryImpl implements AnimalRepository {
  final SharedPrefsStorage _storage;

  AnimalRepositoryImpl(this._storage);

  @override
  Future<List<Animal>> getAnimals() async {
    // Пробуем загрузить из SharedPrefs
    final cached = await _storage.getAnimals();
    if (cached != null) {
      final List<dynamic> jsonList = jsonDecode(cached);
      return jsonList.map((e) => Animal.fromJson(e)).toList();
    }

    // Если нет — грузим из assets
    final String response = await rootBundle.loadString('assets/data/animals.json');
    final List<dynamic> data = jsonDecode(response);
    final animals = data.map((e) => Animal.fromJson(e)).toList();

    // Сохраняем в SharedPrefs
    await _storage.saveAnimals(jsonEncode(animals.map((a) => a.toJson()).toList()));

    return animals;
  }

  @override
  Future<Animal?> getAnimalById(String id) async {
    final animals = await getAnimals();
    try {
      return animals.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }
}