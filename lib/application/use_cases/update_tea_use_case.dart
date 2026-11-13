import '../../domain/entities/tea.dart';
import '../../domain/repositories/tea_repository.dart';

/// Use case: оновити існуючий чай.
/// Бізнес-правило: не можна оновити чай, якого немає в журналі.
class UpdateTeaUseCase {
  final TeaRepository _repository;

  const UpdateTeaUseCase(this._repository);

  Future<void> call(Tea tea) async {
    final existing = await _repository.getById(tea.id);
    if (existing == null) {
      throw ArgumentError('Чай з id "${tea.id}" не знайдено');
    }
    await _repository.update(tea);
  }
}