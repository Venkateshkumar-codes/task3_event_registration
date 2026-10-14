import '../models/event.dart';

// Not const any more, because `registered` changes while the app runs.
final events = [
  Event(
    id: 'e1',
    title: 'Flutter Workshop',
    date: '15 Oct 2026, 10:00 AM',
    venue: 'Seminar Hall A',
    description:
        'A hands-on session on building your first Flutter app. Bring your laptop with Flutter installed. Beginners are welcome.',
    category: 'Workshop',
    organizer: 'Google Developer Student Club',
    totalSeats: 40,
    registered: 10,
  ),
  Event(
    id: 'e2',
    title: 'Hackathon Kickoff',
    date: '22 Oct 2026, 09:00 AM',
    venue: 'Innovation Lab',
    description:
        'Meet your teammates, hear the problem statements and start building. Teams of up to four students. Snacks provided.',
    category: 'Competition',
    organizer: 'Coding Club',
    totalSeats: 100,
    registered: 10,
  ),
  Event(
    id: 'e3',
    title: 'Career Talk: Mobile Developers',
    date: '29 Oct 2026, 03:00 PM',
    venue: 'Auditorium',
    description:
        'Industry speakers share how they started their careers in mobile development and answer student questions.',
    category: 'Talk',
    organizer: 'Placement Cell',
    totalSeats: 150,
    registered: 10,
  ),
  Event(
    id: 'e4',
    title: 'Open Mic Night',
    date: '05 Nov 2026, 06:00 PM',
    venue: 'Open Air Theatre',
    description:
        'Sing, perform poetry or play an instrument. Everyone is welcome to perform or just cheer for friends.',
    category: 'Cultural',
    organizer: 'Cultural Committee',
    totalSeats: 11, // only 1 seat left, so you can test the "Full" state
    registered: 10,
  ),
  Event(
    id: 'e5',
    title: 'UI/UX Design Basics',
    date: '12 Nov 2026, 11:00 AM',
    venue: 'Design Studio',
    description:
        'Learn the basics of user interface design, color, spacing and typography, with a short practical exercise.',
    category: 'Workshop',
    organizer: 'Design Society',
    totalSeats: 30,
    registered: 10,
  ),
];