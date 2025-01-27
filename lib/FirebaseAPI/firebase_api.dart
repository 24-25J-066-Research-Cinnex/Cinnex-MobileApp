import 'package:cinnex_mobile/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class FirebaseApi {
  //create an instance of FirebaseMessaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final logger = Logger();
  //function to initialize notification
Future<void> initializeNotification() async {
    //request permission from the user(will prompt user)
    await _firebaseMessaging.requestPermission();
    //fetch the FCm token
    final String? token = await _firebaseMessaging.getToken();
    //print the token
    logger.d("Token: $token");

    //initialize further settings for push notification
    initPushNotification() ;

  }



  //function to listen for notification
  void listenForNotifications() {
    //listen for notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.d("Message data: ${message.data}");
      logger.d("Message notification: ${message.notification}");
    });
  }

  //function to handle received message
void handleReceivedMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    //navigate to notification screen
  navigatorKey.currentState?.pushNamed('/notification', arguments: message);
  }

  //function to handle background message
Future initPushNotification() async {
    //initialize the app
    FirebaseMessaging.instance.getInitialMessage().then(handleReceivedMessage);
    //listen for background message
    FirebaseMessaging.onMessageOpenedApp.listen(handleReceivedMessage);
  }

  //function to handle background message

}