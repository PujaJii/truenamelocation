import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/resend_otp.dart';
import '../models/verify_model.dart';
import '../models/otp_model.dart';


class OTPApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');


  static Future<OtpModel> getOTP(String mobile) async {

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}register'));
    request.body = json.encode({
      "mobile": mobile
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return otpModelFromJson(jsoString);
    } else {
      return otpModelFromJson(response.reasonPhrase!);
    }
  }

  static Future<VerifyOtpModel> verifyOTP(String mobile, String otp) async {
    // var baseUrl = GlobalConfiguration().get('base_url');
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}verifyOtp'));
    request.body = json.encode({
      'mobile': mobile,
      'otp': otp
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return verifyOtpModelFromJson(jsoString);
    } else {
      return verifyOtpModelFromJson(response.reasonPhrase!);
    }
  }

  static Future<ResendOtpModel> resendOTP(String mobile) async {
    // var baseUrl = GlobalConfiguration().get('base_url');
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}resendOtp'));
    request.body = json.encode({
      'mobile': mobile,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return resendOtpModelFromJson(jsoString);
    } else {
      return resendOtpModelFromJson(response.reasonPhrase!);
    }
  }

}