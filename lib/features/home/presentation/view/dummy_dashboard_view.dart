import 'package:flutter/material.dart';

class StackOverflowDashboard extends StatelessWidget {
  const StackOverflowDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discussion Forum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Questions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
            SizedBox(height: 16.0),
            QuestionCard(
              title: 'How to use Flutter?',
              tags: ['flutter', 'dart'],
              votes: 42,
              answers: 15,
            ),
            QuestionCard(
              title: 'Dart null safety - best practices',
              tags: ['dart', 'null-safety'],
              votes: 28,
              answers: 8,
            ),
            // Add more QuestionCard widgets as needed
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String title;
  final List<String> tags;
  final int votes;
  final int answers;

  const QuestionCard({
    super.key,
    required this.title,
    required this.tags,
    required this.votes,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.arrow_upward, color: Colors.green),
                Text('$votes votes'),
                const SizedBox(width: 16.0),
                const Icon(Icons.chat_bubble, color: Colors.blue),
                Text('$answers answers'),
              ],
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
