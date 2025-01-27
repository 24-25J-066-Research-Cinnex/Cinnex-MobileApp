import 'package:cinnex_mobile/FirebaseAPI/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_messaging/firebase_messaging.dart'
    show
        FirebaseMessaging,
        RemoteMessage,
        NotificationSettings,
        AuthorizationStatus;
import 'Notification/notification_screen.dart';
import 'firebase_options.dart';
import 'Dashboard/dashboard_screen.dart';
import 'Home/home_screen.dart';
import 'Home/language_selection_screen.dart';
import 'Settings/setting_screen.dart';
import 'Settings/locale_provider.dart';
import 'Storage/Screens/storage_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final logger = Logger();
  await Firebase.initializeApp();
  logger.e("Handling background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initializeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool hasNewNotification = false;
  Locale _currentLocale = const Locale('en');
  final logger = Logger();

  void _changeLanguage(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    listenForNotifications();
  }

  void requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.d("User granted permission");
    } else {
      logger.d("User declined or has not accepted permission");
    }
  }

  void listenForNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        hasNewNotification = true;
      });
      logger.d("New message: ${message.notification?.title}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinnex Mobile',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('si'),
      ],
      locale: _currentLocale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF018241),
          primary: const Color(0xFF018241),
          secondary: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins'),
          titleMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins'),
          titleSmall: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins'),
          bodyLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins'),
          bodyMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins'),
          bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontFamily: 'Poppins'),
        ),
      ),
      home: LanguageSelectionScreen(onLanguageChange: _changeLanguage),
      navigatorKey: navigatorKey,
      routes: {
        '/notification': (context) => NotificationScreen(),
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  final Locale locale;

  const MainLayout({super.key, required this.locale});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController =
        MotionTabBarController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: AppLocalizations.of(context)!.dashboard,
        labels: [
          AppLocalizations.of(context)!.dashboard,
          AppLocalizations.of(context)!.home,
          AppLocalizations.of(context)!.storage,
          AppLocalizations.of(context)!.settings,
        ],
        icons: const [
          Icons.dashboard,
          Icons.chat,
          Icons.storage,
          Icons.settings,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Theme.of(context).colorScheme.primary,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Theme.of(context).colorScheme.primary,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: const <Widget>[
          DashboardScreen(),
          HomeScreen(),
          FileStoragePage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
