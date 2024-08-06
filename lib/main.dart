import 'package:flutter/material.dart';
import 'models/memo_data.dart';

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
      home: MyMemoAppPage(),
    );
  }
}

class MyMemoAppPage extends StatefulWidget {
  const MyMemoAppPage({super.key});

  @override
  State<MyMemoAppPage> createState() => _MyMemoAppPageState();
}

class _MyMemoAppPageState extends State<MyMemoAppPage> {
  List<MemoData> items = [
    MemoData(content: 'Memo 1', createAt: DateTime(2022, 12, 31)),
    MemoData(content: 'Memo 2', createAt: DateTime(2023, 07, 31)),
    MemoData(content: 'Memo 3', createAt: DateTime(2024, 01, 31)),
    MemoData(content: 'Memo 4', createAt: DateTime(2024, 08, 07))
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                items.add(
                    MemoData(content: "New Memo", createAt: DateTime.now()));
              });
            },
            icon: Icon(Icons.create),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomListView(
            items: items,
            onDelete: (index) {
              setState(() {
                items.removeAt(index);
              });
            },
          ),
          CustomListView(
            items: items,
            onDelete: (index) {
              setState(() {
                items.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<MemoData> items;
  final Function(int) onDelete;

  const CustomListView({
    super.key,
    required this.items,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].content),
          subtitle: Text('${items[index].createAt}'),
          tileColor: Colors.amber[100],
          trailing: IconButton(
            onPressed: () {
              onDelete(index);
            },
            icon: Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
