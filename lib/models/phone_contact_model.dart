import 'package:flutter_contacts/contact.dart';

class PhoneContactModel {
  Contact phoneContact;
  bool selected = false;
  bool isAttendant = false;
  bool isVisible = true;


  PhoneContactModel({required this.selected, required this.phoneContact, this.isAttendant=false});

  factory PhoneContactModel.clone(PhoneContactModel source) {
    return PhoneContactModel(
      phoneContact: source.phoneContact,
      selected: source.selected,
      isAttendant: source.isAttendant
    );
  }
}
