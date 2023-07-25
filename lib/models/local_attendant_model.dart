class LocalAttendantModel {
  String name, phone,type;
  int? from_group_id;
  bool selected;
  int index =0;

  LocalAttendantModel(
      {required this.selected, required this.phone, required this.name, required this.type,this.from_group_id, this.index=0});

  factory LocalAttendantModel.clone(LocalAttendantModel source) {
    return LocalAttendantModel(
      name: source.name,
      phone: source.phone,
      type: source.type,
      from_group_id: source.from_group_id,
      selected: source.selected,
      index: source.index
    );
  }
}
