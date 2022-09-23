class ProvinsiModel {
  String? id;
  String? nama;

  ProvinsiModel({this.id, this.nama});

  ProvinsiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nama'] = nama;
    return data;
  }

  static List<ProvinsiModel> fromJsonList(List list) {
    if (list.isEmpty) return List<ProvinsiModel>.empty();
    return list.map((item) => ProvinsiModel.fromJson(item)).toList();
  }
}
