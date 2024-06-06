import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import 'user_list_item.dart';

class UserSearch extends SearchDelegate<String> {
  final UserProvider userProvider; // Inject the UserProvider dependency

  UserSearch({required this.userProvider});

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for clearing the search
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon to navigate back to the previous screen
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show search results based on the query
    List<User> suggestions = query.isEmpty
        ? recentSearches
        : userProvider.users.where((user) => user.name!.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        User user = suggestions[index];
        return UserListItem(user: user);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show search suggestions while typing
    List<User> suggestions = query.isEmpty
        ? recentSearches
        : userProvider.users.where((user) => user.name!.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        User user = suggestions[index];
        return ListTile(
          onTap: () {
            query = user.name ?? "";
            showResults(context);
          },
          title: Text(user.name ?? ""),
        );
      },
    );
  }

  // Override to customize recent searches (optional)
  List<User> recentSearches = [];
}
