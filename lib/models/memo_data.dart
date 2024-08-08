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

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'content': content,
      'createAt': createAt.toIso8601String()
    };
  }
}
