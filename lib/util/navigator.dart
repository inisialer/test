import 'package:alhikmah_app/screen/auth/changepin/change_pin_screen.dart';
import 'package:alhikmah_app/screen/auth/checkotp/check_otp_screen.dart';
import 'package:alhikmah_app/screen/auth/checkphone/check_phone_screen.dart';
import 'package:alhikmah_app/screen/auth/checkpin/check_pin_screen.dart';
import 'package:alhikmah_app/screen/auth/checkprofile/check_profile_screen.dart';
import 'package:alhikmah_app/screen/auth/checkprofile/success_profile_screen.dart';
import 'package:alhikmah_app/screen/main/main_screen.dart';
import 'package:alhikmah_app/screen/main/menu/home/detail_home_screen.dart';
import 'package:alhikmah_app/screen/main/menu/notification/detail_notification_screen.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/detail_tagihan_pembiayaan_m_screen.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/pembiayaan_m_screen.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/pembiayaan_modal_screen.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/result_pembiayaan_screen.dart';
import 'package:alhikmah_app/screen/main/menu/pembiayaan_modal/tagihan_pembiayaan_m_screen.dart';
import 'package:alhikmah_app/screen/auth/checkphone/registration_confirmation_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/registration_member_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/result_registration_member_screen.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/upload_document_member_screen.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/bayar_setoran_awal_screen.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/setoran_awal_screen.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/setoran_rutin_screen.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/setorang_shu_screen.dart';
import 'package:alhikmah_app/screen/main/menu/tabungan/tabungan_screen.dart';
import 'package:alhikmah_app/screen/main/menu/transaction/detail_transaction_biller_screen.dart';
import 'package:alhikmah_app/screen/main/menu/transaction/detail_transaction_pulsa_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/bpjs/bpjs_detail_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/bpjs/bpjs_payment_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/bpjs/bpjs_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_bank_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_confirm_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_information_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_method_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_status_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/payment/payment_zipay_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pdam/pdam_payment_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pdam/pdam_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pln/pln_pascabayar_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pln/pln_payment_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pln/pln_prabayar_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_pascabayar_payment_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_pascabayar_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_detail_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_payment_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/pulsa/pulsa_prabayar_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/topup/top_up_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/topup/top_up_wallet_screen.dart';
import 'package:alhikmah_app/screen/main/ppob/zakat/zakat_screen.dart';
import 'package:alhikmah_app/screen/main/zipay/detail_virtual_bank.dart';
import 'package:alhikmah_app/screen/main/zipay/form_upgrade_zipay_screen.dart';
import 'package:alhikmah_app/screen/main/zipay/list_top_up_bank.dart';
import 'package:alhikmah_app/screen/main/zipay/riwayat_transaksi_screen.dart';
import 'package:alhikmah_app/screen/main/zipay/upgrade_zipay_screen.dart';
import 'package:alhikmah_app/screen/main/zipay/upload_document_upgrade_screen.dart';
import 'package:alhikmah_app/screen/main/zipay/zipay_screen.dart';
import 'package:alhikmah_app/screen/start/onboarding/onboarding_screen.dart';
import 'package:alhikmah_app/screen/start/splash/splash_screen.dart';
import 'package:alhikmah_app/screen/start/splashbasmallah/splash_basmallah_screen.dart';
import 'package:flutter/material.dart';

import '../screen/auth/checkphone/succes_register_to_zipay_screen.dart';

