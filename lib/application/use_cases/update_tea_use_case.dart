import '../../domain/entities/tea.dart';
import '../../domain/repositories/tea_repository.dart';
import '../exceptions/tea_not_found_exception.dart';

/// Use case: оновити існуючий чай.
/// Бізнес-правило: не можна оновити чай, якого немає в журналі.
class UpdateTeaUseCase {
  final TeaRepository _repository;

  const UpdateTeaUseCase(this._repository);

  Future<void> call(Tea tea) async {
    final existing = await _repository.getById(tea.id);
    if (existing == null) {
      throw TeaNotFoundException(tea.id);
    }
    await _repository.update(tea);
  }
}