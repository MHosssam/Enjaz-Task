import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:enjaz/helpers/shared_helper.dart';
import 'package:enjaz/main_blocs/auth_cubit/auth_cubit.dart';
import 'package:enjaz/main_blocs/lang_cubit/lang_cubit.dart';
import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:enjaz/navigation/routes.dart';
import 'package:enjaz/network/TokenUtil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void cPrint(dynamic data, {String? errorIn, String? event, String? label}) {
  if (kDebugMode) {
    if (errorIn != null) {
      developer.log('****************************** error ******************************');
      developer.log('[${label ?? "Error"}]', time: DateTime.now(), error: data, name: errorIn);
      developer.log('****************************** error ******************************');
    } else if (data != null) {
      developer.log(data, time: DateTime.now(), name: label ?? "Log");
    }
    if (event != null) {
      Utility.logEvent(event, parameter: {});
    }
  }
}

class Utility {
  static Future<bool> unAuthFunc() async {
    clearSavedData();
    TokenUtil.clearToken();
    CustomNavigator.navigatorState.currentContext!.read<AuthCubit>().onUpdateAuth(false);
    CustomNavigator.push(Routes.login, clean: true);
    return true;
  }

  static launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      cPrint('Could not launch $url');
    }
  }

  static void logEvent(String event, {Map<String, dynamic>? parameter}) {
    kReleaseMode ? developer.log("message") : cPrint("[EVENT]: $event");
  }

  static Locale getLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  static void changeLanguage(String lang) {
    CustomNavigator.navigatorState.currentContext?.read<LangCubit>().onUpdateLanguage(lang);
  }

  static void clearSavedData() async {
    SharedHelper().removeValue(CachingKey.isUser.value);
  }

  static void saveUserData({required dynamic data}) {
    SharedHelper().saveValue(CachingKey.profileData.value, json.encode(data));
  }

  static Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  void openMapNavigation({required double lat, required double lng}) async {
    Uri appleUrl = Uri.parse('https://maps.apple.com/?saddr=&daddr=$lat,$lng&directionsmode=driving');

    Uri androidUri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");

    if (Platform.isAndroid) {
      await launchUrl(androidUri);
    } else {
      await launchUrl(appleUrl);
    }
  }

  void launchCaller({required String phoneNumber}) {
    final Uri launchUri = Uri.parse("tel://$phoneNumber");
    launchUrl(launchUri);
  }
}
