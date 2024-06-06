import 'package:flutter/material.dart';
import 'package:flutter_interview_task/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../widgets/users/user_list_item.dart';
import '../../widgets/users/user_search.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUsers();
    });
    super.initState();
  }

  getUsers() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: UserSearch(userProvider: Provider.of<UserProvider>(context, listen: false)),
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return provider.loading == false
              ? ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    User user = provider.users[index];
                    return UserListItem(user: user);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
