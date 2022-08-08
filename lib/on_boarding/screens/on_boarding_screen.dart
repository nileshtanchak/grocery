import 'package:flutter/material.dart';
import 'package:on_boarding/provider/registration_provider.dart';
import 'package:provider/provider.dart';

import '../../registration_module/sign_in_sign_out_screen/signin_signout_screen.dart';
import '../../widgets/custom_page_indicator.dart';
import '../../widgets/cutom_elevated_button.dart';
import '../on_boarding_model/on_boarding_model.dart';
import '../widgets/onboarding_page_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController controller;

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
        image: "images/grocery.png",
        title: "Shop for Your Daily Needs in Your Ease",
        description:
            "Set your delivery location. Choose your grocery from a wide range of our required product"),
    OnBoardingModel(
        image: "images/delivery.png",
        title: "Real Time Reporting",
        description: "Keeping track of sales with real time notification"),
    OnBoardingModel(
        image: "images/Hero-Image.png",
        title: "Fast Doorstep Deliveries",
        description:
            "Our delivery executive will deliver your order in under 24 hours"),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Consumer<RegistrationProvider>(
                builder: (_, indexProvider, child) {
                  return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    onPageChanged: (value) {
                      indexProvider.getIndex(value);
                    },
                    itemCount: onBoardingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OnBoardingPageView(
                          onBoardingList: onBoardingList[index]);
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomPageIndicator(
              controller: controller,
              activeDotColor: Colors.green,
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: CustomElevatedButton(
                onPress: () {
                  if (Provider.of<RegistrationProvider>(context, listen: false)
                          .currentUser ==
                      onBoardingList.length - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInAndSignOutPage(),
                      ),
                    );
                  }
                  controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceOut);
                },
                buttonName:
                    Provider.of<RegistrationProvider>(context, listen: false)
                                .currentUser ==
                            onBoardingList.length - 1
                        ? "Get Started"
                        : "Next",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
