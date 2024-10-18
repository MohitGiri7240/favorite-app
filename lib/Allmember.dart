import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Member,dart';
import 'package:flutter_application_1/favorite.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


// Fetch members from API
Future<List<Member>> fetchMembers(int page) async {
  final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<Member> members = (data['data'] as List)
        .map((memberJson) => Member.fromJson(memberJson))
        .toList();
    return members;
  } else {
    throw Exception('Failed to load members');
  }
}

class AllMembersTab extends StatefulWidget {
  const AllMembersTab({Key? key}) : super(key: key);

  @override
  _AllMembersTabState createState() => _AllMembersTabState();
}

class _AllMembersTabState extends State<AllMembersTab> {
  late Future<List<Member>> futureMembers;

  @override
  void initState() {
    super.initState();
    futureMembers = fetchMembers(1); // Fetch the first page of members
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);

    return FutureBuilder<List<Member>>(
      future: futureMembers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final members = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.all(5),
               
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40, // Avatar size
                      backgroundImage: NetworkImage(member.avatar),
                    ),
                    const SizedBox(width: 10), // Space between avatar and text
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
                      icon: provider.isExist(member)
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border),
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
      },
    );
  }
}
