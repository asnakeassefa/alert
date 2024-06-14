import 'utils/find_distance.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'loadingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling aflutter background message: ${message.messageId}");
  debugPrint('Background Message data: ${message.data}');
  debugPrint('Message data id: ${message.data['id']}');
  String dist = await findDistance(message.data['location']);
  // Handle the alert message here, for example, by sending it to the UI or performing other actions
  debugPrint("New alert received: $dist");
  if (message.notification != null) {
    debugPrint('Message also contained a notification: ${message.notification}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');
    debugPrint(message.data['id']);
    String? dist = await findDistance(message.data['location']);
    // Handle the alert message here, for example, by sending it to the UI or performing other actions
    debugPrint("New alert received: $dist");
    if (message.notification != null) {
      debugPrint('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AlertMe',
        theme: ThemeData(
          dividerColor: Colors.transparent,
          brightness: Brightness.light,
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: LoadingPage(),
        ));
  }
}
