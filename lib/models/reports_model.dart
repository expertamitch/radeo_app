class ReportsModel {
  String? message;
  List<ReportInfo>? info;

  ReportsModel({this.message, this.info});

  ReportsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <ReportInfo>[];
      json['info'].forEach((v) {
        info!.add(new ReportInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportInfo {
  String? key;
  String? value;

  ReportInfo({this.key, this.value});

  ReportInfo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

