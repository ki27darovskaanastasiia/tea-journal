import '../entities/tea.dart';

abstract class TeaRepository {
  Future<List<Tea>> getAll();
  Future<Tea?> getById(String id);
  Future<void> add(Tea tea);
  Future<void> update(Tea tea);
  Future<void> delete(String id);
}