class Endpoint {
  static const String baseURLProd = 'https://api.alhikmah.capioteknologi.xyz/';
  static const String baseURLDev =
      'https://dev.api.alhikmah.capioteknologi.xyz/';
  // static const String baseURLDev =
  //     'http://192.168.16.50:3000/';

  //Auth
  static const String checkUser = 'auth/check';
  static const String login = 'auth/login';
  static const String resendOtp = 'auth/otp/resend';
  static const String verifyOtp = 'auth/otp/verify';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/token/refresh';
  static const String changePassword = 'auth/change/password';
  static const String verifyChangePassword = 'auth/change/password/verify';

  //User
  static const String me = 'me';
  static const String verifyPin = 'me/pin/verify';
  static const String balance = '/me/zipay/balance';
  static const String vaZipay = '/me/zipay/va';

  static const String uploadPublic = '/upload/public';
  static const String uploadPrivate = '/upload/private';
  static const String convertBase = "/upload/convert/base64";

  //Master
  static const String vaBank = 'master/va-bank';
  static const String residenceStatus = 'master/registration/residence-status';
  static const String lastEducation = 'master/registration/last-education';
  static const String job = 'master/registration/job';
  static const String businessPlaceStatus =
      'master/registration/business-place-status';
  static const String disburseBank = '/master/disburse-bank';

  //Pulsa
  static String phoneProvider(String code) => 'master/provider/$code';
  static const String masterPulsaPrabayar = 'master/pulsa-prabayar';
  static const String recentPulsaPrabayar = 'pulsa-prabayar/recently-purchased';
  static const String recentPulsaPrabayarPhone = 'pulsa-prabayar/recent-number';
  static const String requestPulsaPrabayar = 'pulsa-prabayar/request';
  static const String inquiryPulsaPascabayar =
      'biller/ponsel-pascabayar/inquiry';

  //Pln
  static const String inquiryPlnPascabayar = 'biller/pln-pascabayar/inquiry';
  static const String inquiryPlnPrabayar = 'biller/pln-prabayar/inquiry';

  //Bpjs
  static const String inquiryBpjs = 'biller/bpjs/inquiry';

  //Pdam
  static const String pdamAreas = '/master/pdam-areas';
  static const String inquiryPdam = '/biller/pdam/inquiry';

  //Biller
  static const String paymentMethodBiller = 'biller/payment-method';

  //Payment
  static const String confirmPaymentVa = 'payment/confirm-va';
  static const String confirmPaymentZipay = 'payment/confirm-zipay';

  //History Transaction
  static const String historyTransaction = 'histories';

  static String historyDetailBiller(transactionId) => 'biller/$transactionId';

  static String historyDetailPulsa(transactionId) =>
      'pulsa-prabayar/$transactionId';

  //Registration Member
  static const String registrationMember = 'registrations';
  static const String initRegistrationMember = 'registrations/step-1';
  static const String secondRegistrationMember = 'registrations/step-2';
  static const String thirdRegistrationMember = 'registrations/step-3';
  static const String accountRegistrationMember = 'registrations/account';
  static const String submitRegistrationMember = 'registrations/submit';
  static const String resubmitRegistrationMember = 'registrations/resubmit';

  static const String registrationStatus = 'me/registration-status';

  //tabungan
  static const String tabunganList = 'savings';
  static const String tabunganCheckTagihan = 'savings/topup/inquiry';
  static const String tabunganPaymentMethod = 'savings/topup/payment-method';
  static String tabunganMutasi(String id) => 'savings/$id/mutations';
  static const String totalTabungan = 'savings/total-balance';

  //pembiayaan

  static const String tenorPembiyaan = 'tenor';
  static const String capitalLoan = 'capital/loan/calculate';
  static const String capitalRequest = 'capital/loan/request';

  static const String tagihanList = "capital/loan";

  // zipay
  static const String statusKyc = '/me/status/kyc';
  static const String updateKyc = '/me/update/kyc';
  static const String transactionHistory = '/transaction/zipay/history';
  static const String transactionVa = '/transaction/zipay/va';


}
