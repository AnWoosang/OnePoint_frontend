import 'package:flutter/material.dart';

class InfoItem {
  final String label;
  final String value;
  final IconData? icon;

  InfoItem({
    required this.label,
    required this.value,
    this.icon,
  });
} 