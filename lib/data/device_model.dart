class DevicesModel {
  String? modelName;
  String? manufacturer;
  String? brand;

  DevicesModel({this.modelName, this.manufacturer, this.brand});

  DevicesModel.fromJson(Map<String, dynamic> json) {
    modelName = json['model_name'];
    manufacturer = json['manufacturer'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_name'] = this.modelName;
    data['manufacturer'] = this.manufacturer;
    data['brand'] = this.brand;
    return data;
  }
}
