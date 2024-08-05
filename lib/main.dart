import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Memo'),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.create),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('아이템 $index'),
              tileColor: Colors.amber[100],
              trailing: IconButton(
                onPressed: () {
                  print('삭제: 아이템 $index');
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
