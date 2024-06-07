import 'package:flutter/material.dart';
import 'package:flutter_interview_task/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../screens/albums/albums_screen.dart';
import 'user_form.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AlbumsScreen(userId: user.id!),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text("${user.name!.split(" ")[0][0]}${user.name!.split(" ")[1][0]}"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name!),
                    Text(user.email!),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: UserForm(title: "Update User", user: user),
                  ),
                );
              },
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    surfaceTintColor: Colors.white,
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                    title: Column(
                      children: [
                        const Text("Delete"),
                        Text(
                          "Are you sure you want to delete this user ?",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                        ),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          userProvider.deleteUser(user.id!);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
