import '../../domain/entities/tea.dart';
import '../../domain/repositories/tea_repository.dart';

/// Use case: додати новий чай до журналу.
class AddTeaUseCase {
  final TeaRepository _repository;

  const AddTeaUseCase(this._repository);

  Future<void> call(Tea tea) => _repository.add(tea);
}