import 'tea_type.dart';

class Tea {
  final String id;
  final String name;
  final TeaType type;
  final int brewTemperature;
  final int brewTimeSeconds;
  final int rating;
  final String notes;

  const Tea({
    required this.id,
    required this.name,
    required this.type,
    required this.brewTemperature,
    required this.brewTimeSeconds,
    required this.rating,
    this.notes = '',
  }) : assert(rating >= 1 && rating <= 5);
}