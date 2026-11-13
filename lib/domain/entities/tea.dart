import 'tea_type.dart';

class Tea {
  final String id;
  final String name;
  final TeaType type;
  final int brewTemperature; // температура води, °C
  final int brewTimeSeconds; // час заварювання, секунди
  final int rating; // оцінка від 1 до 5
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