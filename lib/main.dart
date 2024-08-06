import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<String> items = ['a', 'b', 'c'];
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Memo'),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              onPressed: () {
                items.add('new item');
              },
              icon: Icon(Icons.create),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
              tileColor: Colors.amber[100],
              trailing: IconButton(
                onPressed: () {
                  items.removeAt(index);
                },
                icon: Icon(Icons.delete),
              ),
            );
          },
        ),
      ),
    );
  }
}
