import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx/pages/announcement/announcement_page.dart';
import 'package:olx/pages/login/login_provider.dart';
import 'package:olx/pages/login/login_page.dart';
import 'package:olx/pages/my_announcements/my_announcements_page.dart';
import 'package:olx/pages/new_announcement/new_announcement_page.dart';
import 'package:olx/pages/new_announcement/new_announcement_provider.dart';
import 'package:olx/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ThemeData themeData = ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => NewAnnouncementProvider()),
      ],
      child: MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: const AnnouncementPage(),
        initialRoute: AppRoutes.announcements,
        routes: {
          AppRoutes.announcements: (context) => const AnnouncementPage(),
          AppRoutes.login: (context) => const LoginPage(),
          AppRoutes.myAnnouncements: (context) => const MyAnnouncementsPage(),
          AppRoutes.newAnnouncement: (context) => const NewAnnouncementPage(),
        },
      ),
    ),
  );
}
