import 'onboarding_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingItems {
  BuildContext context;

  OnboardingItems(this.context);

  List<OnboardingInfo> get items => [
    OnboardingInfo(
      title: AppLocalizations.of(context)!.price_forecast,
      descriptions: AppLocalizations.of(context)!.price_forecast_landing_content1,
      image: "assets/images/forecast.png",
    ),
    OnboardingInfo(
      title: AppLocalizations.of(context)!.cinnamon_grades,
      descriptions: AppLocalizations.of(context)!.cinnamon_grades_landing_content1,
      image: "assets/images/grade.png",
    ),
    OnboardingInfo(
      title: AppLocalizations.of(context)!.cinnamon_species,
      descriptions: AppLocalizations.of(context)!.cinnamon_species_landing_content1,
      image: "assets/images/spec.png",
    ),
    OnboardingInfo(
      title: AppLocalizations.of(context)!.cinnamon_diseases,
      descriptions: AppLocalizations.of(context)!.cinnamon_diseases_landing_content1,
      image: "assets/images/disease.png",
    ),
  ];
}
