import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String avatarInitial;

  const UserCard({
    Key? key,
    required this.name,
    required this.email,
    required this.avatarInitial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Card(
      
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16, // Adjusted font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child: Text(
                    avatarInitial,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              email,
              style: const TextStyle(
                color: Colors.grey, // Adjusted text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
