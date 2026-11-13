import '../../domain/entities/tea.dart';
import '../../domain/repositories/tea_repository.dart';

/// Реалізація TeaRepository, що зберігає дані в пам'яті.
/// Живе в Infrastructure-шарі: Domain про неї нічого не знає.
class InMemoryTeaRepository implements TeaRepository {
  final Map<String, Tea> _storage = {};

  @override
  Future<List<Tea>> getAll() async => _storage.values.toList();

  @override
  Future<Tea?> getById(String id) async => _storage[id];

  @override
  Future<void> add(Tea tea) async {
    _storage[tea.id] = tea;
  }

  @override
  Future<void> update(Tea tea) async {
    _storage[tea.id] = tea;
  }

  @override
  Future<void> delete(String id) async {
    _storage.remove(id);
  }
}