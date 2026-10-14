import 'package:flutter/material.dart';

const Color brandDark = Color(0xFF311B92);
const Color brandMid = Color(0xFF5E35B1);
const Color brandLight = Color(0xFF9575CD);

const LinearGradient brandGradient = LinearGradient(
  colors: [brandDark, brandMid, brandLight],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const List<String> eventCategories = [
  'Workshop',
  'Competition',
  'Talk',
  'Cultural',
];

class CategoryStyle {
  final IconData icon;
  final Color color;
  const CategoryStyle(this.icon, this.color);
}

CategoryStyle categoryStyle(String category) {
  switch (category) {
    case 'Workshop':
      return const CategoryStyle(Icons.build_circle, Color(0xFF5E35B1));
    case 'Competition':
      return const CategoryStyle(Icons.emoji_events, Color(0xFFEF6C00));
    case 'Talk':
      return const CategoryStyle(Icons.mic, Color(0xFF00897B));
    case 'Cultural':
      return const CategoryStyle(Icons.music_note, Color(0xFFD81B60));
    default:
      return const CategoryStyle(Icons.event, Color(0xFF546E7A));
  }
}