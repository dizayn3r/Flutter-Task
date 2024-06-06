import 'package:flutter/material.dart';
import 'package:flutter_interview_task/ui/screens/users/users_screen.dart';

import '../collection_delivery/collection_delivery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Tasks"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UsersScreen(),
                ),
              );
            },
            title: const Text("Task 1 - Users, Albums, Photos"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CollectionDeliveryScreen(),
                ),
              );
            },
            title: const Text("Task 2 - Collection Delivery Validation"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
