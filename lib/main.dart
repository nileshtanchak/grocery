import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:on_boarding/profile_section/Provider/profile_provider.dart';
import 'package:on_boarding/provider/auth_provider.dart';
import 'package:on_boarding/provider/cart_provider.dart';
import 'package:on_boarding/provider/category_provider.dart';
import 'package:on_boarding/provider/check_out_provider.dart';
import 'package:on_boarding/provider/dash_board_provider.dart';
import 'package:on_boarding/provider/details_screen_provider.dart';
import 'package:on_boarding/provider/favourite_provider.dart';
import 'package:on_boarding/provider/home_screen_provider.dart';
import 'package:on_boarding/provider/prodcut_provider.dart';
import 'package:on_boarding/provider/registration_provider.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';
import 'package:on_boarding/splash_screen/screen/grocery_app.dart';
import 'package:on_boarding/utils/preference_utils.dart';
import 'package:provider/provider.dart';

import 'dash_board_page/dash_board_screens/dash_board_screen.dart';

late int? initScreen;
var logger = Logger();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initScreen = await SharedPrefUtils.readPrefStr("initScreen");
  SharedPrefUtils.saveStr("initScreen", 1);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegistrationProvider>(
            create: (context) => RegistrationProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<DashBoardProvider>(
            create: (context) => DashBoardProvider()),
        ChangeNotifierProvider<DetailsScreenProvider>(
            create: (context) => DetailsScreenProvider()),
        ChangeNotifierProvider<ShoppingProvider>(
            create: (context) => ShoppingProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (context) => ProfileProvider()),
        ChangeNotifierProvider<HomeScreenProvider>(
            create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider<CheckOutProvider>(
            create: (context) => CheckOutProvider()),
        ChangeNotifierProvider<FavouriteProvider>(
            create: (context) => FavouriteProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (context) => ProductProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider()),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.green,
            primarySwatch: Colors.green,
          ),
          home:
              initScreen == null ? const GroceryApp() : const DashBoardScreen(),
        ),
      ),
    );
  }
}
