import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MultiQuery {
  String registerAccount = r'''
     mutation Register($fullName: String, $password: String, $email: String) {
      register(full_name: $fullName, password: $password, email: $email) {
        error
        user {
          email {
            email_str
            is_verified
          }
          full_name
          password
          _id
          phone_number {
            phone_number_str
            is_verified
          }
        }
      }
    }
 ''';

  String login = r'''
    mutation Login($email: String, $password: String) {
      login(email: $email, password: $password) {
        token
        user {
          email {
            email_str
            is_verified
          }
          full_name
        }
        error
        message
      }
    }
  ''';

  String deviceInfo = r'''
    mutation DeviceInfo($token: String, $imei: String, $modelName: String, $brand: String, $macAddress: String, $ipAddress: String, $manufacturer: String, $androidId: String, $iosId: String, $latitude: String, $longitude: String) {
      deviceInfo(token: $token, imei: $imei, model_name: $modelName, brand: $brand, mac_address: $macAddress, ip_address: $ipAddress, manufacturer: $manufacturer, android_id: $androidId, ios_id: $iosId, latitude: $latitude, longitude: $longitude) {
        message
        error
      }
    }
''';

  String forgotPassword = r'''
  mutation ForgotPassword($email: String) {
    forgotPassword(email: $email) {
      message
      error
    }
  }
''';

  String sendPin = r'''
  mutation SendPin($email: String) {
    sendPin(email: $email) {
      message
      error
    }
  }
''';

  String verifikasiPin = r'''
  mutation VerifikasiPin($email: String, $pin: String) {
    verifikasiPin(email: $email, pin: $pin) {
      message
      error
    }
  }
''';

  String logout = r'''
  mutation Logout($token: String, $ipAddress: String, $modelName: String) {
    logout(token: $token, ip_address: $ipAddress, model_name: $modelName) {
      message
      error
    }
  }
''';

  String updateProfile = r'''
  mutation UpdateProfile($token: String, $email: String, $phoneNumber: String, $name: String, $profilePicture: String) {
    updateProfile(token: $token, email: $email, phoneNumber: $phoneNumber, name: $name, profile_picture: $profilePicture) {
      message
      error
    }
  }
''';

  String getName = r'''
  mutation KeepLogin($token: String) {
    keepLogin(token: $token) {
      token
      user {
        full_name
      }
    }
  }
''';

  String getDeviceConnnected = r'''
  mutation KeepLogin($token: String) {
    keepLogin(token: $token) {
      token
      user {
        email {
          email_str
        }
        phone_number {
          phone_number_str
        }
        devices {
          model_name
          manufacturer
          brand
          last_login
        }
      }
      error
      message
    }
  }
''';

  // http://10.0.2.2:4001/
  // https://fansnya.com/graphql/
  static HttpLink httpLink =
      HttpLink("https://fansnya.com/graphql/.", defaultHeaders: {
    "content-type": "application/json",
  });

  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore())));
}
