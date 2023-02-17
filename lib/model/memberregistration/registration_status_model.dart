class RegistrationStatusModel {
  Data data;
  String message;
  bool success;

  RegistrationStatusModel({this.data, this.message, this.success});

  RegistrationStatusModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  bool isMember;
  String memberNumber;
  String registrationStatus;

  Data({this.isMember, this.memberNumber, this.registrationStatus});

  Data.fromJson(Map<String, dynamic> json) {
    isMember = json['is_member'];
    memberNumber = json['member_number'];
    registrationStatus = json['registration_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_member'] = this.isMember;
    data['member_number'] = this.memberNumber;
    data['registration_status'] = this.registrationStatus;
    return data;
  }
}
