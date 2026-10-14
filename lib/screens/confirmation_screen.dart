import 'package:flutter/material.dart';
import '../models/registration.dart';
import '../theme/styles.dart';

class ConfirmationScreen extends StatelessWidget {
  final Registration registration;
  const ConfirmationScreen({super.key, required this.registration});

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: brandMid),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(String title, List<Widget> rows) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          ...rows,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = registration;
    final e = r.event;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F2FA),
      body: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(32)),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(gradient: brandGradient),
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).padding.top + 28, 20, 28),
              child: Column(
                children: [
                  // Success animation: the check icon pops in.
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) =>
                        Transform.scale(scale: scale, child: child),
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_rounded,
                          size: 56, color: Colors.green),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Registration confirmed!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('Thank you, ${r.name}. See you there!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _card('Event', [
                    _row(Icons.event, 'Event', e.title),
                    _row(Icons.schedule, 'Date and time', e.date),
                    _row(Icons.place, 'Venue', e.venue),
                  ]),
                  const SizedBox(height: 14),
                  _card('Your details', [
                    _row(Icons.person, 'Name', r.name),
                    _row(Icons.email, 'Email', r.email),
                    _row(Icons.school, 'Year of study', r.year),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 52,
            child: FilledButton.icon(
              // Go back to the first screen (the event list).
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              icon: const Icon(Icons.home),
              label: const Text('Back to events'),
            ),
          ),
        ),
      ),
    );
  }
}