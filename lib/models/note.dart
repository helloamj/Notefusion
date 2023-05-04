class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;

  Note({this.id, this.userid, this.title, this.content, this.dateadded});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'dateadded': dateadded!.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      userid: json['userid'],
      title: json['title'],
      content: json['content'],
      dateadded: DateTime.tryParse(json['dateadded']),
    );
  }
}
