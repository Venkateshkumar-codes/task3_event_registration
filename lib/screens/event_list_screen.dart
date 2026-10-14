import 'package:flutter/material.dart';
import '../data/sample_events.dart';
import '../models/event.dart';
import '../theme/styles.dart';
import '../widgets/event_card.dart';
import 'event_details_screen.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final _search = TextEditingController();
  String query = '';
  String category = 'All';
  final Set<String> bookmarked = {};

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Event> get filtered {
    final q = query.trim().toLowerCase();
    return events.where((e) {
      final matchesQuery = q.isEmpty ||
          e.title.toLowerCase().contains(q) ||
          e.venue.toLowerCase().contains(q);
      final matchesCategory = category == 'All' || e.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }

 void openDetails(Event e) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => EventDetailsScreen(event: e)),
  ).then((_) {
    if (mounted) setState(() {}); // redraw with the new counts
  });
}

  Widget header() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: brandGradient),
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).padding.top + 16, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      const Icon(Icons.event_available, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text('Campus Events',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
                '${events.length} upcoming events  \u2022  ${bookmarked.length} saved',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            TextField(
              controller: _search,
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                hintText: 'Search events or venues',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _search.clear();
                          setState(() => query = '');
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filtered;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2FA),
      body: Column(
        children: [
          header(),
          SizedBox(
            height: 58,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: ['All', ...eventCategories]
                  .map((c) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(c),
                          selected: category == c,
                          onSelected: (_) => setState(() => category = c),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 56, color: Colors.black38),
                        SizedBox(height: 12),
                        Text('No events found',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text('Try a different search or category',
                            style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final e = list[index];
                      return EventCard(
                        event: e,
                        bookmarked: bookmarked.contains(e.id),
                        onTap: () => openDetails(e),
                        onBookmark: () => setState(() {
                          if (!bookmarked.add(e.id)) bookmarked.remove(e.id);
                        }),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}