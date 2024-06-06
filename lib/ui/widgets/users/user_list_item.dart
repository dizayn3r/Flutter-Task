import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../screens/albums/albums_screen.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AlbumsScreen(userId: user.id!),
          ),
        );
      },
      leading: CircleAvatar(
        child: Text("${user.name!.split(" ")[0][0]}${user.name!.split(" ")[1][0]}"),
      ),
      title: Text(user.name!),
      subtitle: Text(user.email!),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
