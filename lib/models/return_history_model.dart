import 'package:redeo/models/return_visit_list_model.dart';

class ReturnHistoryModel {
  String? message;
  NOEModel? info;

  ReturnHistoryModel({this.message, this.info});

  ReturnHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new NOEModel.fromJson(json['info']) : null;
  }
}
