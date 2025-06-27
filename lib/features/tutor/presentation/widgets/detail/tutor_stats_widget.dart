import 'package:flutter/material.dart';
import 'package:fitkle/features/tutor/domain/entities/tutor_models.dart';

class TutorStatsWidget extends StatelessWidget {
  final Tutor tutor;

  const TutorStatsWidget({
    super.key,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tutor.statsItems.length, (index) {
          final statItem = tutor.statsItems[index];
          return Row(
            children: [
              _buildStatItem(statItem.label, statItem.value, icon: statItem.icon),
              if (index < tutor.statsItems.length - 1) _buildDivider(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (icon != null)
                Icon(icon, color: Colors.amber, size: 20),
              if (icon != null) const SizedBox(width: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
} 