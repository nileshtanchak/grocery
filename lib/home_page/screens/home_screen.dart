import 'package:flutter/material.dart';
import 'package:on_boarding/constant/constant.dart';
import 'package:on_boarding/dash_board_page/model/offer_model.dart';
import 'package:on_boarding/home_page/screens/categories_screen.dart';
import 'package:on_boarding/profile_section/Provider/profile_provider.dart';
import 'package:on_boarding/provider/category_provider.dart';
import 'package:on_boarding/provider/home_screen_provider.dart';
import 'package:on_boarding/services/databaseService.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';
import 'package:on_boarding/shopping_cart/screens/shopping_cart_page.dart';
import 'package:on_boarding/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../dash_board_page/widgets/custom_categories_stream_view_builder.dart';
import '../../dash_board_page/widgets/dash_board_page_view.dart';
import '../../dash_board_page/widgets/see_all_header_row.dart';
import '../widgets/category_wise_stream_view_builder.dart';
import '../widgets/top_selling_list_stream_view_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  late PageController pageController;
  DatabaseService service = DatabaseService();

  List<OfferModel> offerList = [
    OfferModel(
        image:
            "http://st2.depositphotos.com/1177973/8430/i/450/depositphotos_84305570-Heap-of-fresh-fruits-and-vegetables-in-basket-on-table-outdoors.jpg",
        title: "FRESH VEGETABLES",
        description: "Get up to 50% off"),
    OfferModel(
        image:
            "https://i.pinimg.com/600x315/00/02/73/000273215edf92b43dce81039da97cf4.jpg",
        title: "FRESH FRUITS",
        description: "Get up to 50% off"),
    OfferModel(
        image:
            "https://www.crushpixel.com/big-static18/preview4/healthy-food-variety-ripe-fruits-2881999.jpg",
        title: "FRESH VARIETIES",
        description: "Get up to 50% off"),
  ];

  @override
  void initState() {
    searchController = TextEditingController();
    pageController = PageController();
    context.read<ShoppingProvider>().cartQuery();
    context.read<ProfileProvider>().fetchProfileDetailsOfLoggedInUser();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProfileProvider>(context);
    final provider = Provider.of<ShoppingProvider>(context);

    return Scaffold(
      /// Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.white12,
        titleSpacing: 25,
        elevation: 0,
        leading: Transform.translate(
          offset: const Offset(16, 0),
          child: const CircleAvatar(
            child: Icon(
              Icons.account_circle,
              size: 56,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: Constant.kOnBoardSubtitleTextStyle,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.profileList.length,
              itemBuilder: (_, index) {
                return Text(
                  data.profileList[index].name,
                  style: Constant.kOnBoardHeaderTextStyle
                      .copyWith(color: Colors.black),
                );
              },
            ),
          ],
        ),
        actions: [
          Transform.translate(
            offset: const Offset(-30, 0),
            child: Icon(
              Icons.notifications,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Transform.translate(
            offset: const Offset(-16, 0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingCartPage(),
                  ),
                );
              },
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 6,
                      child: Text(
                        provider.cartList.length.toString(),
                        style: const TextStyle(fontSize: 7),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),

      /// SafeArea
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Product Search Text Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: CustomTextField(
                  filled: true,
                  filledColor: Colors.green.shade50,
                  hintText: "search products",
                  priIcons: Icons.search,
                  onPress: () {},
                  onChange: (value) {
                    Provider.of<HomeScreenProvider>(context).onChange(value);
                  },
                  obscureText: false,
                  controller: searchController,
                  border: InputBorder.none,
                  priIconColor: Colors.black,
                ),
              ),

              /// See All Header
              SeeAllHeaderRow(
                header: "Categories",
                description: "See All",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
              ),

              /// Categories Item List Stream View Builder
              const CustomCategoriesStreamViewBuilder(),

              /// Page View Builder Image
              SizedBox(
                height: 150,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: offerList.length,
                  itemBuilder: (context, index) {
                    return DashBoardPageView(
                        image: offerList[index].image,
                        title: offerList[index].title,
                        description: offerList[index].description,
                        controller: pageController);
                  },
                ),
              ),

              /// See All Header
              const SeeAllHeaderRow(
                  header: "Top Selling", description: "See All"),

              /// Top Selling Item List Stream View Builder
              const TopSellingListStreamViewBuilder(),

              /// See All Header
              /// Fruits List Stream Builder
              Consumer<CategoryProvider>(
                builder: (_, provider, __) {
                  if (provider.categoryList.isNotEmpty) {
                    for (int i = 0; i < provider.categoryList.length; i++) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.categoryList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SeeAllHeaderRow(
                                  header: provider.categoryList[index].name
                                      .toString(),
                                  description: "See All"),
                              CategoryWiseStreamViewBuilder(
                                uID: provider.categoryList[index].id.toString(),
                              )
                            ],
                          );
                        },
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
