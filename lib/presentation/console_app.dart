import 'dart:io';

import '../application/exceptions/tea_not_found_exception.dart';
import '../application/use_cases/add_tea_use_case.dart';
import '../application/use_cases/delete_tea_use_case.dart';
import '../application/use_cases/get_all_teas_use_case.dart';
import '../application/use_cases/update_tea_use_case.dart';
import '../domain/entities/tea.dart';
import '../domain/entities/tea_type.dart';

/// Консольний інтерфейс журналу чаю.
/// Містить лише взаємодію з користувачем, без бізнес-логіки.
class ConsoleApp {
  final AddTeaUseCase _addTea;
  final GetAllTeasUseCase _getAllTeas;
  final UpdateTeaUseCase _updateTea;
  final DeleteTeaUseCase _deleteTea;

  const ConsoleApp({
    required AddTeaUseCase addTea,
    required GetAllTeasUseCase getAllTeas,
    required UpdateTeaUseCase updateTea,
    required DeleteTeaUseCase deleteTea,
  })  : _addTea = addTea,
        _getAllTeas = getAllTeas,
        _updateTea = updateTea,
        _deleteTea = deleteTea;

  Future<void> run() async {
    while (true) {
      _printMenu();
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          await _add();
        case '2':
          await _showAll();
        case '3':
          await _update();
        case '4':
          await _delete();
        case '0':
        case null:
          stdout.writeln('До побачення!');
          return;
        default:
          stdout.writeln('Невідомий пункт меню.');
      }
    }
  }

  void _printMenu() {
    stdout.writeln('\n=== Чайний журнал ===');
    stdout.writeln('1. Додати чай');
    stdout.writeln('2. Показати всі чаї');
    stdout.writeln('3. Змінити чай');
    stdout.writeln('4. Видалити чай');
    stdout.writeln('0. Вийти');
    stdout.write('Оберіть пункт: ');
  }

  Future<void> _add() async {
    final tea = _readTea(DateTime.now().millisecondsSinceEpoch.toString());
    await _addTea(tea);
    stdout.writeln('Чай додано. Його id: ${tea.id}');
  }

  Future<void> _showAll() async {
    final teas = await _getAllTeas();
    if (teas.isEmpty) {
      stdout.writeln('Журнал порожній.');
      return;
    }
    for (final t in teas) {
      stdout.writeln('${t.id} | ${t.name} | ${t.type.name} | '
          '${t.brewTemperature} °C | ${t.brewTimeSeconds} с | '
          'оцінка ${t.rating} | ${t.notes}');
    }
  }

  Future<void> _update() async {
    final id = _readText('Id чаю, який змінити: ');
    final tea = _readTea(id);
    try {
      await _updateTea(tea);
      stdout.writeln('Чай оновлено.');
    } on TeaNotFoundException catch (e) {
      stdout.writeln('Помилка: $e');
    }
  }

  Future<void> _delete() async {
    final id = _readText('Id чаю, який видалити: ');
    try {
      await _deleteTea(id);
      stdout.writeln('Чай видалено.');
    } on TeaNotFoundException catch (e) {
      stdout.writeln('Помилка: $e');
    }
  }

  Tea _readTea(String id) {
    final name = _readText('Назва: ');
    final type = _readType();
    final temperature = _readInt('Температура води, °C (50-100): ', 50, 100);
    final seconds = _readInt('Час заварювання, секунди (10-1800): ', 10, 1800);
    final rating = _readInt('Оцінка (1-5): ', 1, 5);
    final notes = _readText('Нотатки (можна порожньо): ');
    return Tea(
      id: id,
      name: name,
      type: type,
      brewTemperature: temperature,
      brewTimeSeconds: seconds,
      rating: rating,
      notes: notes,
    );
  }

  String _readText(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync()?.trim() ?? '';
  }

  int _readInt(String prompt, int min, int max) {
    while (true) {
      final value = int.tryParse(_readText(prompt));
      if (value != null && value >= min && value <= max) return value;
      stdout.writeln('Введіть число від $min до $max.');
    }
  }

  TeaType _readType() {
    final names = TeaType.values.map((t) => t.name).join(', ');
    while (true) {
      final input = _readText('Тип ($names): ').toLowerCase();
      for (final type in TeaType.values) {
        if (type.name == input) return type;
      }
      stdout.writeln('Невідомий тип чаю.');
    }
  }
}