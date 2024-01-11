import 'package:redeo/models/plans_model.dart';

class ActivePlanModel {
  String? message;
  PlanDetail? info;

  ActivePlanModel({this.message, this.info});

  ActivePlanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new PlanDetail.fromJson(json['info']) : null;
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

