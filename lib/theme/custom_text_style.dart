import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body style
  static get bodyLargeKronaOne => theme.textTheme.bodyLarge!.kronaOne;
  // Display text style
  static get displayMedium50 => theme.textTheme.displayMedium!.copyWith(
        fontSize: 50.fSize,
      );
  static get displayMediumBlack => theme.textTheme.displayMedium!.copyWith(
        fontSize: 45.fSize,
        fontWeight: FontWeight.w900,
      );
  static get displayMediumOnError => theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onError.withOpacity(0.7),
        fontSize: 50.fSize,
      );
  // Headline text style
  static get headlineLargeLivvicOnError =>
      theme.textTheme.headlineLarge!.livvic.copyWith(
        color: theme.colorScheme.onError.withOpacity(0.7),
        fontSize: 32.fSize,
      );
  static get headlineLargeLivvicOnErrorBold =>
      theme.textTheme.headlineLarge!.livvic.copyWith(
        color: theme.colorScheme.onError.withOpacity(0.7),
        fontSize: 32.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineLargeOnError => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onError.withOpacity(0.5),
        fontSize: 33.fSize,
      );
  static get headlineLargePrimaryContainer =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 32.fSize,
      );
  static get headlineLargePurple400 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.purple400,
        fontSize: 32.fSize,
      );
  static get headlineMedium28 => theme.textTheme.headlineMedium!.copyWith(
        fontSize: 28.fSize,
      );
  static get headlineMediumLondrinaSolidPurpleA200 =>
      theme.textTheme.headlineMedium!.londrinaSolid.copyWith(
        color: appTheme.purpleA200,
        fontSize: 28.fSize,
      );
  static get headlineSmallLondrinaSolid =>
      theme.textTheme.headlineSmall!.londrinaSolid;
  static get headlineSmallPoppinsOnError =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        color: theme.colorScheme.onError.withOpacity(0.7),
      );
  // Londrina text style
  static get londrinaSolidPrimary => TextStyle(
        color: theme.colorScheme.primary,
        fontSize: 100.fSize,
        fontWeight: FontWeight.w900,
      ).londrinaSolid;
  // Title text style
  static get titleLargeLalezarOnError =>
      theme.textTheme.titleLarge!.lalezar.copyWith(
        color: theme.colorScheme.onError.withOpacity(0.7),
        fontSize: 22.fSize,
      );
}

extension on TextStyle {
  TextStyle get kronaOne {
    return copyWith(
      fontFamily: 'Krona One',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get londrinaSolid {
    return copyWith(
      fontFamily: 'Londrina Solid',
    );
  }

  TextStyle get livvic {
    return copyWith(
      fontFamily: 'Livvic',
    );
  }

  TextStyle get lalezar {
    return copyWith(
      fontFamily: 'Lalezar',
    );
  }
}
