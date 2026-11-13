/// Виняток: чай з указаним id не знайдено в журналі.
class TeaNotFoundException implements Exception {
  final String id;

  const TeaNotFoundException(this.id);

  @override
  String toString() => 'Чай з id "$id" не знайдено';
}