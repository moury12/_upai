import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart' ;


class NotificationAccessToken {
  static String? _token;

  //to generate token only once for an app run
  static Future<String?> get getToken async => _token ?? await _getAccessToken();

  // to get admin bearer token
  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';
          'https://www.googleapis.com/auth/userinfo.email';
          'https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        // To get Admin Json File: Go to Firebase > Project Settings > Service Accounts
        // > Click on 'Generate new private key' Btn & Json file will be downloaded

        // Paste Your Generated Json File Content
        ServiceAccountCredentials.fromJson(
            {
              "type": "service_account",
              "project_id": "chatappprac-d7a2b",
              "private_key_id": "c8c434d1988dd356229ee554f80e6b7480cbf00e",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC62rctEOlTGwwc\nT586TVHVrYXx1gGhNP0VtArWB9IEux46HYxCozA7k4kqb5j2hw0DiV3BidrvNZHl\nIO7oD71e+Rt1RxCjq8Nbnu/6E4Z004/L4G1Ibe6wy6uHuqCPKkDduZrKG7nkYvJU\nBGjPWouikCb3m6jypI4TdEGfnHs8P5IpwlwyDVv7nRiNshDfxNkQHDfq1JeS4GpI\nE0yxW+nRURSOWY1w4J/pkmQWvttZCRx7kzZyKo/ZGcJvMChJ9GxM76MMmJslGTaa\noMp+++ndaxkjGvwZ4RXETPlHluCxUNMtjmocp33FaKqK1Boa1l34L/lMgQA3a2FT\njobOL7OzAgMBAAECggEAD1kczQuuZqr6P9m9xf+zi54rukAZCoFRkov4jI5q5ARC\nCNsEJOBw+0vJ612W+RUBxCXEjjurwJSsDbU6pSl50B3HxsaAvuOXxzmoaOhcAHz0\n5aBjHvJste1HgygYvSRm3Jo8yoIkLvbTry6yNJSxkzeiWRoE8sgCeuWZ6FQ6/n6Z\npL3hQosK/hcv68Avtjrye04YZhV+t7QxTxZXG3Ky7AOny73vGZ6yv3KLzZ5f6AYP\nd68H7KoZIfjWdqC88kVVQnEng9Psk2qdfmDIe2xTkiEHDN35J9zBUiujqZlIySDX\nbquzex85nbkzuN2QFwBeQWv/N7O6E0zDngMGM5I21QKBgQDkiSmqi0y0mamD42us\nNUbM6GrpFkECRibepUNemlI/KzicWWf3kSha/4Na9q2VB7sqjDk6VVM8ppj3iWy4\nO+2bY146LvSMQewOkAZOj9gRIEo1QtZ2aE9vRNVs6gqvQSVhmw4uJ0tYvEzBwct9\nAz4FRNIBPIKydzSaIkSNDrCFvwKBgQDRTzxNGT6GJpXnScF0A7sdXbpfmd/E1H4V\nnQLidPQbNfi2HwiL5oekU+lcEgGeqDTBv94El5C48HMflnyLaCOkKk+qflGFoCdJ\nnbQlpHycC0YJ1qDr+lFGbFXtLWp5Rm7+Wi5F06Qf6vmuBOaM0TDihuP5ZHqHl9S8\n9n7a8XtXDQKBgEI6PYjetWvg2+8MiLdu+QWIlPLXMB+olLsQyWUw84S60bz9a9Oi\njT9RrI8/zS3S/7pkyHDPKT/6R3n0qTz6oPDW6weRc+zxbacKtckuhj7wTJECvYOy\n1tI38GGPsWj4SAzxEjrtyDf+2X+M2ZtwxRhhyTnyfy2YvfWs2JDIIP+hAoGBAIkI\nEPiA4Hg/ZsCnfumPT79oD45rVR6t52YLB0pvOyldalkBdDzzTjZ9YTgP6dOPWArI\nrHfhKrSJZzV09lDmev8NXF7ImGKdeVsuzjQevh4DG3VxeKVFmlQ6tP60TxLa0+vd\n6pF4f+kNky0ktDPY+OI1Yady6u0+r96OmnqIwjE5AoGBAIaXmauQJdxY9WlXETna\nlglEwgRtmkrNdvnmbLG5ST06xENeTRq9DOZFlstFuqWgXQSlLhewKSwCa54ec1mD\nnL44X3E5n1dl6kf73s58ULDHyUIDK7uvyAiz2ywOs2lqBNqix1QJN4vJGZ32otGd\nfFa2Jrs8Zchn2W5gSxorK4rs\n-----END PRIVATE KEY-----\n",
              "client_email": "md-jahidul-islam-maruf@chatappprac-d7a2b.iam.gserviceaccount.com",
              "client_id": "108869501680775939751",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/md-jahidul-islam-maruf%40chatappprac-d7a2b.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }

        ),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
