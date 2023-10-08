import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'translations_ar.dart';
import 'translations_en.dart';

/// Callers can lookup localized strings with an instance of Translations
/// returned by `Translations.of(context)`.
///
/// Applications need to include `Translations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translation/translations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Translations.localizationsDelegates,
///   supportedLocales: Translations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Translations.supportedLocales
/// property.
abstract class Translations {
  Translations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Translations? of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static const LocalizationsDelegate<Translations> delegate = _TranslationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @errorMessage.
  ///
  /// In ar, this message translates to:
  /// **'اوبس! حدث خطأ'**
  String get errorMessage;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @noInternetConnectionMessage.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد إتصال بالشبكة'**
  String get noInternetConnectionMessage;

  /// No description provided for @accessDeniedMessage.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض الوصول، ليس لديك امتيازات كافية'**
  String get accessDeniedMessage;

  /// No description provided for @unauthenticatedMessage.
  ///
  /// In ar, this message translates to:
  /// **'المستخذم غير مصرح له بالدخول'**
  String get unauthenticatedMessage;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'تم بنجاح'**
  String get success;

  /// No description provided for @thisFieldRequired.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get thisFieldRequired;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @category.
  ///
  /// In ar, this message translates to:
  /// **'الأقسام'**
  String get category;

  /// No description provided for @favorite.
  ///
  /// In ar, this message translates to:
  /// **'المفضلة'**
  String get favorite;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الحساب'**
  String get profile;

  /// No description provided for @whatYouSearchFor.
  ///
  /// In ar, this message translates to:
  /// **'عم تبحث؟'**
  String get whatYouSearchFor;

  /// No description provided for @recentlyArrived.
  ///
  /// In ar, this message translates to:
  /// **'وصل حديثاً'**
  String get recentlyArrived;

  /// No description provided for @theMostPopular.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر شعبية'**
  String get theMostPopular;

  /// No description provided for @showAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get showAll;

  /// No description provided for @egp.
  ///
  /// In ar, this message translates to:
  /// **'ج.م'**
  String get egp;

  /// No description provided for @moveToCart.
  ///
  /// In ar, this message translates to:
  /// **'نقل إلي سلة التسوق'**
  String get moveToCart;

  /// No description provided for @item.
  ///
  /// In ar, this message translates to:
  /// **'عنصر'**
  String get item;

  /// No description provided for @items.
  ///
  /// In ar, this message translates to:
  /// **'عناصر'**
  String get items;

  /// No description provided for @total.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get total;

  /// No description provided for @fees.
  ///
  /// In ar, this message translates to:
  /// **'الضرائب'**
  String get fees;

  /// No description provided for @totalWithFees.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي بالضرائب'**
  String get totalWithFees;

  /// No description provided for @confirmOrder.
  ///
  /// In ar, this message translates to:
  /// **'إتمام الشراء'**
  String get confirmOrder;

  /// No description provided for @description.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get description;

  /// No description provided for @addToCart.
  ///
  /// In ar, this message translates to:
  /// **'إضافة للسلة'**
  String get addToCart;

  /// No description provided for @cart.
  ///
  /// In ar, this message translates to:
  /// **'سلة التسوق'**
  String get cart;

  /// No description provided for @shareProduct.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة المنتج'**
  String get shareProduct;

  /// No description provided for @addedToCart.
  ///
  /// In ar, this message translates to:
  /// **'مضاف للسلة'**
  String get addedToCart;

  /// No description provided for @newAccount.
  ///
  /// In ar, this message translates to:
  /// **'حساب جديد'**
  String get newAccount;

  /// No description provided for @welcomePleaseFillYourData.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك ، قم بملئ البيانات للتسجيل'**
  String get welcomePleaseFillYourData;

  /// No description provided for @username.
  ///
  /// In ar, this message translates to:
  /// **'اسم المستخدم'**
  String get username;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @firstName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الاول'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الاخير'**
  String get lastName;

  /// No description provided for @haveAnAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب'**
  String get haveAnAccount;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'الدخول'**
  String get login;

  /// No description provided for @signIn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signIn;

  /// No description provided for @register.
  ///
  /// In ar, this message translates to:
  /// **'التسجيل'**
  String get register;

  /// No description provided for @pleaseLoginToConfirmOrder.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك قم بالدخول لإتمام الشراء'**
  String get pleaseLoginToConfirmOrder;

  /// No description provided for @youDoNotHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب'**
  String get youDoNotHaveAccount;

  /// No description provided for @doYouHaveCoupon.
  ///
  /// In ar, this message translates to:
  /// **'هل تمتلك كوبون للخصم'**
  String get doYouHaveCoupon;

  /// No description provided for @enterCoupon.
  ///
  /// In ar, this message translates to:
  /// **'ادخل رقم الكوبون'**
  String get enterCoupon;

  /// No description provided for @apply.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق'**
  String get apply;

  /// No description provided for @cartEmpty.
  ///
  /// In ar, this message translates to:
  /// **'سلة المشتريات فارغة'**
  String get cartEmpty;

  /// No description provided for @addToFavorite.
  ///
  /// In ar, this message translates to:
  /// **'اضافة للمفضلة'**
  String get addToFavorite;

  /// No description provided for @shareApp.
  ///
  /// In ar, this message translates to:
  /// **'شارك المنتج'**
  String get shareApp;

  /// No description provided for @logOut.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logOut;
}

class _TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const _TranslationsDelegate();

  @override
  Future<Translations> load(Locale locale) {
    return SynchronousFuture<Translations>(lookupTranslations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TranslationsDelegate old) => false;
}

Translations lookupTranslations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return TranslationsAr();
    case 'en': return TranslationsEn();
  }

  throw FlutterError(
    'Translations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
