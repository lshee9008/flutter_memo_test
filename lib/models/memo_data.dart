class MemoData {
  int? id;
  String content;
  final DateTime createAt;

  MemoData({this.id, required this.content, required this.createAt});

  @override
  String toString() {
    // TODO: implement toString
    return 'content : $content, createAt : $createAt';
  }
}
