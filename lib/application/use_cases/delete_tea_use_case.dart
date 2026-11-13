import '../../domain/repositories/tea_repository.dart';
import '../exceptions/tea_not_found_exception.dart';

/// Use case: видалити чай за id.
/// Бізнес-правило: не можна видалити чай, якого немає в журналі.
class DeleteTeaUseCase {
  final TeaRepository _repository;

  const DeleteTeaUseCase(this._repository);

  Future<void> call(String id) async {
    final existing = await _repository.getById(id);
    if (existing == null) {
      throw TeaNotFoundException(id);
    }
    await _repository.delete(id);
  }
}