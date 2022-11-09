import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:service_bee/models/api/QuotResponse.dart';
import 'package:service_bee/models/api/category_response.dart';
import 'package:service_bee/models/api/service_response.dart';
import 'package:service_bee/models/api/sub_category_response.dart';
import 'package:service_bee/models/city_to_city.dart';
import 'package:service_bee/models/transactions.dart';
import 'package:service_bee/storage/storage.dart';
import 'package:uuid/uuid.dart';

import '../models/api/GenerateTokenResponse.dart';
import '../models/api/VideoAdResponse.dart';
import '../models/api/banner_response.dart';
import '../models/api/common_recharge_response.dart';
import '../models/api/generic_response.dart';
import '../models/api/lead_response.dart';
import '../models/api/profile_response.dart';
import '../models/api/purchase_leads_response.dart';
import '../models/api/review_response.dart';
import '../models/api/verify_otp_response.dart';
import '../models/check_profile.dart';
import '../models/notification.dart';
import '../models/selected_services_response.dart';

class ApiProvider {
  ApiProvider._();

  static final ApiProvider instance = ApiProvider._();

  String baseUrl = "growgraphics.xyz";
  String path = "/service-bee/public/api";

  Future<GenericResponse> sendOtp(String mobile) async {
    var data = {
      "number": mobile,
    };
    var url = Uri.https(baseUrl, "$path/vendor/user_otp");
    print(url);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
      });
      print("send otp response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> sendQuote(price, query_id, message) async {
    var data = {"price": price, "query_id": query_id, "message": message};
    var url = Uri.https(baseUrl, "$path/vendor/send_quot");
    print(url);
    print(data);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("sendQuote response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> sendPurchaseLeads(query_id) async {
    var data = {
      "query_id": query_id,
    };
    var url = Uri.https(baseUrl, "$path/vendor/purchase_leads");
    print(url);
    print(data);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("sendPurchaseLeads response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> verifyLeads(query_id, pin) async {
    var data = {
      "query_id": query_id,
      "pin": pin,
    };
    var url = Uri.https(baseUrl, "$path/vendor/verify_lead");
    print(url);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("verify leads response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<CheckProfile> checkProfile() async {
    var data = {
      "token": Storage.instance.token,
    };
    var url = Uri.https(baseUrl, "$path/vendor/profile_check");
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
      });
      print(url);
      print(data);
      print("checkProfile response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CheckProfile.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return CheckProfile.withError();
      }
    } catch (error) {
      return CheckProfile.withError();
    }
  }

  Future<SelectedServicesResponse> getServices() async {
    var url = Uri.https(baseUrl, "$path/vendor/get_profile_services");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getServices response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SelectedServicesResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return SelectedServicesResponse.withError(
            jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return SelectedServicesResponse.withError(error.toString());
    }
  }

  Future<BannerResponse> getBanner() async {
    var url = Uri.https(baseUrl, "$path/vendor/banner_list");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print(url);
      print("getbanner response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return BannerResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return BannerResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return BannerResponse.withError(error.toString());
    }
  }

  Future<BannerResponse> getTextBanner() async {
    var url = Uri.https(baseUrl, "$path/vendor/textbanner_list");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print(url);
      print("getbanner response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return BannerResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return BannerResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return BannerResponse.withError(error.toString());
    }
  }

  Future<CommonRechargeResponse> getCommonRecharge() async {
    var url = Uri.https(baseUrl, "$path/vendor/common_recharge_amount");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getCommonRecharge response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CommonRechargeResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return CommonRechargeResponse.withError(
            jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return CommonRechargeResponse.withError(error.toString());
    }
  }

  Future<GenerateTokenResponse> getToken(amount) async {
    var url = Uri.https(baseUrl, "$path/vendor/generateToken");
    var data = {
      'amount': amount,
    };
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getToken response payment : ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenerateTokenResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenerateTokenResponse.withError(
            jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return GenerateTokenResponse.withError(error.toString());
    }
  }

  Future<GenerateTokenResponse> isDocumentVerified() async {
    var url = Uri.https(baseUrl, "$path/vendor/is_document_verified");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("is_document_verified response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenerateTokenResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenerateTokenResponse.withError(
            jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return GenerateTokenResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> delete_account_request() async {
    var url = Uri.https(baseUrl, "$path/vendor/delete_account_request");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("delete_account_request response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<ReviewResponse> getReviews() async {
    var url = Uri.https(baseUrl, "$path/vendor/get_review_vendor");
    print(url);
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getReivew response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ReviewResponse.withJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return ReviewResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return ReviewResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> completePayment(
      rzp_paymentid, rzp_orderid, rzp_signature) async {
    var data = {
      "rzp_paymentid": rzp_paymentid,
      "rzp_orderid": rzp_orderid,
      "rzp_signature": rzp_signature,
    };
    var url = Uri.https(baseUrl, "$path/vendor/complete_wallet_pay");
    print(url);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("complete_wallet_pay response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<VideoAdResponse> getVideoads() async {
    var url = Uri.https(baseUrl, "$path/vendor/video_link");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getbanner response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return VideoAdResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return VideoAdResponse.withError("Something went wrong");
      }
    } catch (error) {
      return VideoAdResponse.withError(error.toString());
    }
  }

  Future<LeadResponse> getLeads() async {
    var url = Uri.https(baseUrl, "$path/vendor/get_leads");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getLeads response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LeadResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return LeadResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return LeadResponse.withError(error.toString());
    }
  }

  Future<NotificationResponse> getNotifications(page) async {
    var data = {'page': page.toString()};
    var url = Uri.https(baseUrl, "$path/vendor/notifications", data);

    print(url);
     print('${Storage.instance.token}');
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getNotifications response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NotificationResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return NotificationResponse.withError(
            jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return NotificationResponse.withError(error.toString());
    }
  }

  Future<TransactionsResponse> getTransactions(page) async {
    var data = {'page': page.toString()};
    var url = Uri.https(baseUrl, "$path/vendor/get_transaction_list", data);

    print(url);
     print('${Storage.instance.token}');
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("gettrans response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('done');
        return TransactionsResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return TransactionsResponse.withError(
            jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return TransactionsResponse.withError(error.toString());
    }
  }

  Future<PurchaseLeadsResponse> getPurchaseLeads() async {
    var url = Uri.https(baseUrl, "$path/vendor/leads_purchased_list");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getPurchaseLeads response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PurchaseLeadsResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return PurchaseLeadsResponse.withError("Something went wrong");
      }
    } catch (error) {
      return PurchaseLeadsResponse.withError(error.toString());
    }
  }

  Future<QuotResponse> getQuot() async {
    var url = Uri.https(baseUrl, "$path/vendor/quot_list");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("getQuot response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return QuotResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        print("getQuot ${response.statusCode}");
        return QuotResponse.withError("Something went wrong");
      }
    } catch (error) {
      print("getQuot ${error}");
      return QuotResponse.withError(error.toString());
    }
  }

  Future<VerifyOtpResponse> verifyOtp(
      String mobile, String otp, String fcmtoken) async {
    var data = {"phone": mobile, "otp": otp, "fcm_token": fcmtoken};
    var url = Uri.https(baseUrl, "$path/vendor/user_otpverified");
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
      });
      print("verify otp response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return VerifyOtpResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return VerifyOtpResponse.withError(
            res.message ?? "Something went wrong");
      }
    } catch (error) {
      return VerifyOtpResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> addProfile(
      name,
      profile_pic,
      adhaarcard_front,
      adhaarcard_back,
      votercard_front,
      votercard_back,
      lic_front,
      lic_back,
      passport_front,
      passport_back,
      services) async {
    var url = Uri.https(baseUrl, "$path/vendor/add_profile_new");
    final imageUpload = http.MultipartRequest('POST', url);
    print(url);
    final mimedatatype =
        lookupMimeType(profile_pic, headerBytes: [0xFF, 0xD8])?.split('/');
    http.MultipartFile file = await http.MultipartFile.fromPath(
        'profile_pic', profile_pic,
        filename: 'profile_pic',
        contentType: MediaType(mimedatatype![0], mimedatatype[1]));
    imageUpload.files.add(file);
    print('1');
    final mimedatatype1 =
        lookupMimeType(adhaarcard_front, headerBytes: [0xFF, 0xD8])?.split('/');
    http.MultipartFile file1 = await http.MultipartFile.fromPath(
        'adhaarcard_front', adhaarcard_front,
        filename: 'adhaarcard_front',
        contentType: MediaType(mimedatatype1![0], mimedatatype1[1]));
    imageUpload.files.add(file1);
    print('2');
    final mimedatatype2 =
        lookupMimeType(adhaarcard_back, headerBytes: [0xFF, 0xD8])?.split('/');
    http.MultipartFile file2 = await http.MultipartFile.fromPath(
        'adhaarcard_back', adhaarcard_back,
        filename: 'adhaarcard_back',
        contentType: MediaType(mimedatatype2![0], mimedatatype2[1]));
    imageUpload.files.add(file2);
    print('3');
    if (votercard_front != '' && votercard_back != '') {
      final mimedatatype3 =
          lookupMimeType(votercard_front, headerBytes: [0xFF, 0xD8])
              ?.split('/');
      http.MultipartFile file3 = await http.MultipartFile.fromPath(
          'votercard_front', votercard_front,
          filename: 'votercard_front',
          contentType: MediaType(mimedatatype3![0], mimedatatype3[1]));
      imageUpload.files.add(file3);
      print('4');
      final mimedatatype4 =
          lookupMimeType(votercard_back, headerBytes: [0xFF, 0xD8])?.split('/');
      http.MultipartFile file4 = await http.MultipartFile.fromPath(
          'votercard_back', votercard_back,
          filename: 'votercard_back',
          contentType: MediaType(mimedatatype4![0], mimedatatype4[1]));
      imageUpload.files.add(file4);
    } else if (votercard_front == '' &&
        votercard_back == '' &&
        lic_front != '' &&
        lic_back != '') {
      print('5');

      final mimedatatype6 =
          lookupMimeType(lic_front, headerBytes: [0xFF, 0xD8])?.split('/');
      http.MultipartFile file6 = await http.MultipartFile.fromPath(
          'lic_front', lic_front,
          filename: 'lic_front',
          contentType: MediaType(mimedatatype6![0], mimedatatype6[1]));
      imageUpload.files.add(file6);
      final mimedatatype7 =
          lookupMimeType(lic_back, headerBytes: [0xFF, 0xD8])?.split('/');
      http.MultipartFile file7 = await http.MultipartFile.fromPath(
          'lic_back', lic_back,
          filename: 'lic_back',
          contentType: MediaType(mimedatatype7![0], mimedatatype7[1]));
      imageUpload.files.add(file7);
    } else {
      print('6');

      final mimedatatype8 =
          lookupMimeType(passport_front, headerBytes: [0xFF, 0xD8])?.split('/');
      http.MultipartFile file8 = await http.MultipartFile.fromPath(
          'passport_front', passport_front,
          filename: 'passport_front',
          contentType: MediaType(mimedatatype8![0], mimedatatype8[1]));
      imageUpload.files.add(file8);
      final mimedatatype9 =
          lookupMimeType(passport_back, headerBytes: [0xFF, 0xD8])?.split('/');
      http.MultipartFile file9 = await http.MultipartFile.fromPath(
          'passport_back', passport_back,
          filename: 'passport_back',
          contentType: MediaType(mimedatatype9![0], mimedatatype9[1]));
      imageUpload.files.add(file9);
    }

    //print(json.encode(services));
    print(name);
    imageUpload.fields['name'] = name;
    imageUpload.fields['services'] = json.encode(services);
    imageUpload.headers['Authorization'] = 'Bearer ${Storage.instance.token}';
    imageUpload.headers['APP-KEY'] = 'jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE';
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    try {
      final streamResp = await imageUpload.send();
      print(streamResp);
      final response = await http.Response.fromStream(streamResp);
      print(response.statusCode);
      print(response.body);
      // print(imageUpload.fields);
      // print(imageUpload.headers);
      // print(imageUpload.files);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("789789${responseData.values}");
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        print("145${response.statusCode} ${response.body}");
        return GenericResponse.withError('Something went wrong');
      }
    } catch (e) {
      print('add ${e}');
      return GenericResponse.withError('Something went wrong');
    }
  }

  Future<GenericResponse> editProfile(
      name,
      profile_pic,
      adhaarcard_front,
      adhaarcard_back,
      votercard_front,
      votercard_back,
      lic_front,
      lic_back,
      services) async {
    var url = Uri.https(baseUrl, "$path/vendor/update_profile_new");
    final imageUpload = http.MultipartRequest('POST', url);
    print(url);
    try {
      final mimedatatype =
          lookupMimeType(profile_pic, headerBytes: [0xFF, 0xD8])?.split('/');
      http.MultipartFile file = await http.MultipartFile.fromPath(
          'profile_pic', profile_pic,
          filename: 'profile_pic',
          contentType: MediaType(mimedatatype![0], mimedatatype[1]));
      imageUpload.files.add(file);
    } catch (e) {
      print(e);
      // imageUpload.fields['profile_pic'] = profile_pic;
    }
    print('1');
    try {
      final mimedatatype1 =
          lookupMimeType(adhaarcard_front, headerBytes: [0xFF, 0xD8])
              ?.split('/');
      http.MultipartFile file1 = await http.MultipartFile.fromPath(
          'adhaarcard_front', adhaarcard_front,
          filename: 'adhaarcard_front',
          contentType: MediaType(mimedatatype1![0], mimedatatype1[1]));
      imageUpload.files.add(file1);
    } catch (e) {
      print(e);
      // imageUpload.fields['profile_pic'] = profile_pic;
    }
    print('2');
    try {
      final mimedatatype2 =
          lookupMimeType(adhaarcard_back, headerBytes: [0xFF, 0xD8])
              ?.split('/');
      http.MultipartFile file2 = await http.MultipartFile.fromPath(
          'adhaarcard_back', adhaarcard_back,
          filename: 'adhaarcard_back',
          contentType: MediaType(mimedatatype2![0], mimedatatype2[1]));
      imageUpload.files.add(file2);
    } catch (e) {
      print(e);
    }
    print('3');
    if (votercard_front != '' && votercard_back != '') {
      final mimedatatype3 =
          lookupMimeType(votercard_front, headerBytes: [0xFF, 0xD8])
              ?.split('/');
      try {
        http.MultipartFile file3 = await http.MultipartFile.fromPath(
            'votercard_front', votercard_front,
            filename: 'votercard_front',
            contentType: MediaType(mimedatatype3![0], mimedatatype3[1]));
        imageUpload.files.add(file3);
      } catch (e) {
        print(e);
      }
      print('4');
      try {
        final mimedatatype4 =
            lookupMimeType(votercard_back, headerBytes: [0xFF, 0xD8])
                ?.split('/');
        http.MultipartFile file4 = await http.MultipartFile.fromPath(
            'votercard_back', votercard_back,
            filename: 'votercard_back',
            contentType: MediaType(mimedatatype4![0], mimedatatype4[1]));
        imageUpload.files.add(file4);
      } catch (e) {
        print(e);
      }
    } else {
      print('5');

      try {
        final mimedatatype6 =
            lookupMimeType(lic_front, headerBytes: [0xFF, 0xD8])?.split('/');
        http.MultipartFile file6 = await http.MultipartFile.fromPath(
            'lic_front', lic_front,
            filename: 'lic_front',
            contentType: MediaType(mimedatatype6![0], mimedatatype6[1]));
        imageUpload.files.add(file6);
      } catch (e) {
        print(e);
      }
      try {
        final mimedatatype7 =
            lookupMimeType(lic_back, headerBytes: [0xFF, 0xD8])?.split('/');
        http.MultipartFile file7 = await http.MultipartFile.fromPath(
            'lic_back', lic_back,
            filename: 'lic_back',
            contentType: MediaType(mimedatatype7![0], mimedatatype7[1]));
        imageUpload.files.add(file7);
      } catch (e) {
        print(e);
      }
    }

    print(json.encode(services));

    imageUpload.fields['name'] = name;
    imageUpload.fields['services'] = json.encode(services);
    imageUpload.headers['Authorization'] = 'Bearer ${Storage.instance.token}';
    imageUpload.headers['APP-KEY'] = 'jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE';
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    print(imageUpload.fields);
    print(imageUpload.headers);
    // print(imageUpload.files[0].length);
    // print(imageUpload.files[1].length);
    try {
      final streamResp = await imageUpload.send();
      print(streamResp);
      final response = await http.Response.fromStream(streamResp);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${responseData.values}");
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        print("${response.statusCode} ${response.body}");
        return GenericResponse.withError('Something went wrong');
      }
    } catch (e) {
      print('add ${e}');
      return GenericResponse.withError('Something went wrong');
    }
  }

  Future<CategoryResponse> fetchCategories() async {
    var url = Uri.https(baseUrl, "$path/vendor/show_category");
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("category response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CategoryResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return CategoryResponse.withError(
            res.message ?? "Something went wrong");
      }
    } catch (error) {
      return CategoryResponse.withError(error.toString());
    }
  }

  Future<SubCategoryResponse> fetchSubCategories(int id) async {
    var url = Uri.https(baseUrl, "$path/vendor/show_subcategory");
    var data = {"category_id": id};
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("sub category response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SubCategoryResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return SubCategoryResponse.withError(
            res.message ?? "Something went wrong");
      }
    } catch (error) {
      return SubCategoryResponse.withError(error.toString());
    }
  }

  Future<ServiceResponse> fetchServices(int id) async {
    var url = Uri.https(baseUrl, "$path/vendor/show_sub_to_subcategory");
    var data = {"subcategory_id": id};
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("sub category response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ServiceResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return ServiceResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return ServiceResponse.withError(error.toString());
    }
  }

  Future<ProfileResponse> fetchProfile() async {
    var url = Uri.https(baseUrl, "$path/vendor/get_profile");
    // var data = {"subcategory_id": id};
    try {
      http.Response response = await http.get(url, headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print(url);
      print(Storage.instance.token);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //      jsonDecode(response.body)['data'];
        // Storage.instance.setcity(
        //     jsonDecode(response.body)['data'][0]['serviceable_city_pairs']);

        print("fetch profile response: ${response.body}");
        return ProfileResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        print("fetch prof error ${response.statusCode}");
        return ProfileResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      print("fetch prof error ${error}");
      return ProfileResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> sendHelpSupport(name, email, phone, message) async {
    var data = {
      "name": name,
      "email": email,
      "phone": phone,
      "message": message
    };
    var url = Uri.https(baseUrl, "$path/vendor/help_support");
    print(url);
    print(data);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("sendQuote response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> deactivate(
      reason, accountname, accountnumber, ifsccode, address) async {
    var data = {
      "reason": reason,
      "account_name": accountname,
      "account_number": accountnumber,
      "ifsc_code": ifsccode,
      "address": address
    };
    var url = Uri.https(baseUrl, "$path/vendor/delete_account_request");
    print(url);
    print(data);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("deactivate response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }

  Future<GenericResponse> notificationsetting(
      notification_start_time, notification_end_time) async {
    var data = {
      "notification_start_time": notification_start_time,
      "notification_end_time": notification_end_time,
    };
    var url = Uri.https(baseUrl, "$path/update_notification_time");
    print(url);
    print(data);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "APP-KEY": "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Storage.instance.token}"
      });
      print("update notification response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GenericResponse.fromJson(jsonDecode(response.body));
      } else {
        final res = GenericResponse.fromJson(jsonDecode(response.body));
        return GenericResponse.withError(res.message ?? "Something went wrong");
      }
    } catch (error) {
      return GenericResponse.withError(error.toString());
    }
  }
}
