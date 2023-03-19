// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up for {nameOfTheApp} {when}`
  String signUpTitle(String nameOfTheApp, DateTime when) {
    final DateFormat whenDateFormat =
        DateFormat('yQQQQ / LLLL : Hm', Intl.getCurrentLocale());
    final String whenString = whenDateFormat.format(when);

    return Intl.message(
      'Sign up for $nameOfTheApp $whenString',
      name: 'signUpTitle',
      desc: 'The title people see when they open the app for the first time.',
      args: [nameOfTheApp, whenString],
    );
  }

  /// `Create a profile, follow other accounts, make your own videos, and more.`
  String get signUpSubTitle {
    return Intl.message(
      'Create a profile, follow other accounts, make your own videos, and more.',
      name: 'signUpSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in to {nameOfTheApp}`
  String loginTitle(Object nameOfTheApp) {
    return Intl.message(
      'Log in to $nameOfTheApp',
      name: 'loginTitle',
      desc: 'The title on login screen',
      args: [nameOfTheApp],
    );
  }

  /// `Manage your account, check notifications, comment on videos, and more.`
  String get loginSubTitle {
    return Intl.message(
      'Manage your account, check notifications, comment on videos, and more.',
      name: 'loginSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use phone or email`
  String get usePhoneOrEmail {
    return Intl.message(
      'Use phone or email',
      name: 'usePhoneOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Plural test, {count} {count, plural, =0{ videos} =1{video} other{videos}} plural test`
  String pluralTest(num count) {
    return Intl.message(
      'Plural test, $count ${Intl.plural(count, zero: ' videos', one: 'video', other: 'videos')} plural test',
      name: 'pluralTest',
      desc: '',
      args: [count],
    );
  }

  /// `{count}`
  String likeCount(int count) {
    final NumberFormat countNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String countString = countNumberFormat.format(count);

    return Intl.message(
      '$countString',
      name: 'likeCount',
      desc: 'Anything you want',
      args: [countString],
    );
  }

  /// `{count}`
  String commentCount(int count) {
    final NumberFormat countNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String countString = countNumberFormat.format(count);

    return Intl.message(
      '$countString',
      name: 'commentCount',
      desc: 'Anything you want',
      args: [countString],
    );
  }

  /// `{count}, {count, plural, =0{comments} =1{comment} other{comments}}`
  String commentCountTitle(int count) {
    final NumberFormat countNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String countString = countNumberFormat.format(count);

    return Intl.message(
      '$countString, ${Intl.plural(count, zero: 'comments', one: 'comment', other: 'comments')}',
      name: 'commentCountTitle',
      desc: 'Anything you want',
      args: [countString],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
