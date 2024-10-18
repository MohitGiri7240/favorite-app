import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Member,dart';

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
