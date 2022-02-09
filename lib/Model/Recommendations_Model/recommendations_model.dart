class RecommendationsModel {
  int id;
  String title;
  String description;
  String url;
  String logo;
  String adImage;
  String createdAt;
  String createdAtFormated;

  RecommendationsModel(
      {this.id,
        this.title,
        this.description,
        this.url,
        this.logo,
        this.adImage,
        this.createdAt,
        this.createdAtFormated});

  RecommendationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    logo = json['logo'];
    adImage = json['ad_image'];
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['logo'] = this.logo;
    data['ad_image'] = this.adImage;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    return data;
  }
}