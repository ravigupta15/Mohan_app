
class Activities {
  dynamic commentType;
  dynamic role;
  dynamic name;
  dynamic status;
  dynamic comments;
  dynamic date;
  dynamic time;

  Activities(
      {this.commentType, this.role, this.name, this.status, this.comments, this.date, this.time});

  Activities.fromJson(Map<String, dynamic> json) {
    commentType = json['comment_type'];
    role = json['role'];
    name = json['name'];
    status = json['status'];
    comments = json['comments'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['comment_type'] = commentType;
    data['role'] = role;
    data['name'] = name;
    data['status'] = status;
    data['comments'] = comments;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
