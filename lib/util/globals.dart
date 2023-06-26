
import 'package:cloudinary/cloudinary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunza/data/requests.dart';

mixin Glob {
  final String baseUrl = 'https://tunza.mybackend.studio';

  //Auth
  final String signIn = '/auth/login';
  final String signUp = '/auth/register';

  //User
  final String user = '/users/me';

  //Covers
  final String covers = '/covers';

  //Subscriptions
  final String subscriptions = '/subscriptions';

  //Media
  final String media = '/media';

  //Claims
  final String claims = '/claims';

  final cloudinary = Cloudinary.signedConfig(
    apiKey: "327631884356837",
    apiSecret: "tc_pUJjCWaIM436Pt8UK1_bRNHY",
    cloudName: "dbfxz33ni",
  );

  var prefs = Resources().prefs;
  var userDetail = Resources().userDetail;

  void reset() {
    prefs = null;
    userDetail = Resources().userDetail;
  }
}

class Resources {
  // SIngleton
  static final Resources _resources = Resources._internal();

  factory Resources() {
    return _resources;
  }

  Resources._internal();

  SharedPreferences? prefs;
  Map<String, dynamic> userDetail = {};

  Future<void> init() async {
    try {
      prefs = await SharedPreferences.getInstance();
      userDetail = await Requests().getUser() ?? {};
      await Requests().updateUserLocation(null);
    } catch (e) {
      print(e);
    }
  }
}

extension DateTimeExt on DateTime {
  String get yyyyMMdd => '$year-$month-$day';
}
