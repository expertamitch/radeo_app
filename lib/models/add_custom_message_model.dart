import 'custom_message_model.dart';

class AddCustomMessageModel {
  String? message;
  CustomMessage? info;

  AddCustomMessageModel({this.message, this.info});

  AddCustomMessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info =
        json['info'] != null ? new CustomMessage.fromJson(json['info']) : null;
  }
}