var routes = <String, WidgetBuilder>{
  '/zipay/upgrade/intro': (BuildContext context)=> UpgradeZipayScreen(),
  '/zipay/upgrade/form': (BuildContext context) => FormUpgradeZipayScreen(),
  '/zipay/history': (BuildContext context) => RiwayatTransaksiScreen(),
  '/zipay/homepage': (BuildContext context) => ZipayScreen(),
  '/splash-basmallah': (BuildContext context) => SplashBasmallahScreen(),
  '/splash': (BuildContext context) => SplashScreen(),
  '/onboarding': (BuildContext context) => OnboardingScreen(),
  '/check-phone': (BuildContext context) => CheckPhoneScreen(),
  '/check-otp': (BuildContext context) => CheckOtpScreen(),
  '/check-pin': (BuildContext context) => CheckPinScreen(),
  '/check-profile': (BuildContext context) => CheckProfileScreen(),
  '/success-profile': (BuildContext context) => SuccessProfileScreen(),
  '/main': (BuildContext context) => MainScreen(),
  '/detail-home': (BuildContext context) => DetailHomeScreen(),
  '/detail-transaction-biller': (BuildContext context) =>
      DetailTransactionBillerScreen(),
  '/detail-transaction-pulsa': (BuildContext context) =>
      DetailTransactionPulsaScreen(),
  '/detail-notification': (BuildContext context) => DetailNotificationScreen(),
  '/home-topup': (BuildContext context) => TopUpScreen(),
  '/home-topup-wallet': (BuildContext context) => TopUpWalletScreen(),
  '/home-bpjs': (BuildContext context) => BpjsScreen(),
  '/home-bpjs-detail': (BuildContext context) => BpjsDetailScreen(),
  '/home-bpjs-payment': (BuildContext context) => BpjsPaymentScreen(),
  '/home-pulsa-prabayar': (BuildContext context) => PulsaPrabayarScreen(),
  '/home-pulsa-prabayar-detail': (BuildContext context) =>
      PulsaPrabayarDetailScreen(),
  '/home-pulsa-prabayar-payment': (BuildContext context) =>
      PulsaPrabayarPaymentScreen(),
  '/home-pulsa-pascabayar': (BuildContext context) => PulsaPascabayarScreen(),
  '/home-pascabayar-payment': (BuildContext context) =>
      PulsaPascabayarPaymentScreen(),
  '/home-pdam': (BuildContext context) => PdamScreen(),
  '/home-pdam-payment': (BuildContext context) => PdamPaymentScreen(),
  '/home-pln-pascabayar': (BuildContext context) => PlnPascabayarScreen(),
  '/home-pln-prabayar': (BuildContext context) => PlnPrabayarScreen(),
  '/home-pln-payment': (BuildContext context) => PlnPaymentScreen(),
  '/home-zakat': (BuildContext context) => ZakatScreen(),
  '/home-payment-method': (BuildContext context) => PaymentMethodScreen(),
  '/home-payment-confirm': (BuildContext context) => PaymentConfirmScreen(),
  '/home-payment-status': (BuildContext context) => PaymentStatusScreen(),
  '/home-payment-bank': (BuildContext context) => PaymentBankScreen(),
  '/home-payment-zipay': (BuildContext context) => PaymentZipayScreen(),
  '/home-payment-information': (BuildContext context) =>
      PaymentInformationScreen(),
  '/profile-registration-member': (BuildContext context) =>
      RegistrationMemberScreen(),
  '/result-registration-member': (BuildContext context) =>
      ResultRegistrationMemberScreen(),
  '/upload-document': (BuildContext context) => UploadDocumentMemberScreen(),
  '/tabungan_screen': (BuildContext context) => TabunganScreen(),
  '/setoran_awal_screen': (BuildContext context) => SetoranAwalScreen(),
  '/bayar_setoran_awal_screen': (BuildContext context) =>
      BayarSetoranAwalscreen(),
  '/pembiayaan_modal_screen': (BuildContext context) => PembiayaanModalScreen(),
  '/pembiayaan_m_screen': (BuildContext context) => PembiayaanMScreen(),
  '/result_pembayaran_screen': (BuildContext context) =>
      ResultPembiyaanScreen(),
  '/setoran_rutin_screen': (BuildContext context) => SetoranRutinScreen(),
  '/tagihan_pembiayaan_screen': (BuildContext context) =>
      TagihanPembiyaanScreen(),
  '/detail_tagihan_pembiayaan_screen': (BuildContext context) =>
      DetailPembiayaanModal(),
  '/setoran_shu_screen': (BuildContext context) => SetoranSHUScreen(),
  '/change-pin': (BuildContext context) => ChangePinScreen(),
  '/upgrade/upload/upgrade': (BuildContext context) => UploadDocumentUpgradeScreen(),
  'zipay/topup/list': (BuildContext context)=> ListTopUpBank(),
  'zipay/topup/bank/detail': (BuildContext context)=> ListVirtualBankScreen(),
  '/registration/confirmation': (BuildContext context)=> RegistrationConfirmationScreen(),
  '/registration/success': (BuildContext context)=> SuccessRegisterToZipayScreen(),
};

