import '../application/use_cases/add_tea_use_case.dart';
import '../application/use_cases/delete_tea_use_case.dart';
import '../application/use_cases/get_all_teas_use_case.dart';
import '../application/use_cases/update_tea_use_case.dart';
import '../domain/repositories/tea_repository.dart';
import '../infrastructure/repositories/in_memory_tea_repository.dart';
import 'console_app.dart';

/// Точка входу: збирає всі шари через Dependency Injection.
Future<void> main() async {
  // Єдине місце, де вибирається реалізація сховища
  final TeaRepository repository = InMemoryTeaRepository();

  final app = ConsoleApp(
    addTea: AddTeaUseCase(repository),
    getAllTeas: GetAllTeasUseCase(repository),
    updateTea: UpdateTeaUseCase(repository),
    deleteTea: DeleteTeaUseCase(repository),
  );

  await app.run();
}