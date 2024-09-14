class CityModel {
  int? id;
  String? title;
  String? description;
  int? status;
  String? localedStatus;
  String? createdAt;
  String? createdAtFormatted;

  CityModel(
      {this.id,
        this.title,
        this.description,
        this.status,
        this.localedStatus,
        this.createdAt,
        this.createdAtFormatted});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    localedStatus = json['localed_status'];
    createdAt = json['created_at'];
    createdAtFormatted = json['created_at_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['localed_status'] = localedStatus;
    data['created_at'] = createdAt;
    data['created_at_formatted'] = createdAtFormatted;
    return data;
  }
}