class MyNavigator {
  static void bayarSetoran(
      BuildContext context, BayarSetoranArgs bayarSetoranArgs) {
    Navigator.pushReplacementNamed(context, '/bayar_setoran_awal_screen',
        arguments: bayarSetoranArgs);
  }

  static void gotToListVirtual(BuildContext context){
    Navigator.pushNamed(context, "zipay/topup/list");
  }
  static void gotToDetailVirtual(BuildContext context, ListVirtualBankArgs args){
    Navigator.pushNamed(context, "zipay/topup/bank/detail", arguments: args);
  }

  static void goToSuccessZipay(BuildContext context){
    Navigator.pushReplacementNamed(context, "/registration/success");
  }

  static void goToConfirmationScreen(BuildContext context, CheckPinArguments args){
    Navigator.pushReplacementNamed(context, "/registration/confirmation", arguments: args);
  }

  static void goClose(BuildContext context) {
    Navigator.pop(context);
  }

  static void goToSplash(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/splash');
  }

  static void goToOnboarding(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  static void goToCheckPhone(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/check-phone');
  }

  static void goUpgradeZipayIntro(BuildContext context){
    Navigator.pushNamed(context, '/zipay/upgrade/intro');
  }

  static void goUpgradeZipayForm(BuildContext context){
    Navigator.pushReplacementNamed(context, '/zipay/upgrade/form');
  }

  static void goToChangePin(BuildContext context, ChangePinArguments args) {
    Navigator.pushReplacementNamed(context, "/change-pin", arguments: args);
  }

  static void goToCheckOtp(BuildContext context, CheckOtpArguments args) {
    Navigator.pushReplacementNamed(context, '/check-otp', arguments: args);
  }

  static void goToHistoryZipay(BuildContext context) {
    Navigator.pushNamed(context,"/zipay/history");
  }
  static void goToCheckPin(BuildContext context, CheckPinArguments args) {
    Navigator.pushReplacementNamed(context, '/check-pin', arguments: args);
  }

  static void goToCheckProfile(
      BuildContext context, CheckProfileArguments args) {
    Navigator.pushReplacementNamed(context, '/check-profile', arguments: args);
  }

  static void goToSuccessProfile(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/success-profile');
  }

  static void goToMain(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/main');
  }

  static void goBackToMain(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName("/main"));
    Navigator.pushReplacementNamed(context, "/main");
  }

  static void goToDetailHome(BuildContext context) {
    Navigator.pushNamed(context, '/detail-home');
  }

  static void goToDetailTransactionBiller(
      BuildContext context, DetailTransactionBillerArguments args) {
    Navigator.pushNamed(context, '/detail-transaction-biller', arguments: args);
  }

  static void goToDetailTransactionPulsa(
      BuildContext context, DetailTransactionPulsaArguments args) {
    Navigator.pushNamed(context, '/detail-transaction-pulsa', arguments: args);
  }

  static void goToDetailNotification(
      BuildContext context, DetailNotificationArguments args) {
    Navigator.pushNamed(context, '/detail-notification', arguments: args);
  }

  static void goToHomeTopUp(BuildContext context) {
    Navigator.pushNamed(context, '/home-topup');
  }

  static void goToHomeTopUpWallet(BuildContext context) {
    Navigator.pushNamed(context, '/home-topup-wallet');
  }

  static void goToHomeBPJS(BuildContext context) {
    Navigator.pushNamed(context, '/home-bpjs');
  }

