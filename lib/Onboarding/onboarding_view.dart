import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinnex_mobile/Onboarding/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Shared/Widget/custom_button.dart';
import '../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingView extends StatefulWidget {
  final dynamic locale;

  const OnboardingView({super.key, required this.locale});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late OnboardingItems controller;
  final pageController = PageController();
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    controller = OnboardingItems(context); // Pass context to OnboardingItems
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      bottomSheet: Container(
        color: colorScheme.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    child: Text(
                      AppLocalizations.of(context)!.skip,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: colorScheme.primary),
                    ),
                  ),

                  // Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: WormEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      activeDotColor: colorScheme.primary,
                    ),
                  ),

                  // Next Button
                  TextButton(
                    onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: colorScheme.primary),
                    ),
                  ),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item.image,
                ),
                const SizedBox(height: 5),
                item.title,
                const SizedBox(height: 5),
                item.descriptions,
              ],
            );
          },
        ),
      ),
    );
  }

  // Get Started button
  Widget getStarted() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colorScheme.secondary,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: CustomButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("onboarding", true);

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainLayout(locale: widget.locale)),
          );
        },
        text: AppLocalizations.of(context)!.get_started,
      ),
    );
  }
}
