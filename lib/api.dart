import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class testApii extends StatefulWidget {
  const testApii({super.key});

  @override
  State<testApii> createState() => _testApiiState();
}

List<dynamic> users = [];

class _testApiiState extends State<testApii> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Search bar"),
          ),
          ListView.builder(itemBuilder: ((context, index) {
            if (users.isEmpty) {
              return Center(
                child: Text("No data"),
              );
            }
            final user = users[index];
            final name = user['name'];
            final username = user['username'];
            return ListTile(
              title: Text(name),
              subtitle: Text(username),
            );
          })),
        ],
      )),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }

  void fetchUsers() async {
    const url = 'https://jsonplaceholder.typicode.com/users';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json[''];
      users.sort((a, b) => a.toString().compareTo(b.toString()));
    });
    print("users fetched completed");
  }
}
