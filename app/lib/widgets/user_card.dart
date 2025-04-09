import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String region;
  final String status;

  const UserCard({
    Key? key,
    required this.name,
    required this.region,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[700]!),
        ),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          title: Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                region,
                style: TextStyle(color: Colors.grey[400]),
              ),
              Text(
                status,
                style: TextStyle(
                  color: status == 'En ligne' ? Colors.green : Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}