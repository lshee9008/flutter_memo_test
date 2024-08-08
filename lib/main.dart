import 'package:flutter/material.dart';
import 'package:memo_test/database/database_helper.dart';
import 'package:memo_test/models/memo_data.dart';
import 'screen/memo_input_page.dart';

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
  DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<MemoData>> memos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memos = dbHelper.getMemos();
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MemoInputPage())).then((value) {
                  if (!value.isEmpty) {
                    setState(() {
                      dbHelper.insertMemo(
                          MemoData(content: value, createAt: DateTime.now()));
                      memos = dbHelper.getMemos();
                    });
                  }
                });
              },
              icon: Icon(Icons.create),
            ),
          ],
        ),
        body: FutureBuilder<List<MemoData>>(
            future: memos,
            builder: (context, snapshot) {
              var items = snapshot.data ?? [];

              return ListView(
                children: groupMemoDataByYear(items).entries.map((entry) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${entry.key}', //날짜
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomListView(
                        items: entry.value,
                        onDelete: (customId) {
                          setState(() {
                            dbHelper.deleteMemo(customId);
                            memos = dbHelper.getMemos();
                          });
                        },
                        onUpdate: (customMemo) {
                          setState(() {
                            dbHelper.updateMemo(customMemo);
                            memos = dbHelper.getMemos();
                          });
                        },
                      ),
                    ],
                  );
                }).toList(),
              );
            }));
  }

  Map<int, List<MemoData>> groupMemoDataByYear(List<MemoData> items) {
    Map<int, List<MemoData>> memoByYear = {};

    for (var item in items) {
      int year = item.createAt.year;

      if (!memoByYear.containsKey(year)) {
        memoByYear[year] = [];
      }

      memoByYear[year]?.add(
          item); // [year, MemoData(content: '~~~~~', createAt: DateTime(----, --, --))]
      // Map<int, List<MemoData>>
    }

    return memoByYear;
  }
}

class CustomListView extends StatelessWidget {
  final List<MemoData> items;
  final Function(int) onDelete;
  final Function(MemoData) onUpdate;

  const CustomListView({
    super.key,
    required this.items,
    required this.onDelete,
    required this.onUpdate,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var custonItem = items[index];

        return ListTile(
          title: Text(items[index].content),
          subtitle: Text('${items[index].createAt}'),
          tileColor: Colors.amber[100],
          trailing: IconButton(
            onPressed: () {
              onDelete(items[index].id!);
            },
            icon: Icon(Icons.delete),
          ),
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MemoInputPage(initContent: items[index].content)))
                .then((value) {
              if (items[index].content != value) {
                onUpdate(MemoData(
                    id: items[index].id,
                    content: value,
                    createAt: items[index].createAt));
              }
            });
          },
        );
      },
    );
  }
}
