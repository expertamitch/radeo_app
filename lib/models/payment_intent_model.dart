class PaymentIntentModel {
  String? message;
  Info? info;

  PaymentIntentModel({this.message, this.info});

  PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }
}

class Info {

  String? clientSecret;
  String? id;





  Info({

    this.clientSecret,
    this.id,

  });

  Info.fromJson(Map<String, dynamic> json) {


     clientSecret = json['client_secret'];
     id = json['id'];

  }
}
