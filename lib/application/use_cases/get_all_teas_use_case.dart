import '../../domain/entities/tea.dart';
import '../../domain/repositories/tea_repository.dart';

/// Use case: отримати всі чаї з журналу.
class GetAllTeasUseCase {
  final TeaRepository _repository;

  const GetAllTeasUseCase(this._repository);

  Future<List<Tea>> call() => _repository.getAll();
}