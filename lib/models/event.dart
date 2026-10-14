class Event {
  final String id;
  final String title;
  final String date;
  final String venue;
  final String description;
  final String category;
  final String organizer;
  final int totalSeats;
  int registered; // not final: it increases when someone registers

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.venue,
    required this.description,
    required this.category,
    required this.organizer,
    required this.totalSeats,
    required this.registered,
  });

  int get seatsLeft => totalSeats - registered;
  bool get isFull => registered >= totalSeats;
}