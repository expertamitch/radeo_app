import 'events_model.dart';

class UpdateEventModel {
  String? message;
  EventInfoModel? info;

  UpdateEventModel({this.message, this.info});

  UpdateEventModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new EventInfoModel.fromJson(json['info']) : null;
  }


}




