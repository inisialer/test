class LihatTagihanModel {
  bool success;
  String message;
  List<DataTagihanList> data;

  LihatTagihanModel({this.success, this.message, this.data});

  LihatTagihanModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataTagihanList>[];
      json['data'].forEach((v) {
        data.add(new DataTagihanList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataTagihanList {
  String id;
  String capitalPurpose;
  int nominal;
  int interest;
  int serviceFee;
  int monthlyInstallment;
  int nominalAccepted;
  String status;
  String verifiedEkycTelephoneAt;
  String verifiedFinalAt;
  String disbursedAt;
  String userId;
  int tenorValue;
  int tenorPercentInterest;
  bool isDataTagihanListPemohonVerified;
  bool isPemohonJobVerified;
  String lastStatus;

  DataTagihanList(
      {this.id,
      this.capitalPurpose,
      this.nominal,
      this.interest,
      this.serviceFee,
      this.monthlyInstallment,
      this.nominalAccepted,
      this.status,
      this.verifiedEkycTelephoneAt,
      this.verifiedFinalAt,
      this.disbursedAt,
      this.userId,
      this.tenorValue,
      this.tenorPercentInterest,
      this.isDataTagihanListPemohonVerified,
      this.isPemohonJobVerified,
      this.lastStatus});

  DataTagihanList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    capitalPurpose = json['capital_purpose'];
    nominal = json['nominal'];
    interest = json['interest'];
    serviceFee = json['service_fee'];
    monthlyInstallment = json['monthly_installment'];
    nominalAccepted = json['nominal_accepted'];
    status = json['status'];
    verifiedEkycTelephoneAt = json['verified_ekyc_telephone_at'];
    verifiedFinalAt = json['verified_final_at'];
    disbursedAt = json['disbursed_at'];
    userId = json['user_id'];
    tenorValue = json['tenor_value'];
    tenorPercentInterest = json['tenor_percent_interest'];
    isDataTagihanListPemohonVerified = json['is_data_pemohon_verified'];
    isPemohonJobVerified = json['is_pemohon_job_verified'];
    lastStatus = json['last_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['capital_purpose'] = this.capitalPurpose;
    data['nominal'] = this.nominal;
    data['interest'] = this.interest;
    data['service_fee'] = this.serviceFee;
    data['monthly_installment'] = this.monthlyInstallment;
    data['nominal_accepted'] = this.nominalAccepted;
    data['status'] = this.status;
    data['verified_ekyc_telephone_at'] = this.verifiedEkycTelephoneAt;
    data['verified_final_at'] = this.verifiedFinalAt;
    data['disbursed_at'] = this.disbursedAt;
    data['user_id'] = this.userId;
    data['tenor_value'] = this.tenorValue;
    data['tenor_percent_interest'] = this.tenorPercentInterest;
    data['is_data_pemohon_verified'] = this.isDataTagihanListPemohonVerified;
    data['is_pemohon_job_verified'] = this.isPemohonJobVerified;
    data['last_status'] = this.lastStatus;
    return data;
  }
}
