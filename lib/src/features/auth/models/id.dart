class Id {
  int? timestamp;
  String? date;

  Id({this.timestamp, this.date});

  Id.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['date'] = this.date;
    return data;
  }
}
