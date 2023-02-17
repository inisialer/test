import 'package:alhikmah_app/data/constants.dart';
import 'package:flutter/material.dart';

class OnboardingModel {
  String image;
  String title;
  String description;

  OnboardingModel({
    @required this.image,
    @required this.title,
    @required this.description,
  });
}

var onboardingList = [
  OnboardingModel(
      image: Images.ONBOARDING_1,
      title: 'Transaksi Aman Sesuai Syariah',
      description:
          'Terhindar dari transaksi yang diharamkan, Anti Maysir, Ghoror, Riba, dan Dzholim'),
  OnboardingModel(
      image: Images.ONBOARDING_2,
      title: 'Bayar Tagihan Lebih Cepat',
      description: 'Lebih Mudah Bayar Tagihan Lewat Aplikasi Al Hikmah'),
  OnboardingModel(
      image: Images.ONBOARDING_3,
      title: 'Atur Keuanganmu ',
      description:
          'Pantau Keuanganmu Lebih Tepat, Dengan Aplikasi yang Sederhana'),
];
