import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest API Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user['email'];
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }

  void fetchUsers() async {
    print('fetchUsers Called');
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsonData = jsonDecode(body);

    // Check if the 'results' key is present in the response
    if (jsonData.containsKey('results')) {
      // Access the List of users under the 'results' key
      final results = jsonData['results'];

      setState(() {
        // Assign the List of users to the 'users' variable
        users = results;
      });
    } else {
      // Handle the case where the 'results' key is not present in the response
      print('Error: "results" key not found in the API response');
    }

    print("fetchUsers completed");
  }
}
