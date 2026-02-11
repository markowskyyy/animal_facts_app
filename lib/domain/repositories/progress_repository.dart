import 'package:animal_facts_app/domain/entities/user_progress.dart';

abstract class ProgressRepository {
  Future<UserProgress> getProgress();
  Future<void> saveProgress(UserProgress progress);
  Future<void> addLearnedAnimal(String animalId);
  Future<void> addQuizResult(String animalName, bool isCorrect);
  Future<void> resetProgress();
}