  static void goToHomeBPJSDetail(
      BuildContext context, BpjsDetailArguments args) {
    Navigator.pushNamed(context, '/home-bpjs-detail', arguments: args);
  }

  static void goToHomeBPJSPayment(
      BuildContext context, BpjsPaymentArguments args) {
    Navigator.pushNamed(context, '/home-bpjs-payment', arguments: args);
  }

  static void goToHomePulsa(BuildContext context) {
    Navigator.pushNamed(context, '/home-pulsa-prabayar');
  }

  static void goToHomePulsaDetail(
      BuildContext context, PulsaPrabayarDetailArguments args) {
    Navigator.pushNamed(context, '/home-pulsa-prabayar-detail',
        arguments: args);
  }

  static void goToHomePulsaPayment(
      BuildContext context, PulsaPrabayarPaymentArguments args) {
    Navigator.pushNamed(context, '/home-pulsa-prabayar-payment',
        arguments: args);
  }

  static void goToHomePDAM(BuildContext context) {
    Navigator.pushNamed(context, '/home-pdam');
  }

  static void goToZipayHomePage(BuildContext context){
    Navigator.pushNamed(context, '/zipay/homepage');
  }

  static void goToHomePdamPayment(
      BuildContext context, PdamPaymentArguments args) {
    Navigator.pushNamed(context, '/home-pdam-payment', arguments: args);
  }

  static void goToHomePascabayar(BuildContext context) {
    Navigator.pushNamed(context, '/home-pulsa-pascabayar');
  }

  static void goToHomePascabayarPayment(
      BuildContext context, PulsaPascabayarPaymentArguments args) {
    Navigator.pushNamed(context, '/home-pascabayar-payment', arguments: args);
  }

  static void goToHomePlnPascabayar(BuildContext context) {
    Navigator.pushNamed(context, '/home-pln-pascabayar');
  }

  static void goToHomePlnPayment(
      BuildContext context, PlnPaymentArguments args) {
    Navigator.pushNamed(context, '/home-pln-payment', arguments: args);
  }

  static void goToHomePlnPrabayar(BuildContext context) {
    Navigator.pushNamed(context, '/home-pln-prabayar');
  }

  static void goToHomeZakat(BuildContext context) {
    Navigator.pushNamed(context, '/home-zakat');
  }

  static void goToHomePaymentMethod(BuildContext context) {
    Navigator.pushNamed(context, '/home-payment-method');
  }

  static void goToHomePaymentConfirm(
      BuildContext context, PaymentConfirmArguments args) {
    Navigator.pushNamed(context, '/home-payment-confirm', arguments: args);
  }

  static void goToHomePaymentStatus(
      BuildContext context, PaymentStatusArguments args) {
    Navigator.pushNamed(context, '/home-payment-status', arguments: args);
  }

  static void goToHomePaymentBank(
      BuildContext context, PaymentBankArguments args) {
    Navigator.pushNamed(context, '/home-payment-bank', arguments: args);
  }

  static void goToHomePaymentZipay(
      BuildContext context, PaymentZipayArguments args) {
    Navigator.pushNamed(context, '/home-payment-zipay', arguments: args);
  }

  static void goToHomePaymentInformation(
      BuildContext context, PaymentInformationArguments args) {
    Navigator.pushNamed(context, '/home-payment-information', arguments: args);
  }

  static void goToProfileRegistrationMember(BuildContext context) {
    Navigator.pushNamed(context, '/profile-registration-member');
  }

  static void goToResultRegistrationMember(
      BuildContext context, ResultRegistrationMemberArguments args) {
    Navigator.pushNamed(context, '/result-registration-member',
        arguments: args);
  }

  static void goToUploadDocument(BuildContext context) {
    Navigator.pushNamed(context, '/upload-document');
  }

  static void goToDetailPembiayaanModal(BuildContext context,
      DetailPembiayaanModalArgs detailPembiayaanModalArgs) {
    Navigator.pushNamed(context, '/detail_tagihan_pembiayaan_screen',
        arguments: detailPembiayaanModalArgs);
  }
}
