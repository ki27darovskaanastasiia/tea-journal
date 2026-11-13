import '../../domain/repositories/tea_repository.dart';

/// Use case: видалити чай за id.
/// Бізнес-правило: не можна видалити чай, якого немає в журналі.
class DeleteTeaUseCase {
  final TeaRepository _repository;

  const DeleteTeaUseCase(this._repository);

  Future<void> call(String id) async {
    final existing = await _repository.getById(id);
    if (existing == null) {
      throw ArgumentError('Чай з id "$id" не знайдено');
    }
    await _repository.delete(id);
  }
}