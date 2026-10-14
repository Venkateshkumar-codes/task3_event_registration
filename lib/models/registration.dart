import 'event.dart';

class Registration {
  final Event event;
  final String name;
  final String email;
  final String year;

  const Registration({
    required this.event,
    required this.name,
    required this.email,
    required this.year,
  });
}