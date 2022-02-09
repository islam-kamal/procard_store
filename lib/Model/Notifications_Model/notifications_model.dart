
class NotificationsModel {
  var id;
  var image;
  var name;
  var body;
  var isRead;
  var tab;
  var createdAt;
  var createdAtFormated;
  Links links;

  NotificationsModel(
      {this.id,
        this.image,
        this.name,
        this.body,
        this.isRead,
        this.tab,
        this.createdAt,
        this.createdAtFormated,
        this.links});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    body = json['body'];
    isRead = json['is_read'];
    tab = json['tab'];
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['body'] = this.body;
    data['is_read'] = this.isRead;
    data['tab'] = this.tab;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Links {
  var delete;

  Links({this.delete});

  Links.fromJson(Map<String, dynamic> json) {
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delete'] = this.delete;
    return data;
  }
}