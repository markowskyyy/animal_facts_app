import 'package:animal_facts_app/data/local_data.dart';
import 'package:animal_facts_app/domain/entities/animal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Провайдер для всех животных
final allAnimalsProvider = Provider<List<Animal>>((ref) {
  return dummyAnimals;
});

// Провайдер для конкретного животного по id
final animalByIdProvider = Provider.family<Animal?, String>((ref, id) {
  final animals = ref.watch(allAnimalsProvider);
  try {
    return animals.firstWhere((a) => a.id == id);
  } catch (e) {
    return null;
  }
});