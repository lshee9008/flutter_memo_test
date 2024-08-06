class MemoData {
  String content;
  final DateTime createAt;

  MemoData({required this.content, required this.createAt});

  @override
  String toString() {
    // TODO: implement toString
    return 'content : $content, creatAt : $createAt';
  }
}
