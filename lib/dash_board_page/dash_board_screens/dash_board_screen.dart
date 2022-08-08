import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_boarding/favourite/database/favourite_database.dart';
import 'package:on_boarding/home_page/screens/home_screen.dart';
import 'package:on_boarding/main.dart';
import 'package:on_boarding/provider/dash_board_provider.dart';
import 'package:on_boarding/widgets/keep_alive_page.dart';
import 'package:provider/provider.dart';

import '../../favourite/screen/favourite.dart';
import '../../home_page/screens/categories_screen.dart';
import '../../model/category.dart';
import '../../model/product.dart';
import '../../profile_section/profile_section_screens/profile_bottom_bar_page.dart';
import '../../services/databaseService.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late PageController pageController;
  Future<List<Category>>? futureCategoryList;
  DatabaseService service = DatabaseService();
  FavouriteDatabase favouriteService = FavouriteDatabase();
  Future<List<Product>>? futureProductList;
  Future<List<Product>>? futureFavouriteList;
  List<Product> favouriteList = [];

  @override
  void initState() {
    getToken();
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
    getQuery();
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    logger.d("token is:  $token");
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Future<void> getQuery() async {
    futureCategoryList = service.getCategory();
    futureProductList = service.getProduct();
  }

  List<Widget> widgetList = [
    const KeepAlivePage(child: HomeScreen()),
    const KeepAlivePage(
      child: CategoriesScreen(),
    ),
    const KeepAlivePage(
      child: Favourite(),
    ),
    const ProfileBottomBarPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Bottom NavigationBar
      bottomNavigationBar: Consumer<DashBoardProvider>(
        builder: (_, provider, __) {
          return BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black45,
            showUnselectedLabels: true,
            currentIndex: provider.selectedIndex,
            onTap: (index) {
              provider.onSelectedIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "categories",
                icon: Icon(Icons.category_outlined),
              ),
              BottomNavigationBarItem(
                label: "favorites",
                icon: Icon(Icons.favorite_border_rounded),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(FontAwesomeIcons.user),
              ),
            ],
          );
        },
      ),

      /// safeArea start
      body: SafeArea(
        child: widgetList
            .elementAt(Provider.of<DashBoardProvider>(context).selectedIndex),
      ),
    );
  }
}
