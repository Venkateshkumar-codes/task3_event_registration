import 'package:flutter/material.dart';
import '../models/event.dart';
import '../theme/styles.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool bookmarked;
  final VoidCallback onTap;
  final VoidCallback onBookmark;

  const EventCard({
    super.key,
    required this.event,
    required this.bookmarked,
    required this.onTap,
    required this.onBookmark,
  });

  Widget _pill(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      );

  @override
  Widget build(BuildContext context) {
    final st = categoryStyle(event.category);
    final full = event.seatsLeft == 0;
    final low = event.seatsLeft > 0 && event.seatsLeft <= 10;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'event-icon-${event.id}',
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: st.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(st.icon, color: st.color, size: 30),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _pill(event.category, st.color),
                          if (full)
                            _pill('Full', Colors.red)
                          else
                            _pill('${event.seatsLeft} seats left',
                                low ? Colors.orange : Colors.green),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(event.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Icon(Icons.schedule,
                            size: 15, color: Colors.black54),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(event.date,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black54))),
                      ]),
                      const SizedBox(height: 2),
                      Row(children: [
                        const Icon(Icons.place,
                            size: 15, color: Colors.black54),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(event.venue,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black54))),
                      ]),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onBookmark,
                  icon: Icon(
                    bookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: bookmarked ? brandMid : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}