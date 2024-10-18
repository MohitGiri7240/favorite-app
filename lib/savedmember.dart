import 'package:flutter/material.dart';
import 'package:flutter_application_1/favorite.dart';

import 'package:provider/provider.dart';


class SavedMembersTab extends StatelessWidget {
  const SavedMembersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);

    if (provider.favorites.isEmpty) {
      return const Center(child: Text('No saved members'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: provider.favorites.length,
      itemBuilder: (context, index) {
        final member = provider.favorites[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.all(10),
         
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(member.avatar),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${member.firstName} ${member.lastName}',
                      style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      member.email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  provider.toggleFavorite(member);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
