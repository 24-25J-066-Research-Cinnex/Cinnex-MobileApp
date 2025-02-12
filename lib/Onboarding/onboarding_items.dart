import 'onboarding_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingItems {
  BuildContext context;

  OnboardingItems(this.context);

  List<OnboardingInfo> get items => [
        OnboardingInfo(
          title: Text(
            AppLocalizations.of(context)!.price_forecast,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          descriptions: Text(
            AppLocalizations.of(context)!.price_forecast_landing_content1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          image: "assets/images/forecast.png",
        ),
        OnboardingInfo(
          title: Text(
            AppLocalizations.of(context)!.cinnamon_grades,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          descriptions: Text(
            AppLocalizations.of(context)!.cinnamon_grades_landing_content1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          image: "assets/images/grade.png",
        ),
        OnboardingInfo(
          title: Text(
            AppLocalizations.of(context)!.cinnamon_species,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          descriptions: Text(
            AppLocalizations.of(context)!.cinnamon_species_landing_content1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          image: "assets/images/spec.png",
        ),
        OnboardingInfo(
          title: Text(
            AppLocalizations.of(context)!.cinnamon_diseases,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
          descriptions: Text(
            AppLocalizations.of(context)!.cinnamon_diseases_landing_content1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          image: "assets/images/disease.png",
        ),
      ];
}
