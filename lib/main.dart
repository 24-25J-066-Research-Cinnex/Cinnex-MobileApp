import 'package:cinnex_mobile/Dashboard/dashboard_screen.dart';
import 'package:cinnex_mobile/Home/home_screen.dart';
import 'package:cinnex_mobile/Home/language_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:cinnex_mobile/Settings/locale_provider.dart';
import 'Settings/setting_screen.dart';
import 'Storage/Screens/storage_screen.dart';


void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default locale is English
  Locale _currentLocale = const Locale('en');

  void _changeLanguage(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      title: 'Cinnex Mobile',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), //English
        Locale('si'), //Sinhala
      ],
      //locale: provider.locale,
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
            fontFamily: 'Poppins',
          ),
          titleMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
          titleSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
          bodyLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
          bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
          headlineMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
          headlineSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),

        ),
      ),
      //home: MainLayout(),
      //home: LanguageSelectionScreen(onLanguageChange: onLanguageChange)
      home: LanguageSelectionScreen(
        onLanguageChange: (Locale locale) {
          _changeLanguage(locale); // Update the selected language
        },
      ),
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
  //Locale _currentLocale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: AppLocalizations.of(context)!.home,
        useSafeArea: true,
        labels: [
          AppLocalizations.of(context)!.home,
          AppLocalizations.of(context)!.dashboard,
          AppLocalizations.of(context)!.storage,
          AppLocalizations.of(context)!.settings,
        ],
        icons: const [
          Icons.home,
          Icons.dashboard,
          Icons.storage,
          Icons.settings
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

      // Body Content
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          HomeScreen(), // Home tab
          DashboardScreen(), // Dashboard tab
          FileStoragePage(), // Profile tab
          SettingsPage(),
        ],
      ),
    );
  }
}

class MainPageContentComponent extends StatelessWidget {
  const MainPageContentComponent({
    required this.title,
    required this.controller,
    super.key,
  });

  final String title;
  final MotionTabBarController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
