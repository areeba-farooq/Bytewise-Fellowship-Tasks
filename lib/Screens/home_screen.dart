import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Feed'),
            backgroundColor: Colors.purple[400]),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, i) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
                title: const Text('Buenas noches, Que te vaya bien'),
                subtitle: const Text('Transate it in English'),
                trailing: Icon(
                  Icons.translate,
                  color: Colors.purple[400],
                ),
              );
            }));
  }
}
