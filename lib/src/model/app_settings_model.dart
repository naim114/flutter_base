import 'dart:ui';

class AppSettingsModel {
  final String applicationName;
  final Color colorDanger;
  final Color colorNeutral1;
  final Color colorNeutral2;
  final Color colorNeutral3;
  final Color colorPrimary;
  final Color colorSecondary;
  final Color colorSuccess;
  final String logoFavicon;
  final String logoMain;
  final String urlCopyright;
  final String urlPrivacyPolicy;
  final String urlTermCondition;

  AppSettingsModel({
    required this.applicationName,
    required this.colorDanger,
    required this.colorNeutral1,
    required this.colorNeutral2,
    required this.colorNeutral3,
    required this.colorPrimary,
    required this.colorSecondary,
    required this.colorSuccess,
    required this.logoFavicon,
    required this.logoMain,
    required this.urlCopyright,
    required this.urlPrivacyPolicy,
    required this.urlTermCondition,
  });

  @override
  String toString() {
    return 'AppSettingsModel(applicationName: $applicationName, colorDanger: $colorDanger, colorNeutral1: $colorNeutral1, colorNeutral2: $colorNeutral2, colorNeutral3: $colorNeutral3, colorPrimary: $colorPrimary, colorSecondary: $colorSecondary, colorSuccess: $colorSuccess, logoFavicon: $logoFavicon, logoMain: $logoMain, urlCopyright: $urlCopyright, urlPrivacyPolicy: $urlPrivacyPolicy, urlTermCondition: $urlTermCondition)';
  }

  Map<String, Object?> toJson() {
    return {
      'applicationName': applicationName,
      'colorDanger': colorDanger.value.toRadixString(16).toUpperCase(),
      'colorNeutral1': colorNeutral1.value.toRadixString(16).toUpperCase(),
      'colorNeutral2': colorNeutral2.value.toRadixString(16).toUpperCase(),
      'colorNeutral3': colorNeutral3.value.toRadixString(16).toUpperCase(),
      'colorPrimary': colorPrimary.value.toRadixString(16).toUpperCase(),
      'colorSecondary': colorSecondary.value.toRadixString(16).toUpperCase(),
      'colorSuccess': colorSuccess.value.toRadixString(16).toUpperCase(),
      'logoFavicon': logoFavicon,
      'logoMain': logoMain,
      'urlCopyright': urlCopyright,
      'urlPrivacyPolicy': urlPrivacyPolicy,
      'urlTermCondition': urlTermCondition,
    };
  }

  factory AppSettingsModel.fromMap(Map<String, dynamic> map) {
    return AppSettingsModel(
      applicationName: map['applicationName'],
      colorDanger: Color(int.parse(map['colorDanger'].substring(1), radix: 16)),
      colorNeutral1:
          Color(int.parse(map['colorNeutral1'].substring(1), radix: 16)),
      colorNeutral2:
          Color(int.parse(map['colorNeutral2'].substring(1), radix: 16)),
      colorNeutral3:
          Color(int.parse(map['colorNeutral3'].substring(1), radix: 16)),
      colorPrimary:
          Color(int.parse(map['colorPrimary'].substring(1), radix: 16)),
      colorSecondary:
          Color(int.parse(map['colorSecondary'].substring(1), radix: 16)),
      colorSuccess:
          Color(int.parse(map['colorSuccess'].substring(1), radix: 16)),
      logoFavicon: map['logoFavicon'],
      logoMain: map['logoMain'],
      urlCopyright: map['urlCopyright'],
      urlPrivacyPolicy: map['urlPrivacyPolicy'],
      urlTermCondition: map['urlTermCondition'],
    );
  }
}
