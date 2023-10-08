import 'translations.dart';

/// The translations for Arabic (`ar`).
class TranslationsAr extends Translations {
  TranslationsAr([String locale = 'ar']) : super(locale);

  @override
  String get errorMessage => 'اوبس! حدث خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noInternetConnectionMessage => 'لا يوجد إتصال بالشبكة';

  @override
  String get accessDeniedMessage => 'تم رفض الوصول، ليس لديك امتيازات كافية';

  @override
  String get unauthenticatedMessage => 'المستخذم غير مصرح له بالدخول';

  @override
  String get success => 'تم بنجاح';

  @override
  String get thisFieldRequired => 'هذا الحقل مطلوب';

  @override
  String get home => 'الرئيسية';

  @override
  String get category => 'الأقسام';

  @override
  String get favorite => 'المفضلة';

  @override
  String get profile => 'الحساب';

  @override
  String get whatYouSearchFor => 'عم تبحث؟';

  @override
  String get recentlyArrived => 'وصل حديثاً';

  @override
  String get theMostPopular => 'الأكثر شعبية';

  @override
  String get showAll => 'عرض الكل';

  @override
  String get egp => 'ج.م';

  @override
  String get moveToCart => 'نقل إلي سلة التسوق';

  @override
  String get item => 'عنصر';

  @override
  String get items => 'عناصر';

  @override
  String get total => 'الإجمالي';

  @override
  String get fees => 'الضرائب';

  @override
  String get totalWithFees => 'الإجمالي بالضرائب';

  @override
  String get confirmOrder => 'إتمام الشراء';

  @override
  String get description => 'الوصف';

  @override
  String get addToCart => 'إضافة للسلة';

  @override
  String get cart => 'سلة التسوق';

  @override
  String get shareProduct => 'مشاركة المنتج';

  @override
  String get addedToCart => 'مضاف للسلة';

  @override
  String get newAccount => 'حساب جديد';

  @override
  String get welcomePleaseFillYourData => 'مرحباً بك ، قم بملئ البيانات للتسجيل';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get email => 'البريد الالكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get firstName => 'الاسم الاول';

  @override
  String get lastName => 'الاسم الاخير';

  @override
  String get haveAnAccount => 'لديك حساب';

  @override
  String get login => 'الدخول';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get register => 'التسجيل';

  @override
  String get pleaseLoginToConfirmOrder => 'من فضلك قم بالدخول لإتمام الشراء';

  @override
  String get youDoNotHaveAccount => 'ليس لديك حساب';

  @override
  String get doYouHaveCoupon => 'هل تمتلك كوبون للخصم';

  @override
  String get enterCoupon => 'ادخل رقم الكوبون';

  @override
  String get apply => 'تطبيق';

  @override
  String get cartEmpty => 'سلة المشتريات فارغة';

  @override
  String get addToFavorite => 'اضافة للمفضلة';

  @override
  String get shareApp => 'شارك المنتج';
}
