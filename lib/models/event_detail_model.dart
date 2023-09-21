import 'events_model.dart';

class EventDetailModel {
  String? message;
  EventInfoModel? info;

  EventDetailModel({this.message, this.info});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new EventInfoModel.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}


