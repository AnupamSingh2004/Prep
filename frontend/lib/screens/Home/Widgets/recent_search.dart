import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    final recentItems = ['Paracetamol 500mg', 'Crocin', 'Dolo 650'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Searches',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...recentItems.map(
              (item) => Card(
            child: ListTile(
              leading: const Icon(Icons.medication),
              title: Text(item),
              trailing: const Icon(Icons.search),
              onTap: () {},
            ),
          ),
        )
      ],
    );
  }
}
