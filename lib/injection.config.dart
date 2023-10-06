// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kortobaa_ecommerce/auth/data/datasource/local/auth_local_data_source.dart'
    as _i22;
import 'package:kortobaa_ecommerce/auth/data/datasource/remote/auth_remote_data_source.dart'
    as _i23;
import 'package:kortobaa_ecommerce/auth/data/repositories_impl/auth_repository_impl.dart'
    as _i25;
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart'
    as _i24;
import 'package:kortobaa_ecommerce/auth/domain/usecases/get_logged_user_token_use_case.dart'
    as _i33;
import 'package:kortobaa_ecommerce/auth/domain/usecases/login_use_case.dart'
    as _i36;
import 'package:kortobaa_ecommerce/auth/domain/usecases/register_use_case.dart'
    as _i37;
import 'package:kortobaa_ecommerce/auth/domain/usecases/set_logged_user_token_use_case.dart'
    as _i38;
import 'package:kortobaa_ecommerce/auth/presentation/cubits/login_cubit.dart'
    as _i46;
import 'package:kortobaa_ecommerce/auth/presentation/cubits/register_cubit.dart'
    as _i47;
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart'
    as _i39;
import 'package:kortobaa_ecommerce/cart/presentation/cubits/delete_product_from_cart_cubit.dart'
    as _i29;
import 'package:kortobaa_ecommerce/cart/presentation/cubits/get_cart_product_list_cubit.dart'
    as _i42;
import 'package:kortobaa_ecommerce/category/data/datasource/remote/category_remote_data_source.dart'
    as _i26;
import 'package:kortobaa_ecommerce/category/data/repositories/category_repository_impl.dart'
    as _i28;
import 'package:kortobaa_ecommerce/category/domain/repositories/category_repository.dart'
    as _i27;
import 'package:kortobaa_ecommerce/category/domain/usecases/get_category_list_use_case.dart'
    as _i31;
import 'package:kortobaa_ecommerce/category/presentation/cubits/get_category_list_cubit.dart'
    as _i43;
import 'package:kortobaa_ecommerce/core/data/datasource/local/cart_local_data_source.dart'
    as _i3;
import 'package:kortobaa_ecommerce/core/data/repositories/cart_repository_impl.dart'
    as _i5;
import 'package:kortobaa_ecommerce/core/domain/respositories/cart_repository.dart'
    as _i4;
import 'package:kortobaa_ecommerce/core/domain/usecases/add_product_to_cart_use_case.dart'
    as _i20;
import 'package:kortobaa_ecommerce/core/domain/usecases/delete_product_from_cart_use_case.dart'
    as _i6;
import 'package:kortobaa_ecommerce/core/domain/usecases/get_cart_product_list_use_case.dart'
    as _i11;
import 'package:kortobaa_ecommerce/favorite/data/datasource/local/favorite_local_data_source.dart'
    as _i8;
import 'package:kortobaa_ecommerce/favorite/data/repositories/favorite_repository_impl.dart'
    as _i10;
import 'package:kortobaa_ecommerce/favorite/domain/repositories/favorite_repository.dart'
    as _i9;
import 'package:kortobaa_ecommerce/favorite/domain/usecases/add_product_to_favorite_use_case.dart'
    as _i21;
import 'package:kortobaa_ecommerce/favorite/domain/usecases/delete_product_from_favorite_use_case.dart'
    as _i30;
import 'package:kortobaa_ecommerce/favorite/domain/usecases/get_favorite_product_list_use_case.dart'
    as _i12;
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/add_product_to_favorite_cubit.dart'
    as _i40;
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/delete_product_from_favorite_cubit.dart'
    as _i41;
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/get_favorite_product_list_cubit.dart'
    as _i32;
import 'package:kortobaa_ecommerce/home/data/datasource/remote/home_remote_data_source.dart'
    as _i13;
import 'package:kortobaa_ecommerce/home/data/repositories/home_repository_impl.dart'
    as _i15;
import 'package:kortobaa_ecommerce/home/domain/repositories/home_repository.dart'
    as _i14;
import 'package:kortobaa_ecommerce/home/domain/usecases/get_product_list_by_category_id_use_case.dart'
    as _i35;
import 'package:kortobaa_ecommerce/home/presentation/cubits/get_product_list_by_category_id_cubit.dart'
    as _i45;
import 'package:kortobaa_ecommerce/injectable_module.dart' as _i48;
import 'package:kortobaa_ecommerce/product_details/data/datasource/remote/product_details_remote_data_source.dart'
    as _i16;
import 'package:kortobaa_ecommerce/product_details/data/repositories/product_details_repository_impl.dart'
    as _i18;
import 'package:kortobaa_ecommerce/product_details/domain/repositories/product_details_repository.dart'
    as _i17;
import 'package:kortobaa_ecommerce/product_details/domain/usecases/get_product_by_id_use_case.dart'
    as _i34;
import 'package:kortobaa_ecommerce/product_details/presentation/cubits/get_product_by_id_cubit.dart'
    as _i44;
import 'package:shared_preferences/shared_preferences.dart' as _i19;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i3.CartLocalDataSource>(
        () => _i3.CartLocalDataSourceImpl());
    gh.lazySingleton<_i4.CartRepository>(
        () => _i5.CartRepositoryImpl(gh<_i3.CartLocalDataSource>()));
    gh.lazySingleton<_i6.DeleteProductFromCartUseCase>(
        () => _i6.DeleteProductFromCartUseCase(gh<_i4.CartRepository>()));
    gh.lazySingleton<_i7.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i8.FavoriteLocalDataSource>(
        () => _i8.FavoriteLocalDataSourceImpl());
    gh.lazySingleton<_i9.FavoriteRepository>(
        () => _i10.FavoriteRepositoryImpl(gh<_i8.FavoriteLocalDataSource>()));
    gh.lazySingleton<_i11.GetCartProductListUseCase>(
        () => _i11.GetCartProductListUseCase(gh<_i4.CartRepository>()));
    gh.lazySingleton<_i12.GetFavoriteProductListUseCase>(
        () => _i12.GetFavoriteProductListUseCase(gh<_i9.FavoriteRepository>()));
    gh.lazySingleton<_i13.HomeRemoteDataSource>(
        () => _i13.HomeRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i14.HomeRepository>(
        () => _i15.HomeRepositoryImpl(gh<_i13.HomeRemoteDataSource>()));
    gh.lazySingleton<_i16.ProductDetailsRemoteDataSource>(
        () => _i16.ProductDetailsRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i17.ProductDetailsRepository>(() =>
        _i18.ProductDetailsRepositoryImpl(
            gh<_i16.ProductDetailsRemoteDataSource>()));
    await gh.lazySingletonAsync<_i19.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i20.AddProductToCartUseCase>(
        () => _i20.AddProductToCartUseCase(gh<_i4.CartRepository>()));
    gh.lazySingleton<_i21.AddProductToFavoriteUseCase>(
        () => _i21.AddProductToFavoriteUseCase(gh<_i9.FavoriteRepository>()));
    gh.lazySingleton<_i22.AuthLocalDataSource>(
        () => _i22.AuthLocalDataSourceImpl(gh<_i19.SharedPreferences>()));
    gh.lazySingleton<_i23.AuthRemoteDataSource>(
        () => _i23.AuthRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i24.AuthRepository>(() => _i25.AuthRepositoryImpl(
          gh<_i23.AuthRemoteDataSource>(),
          gh<_i22.AuthLocalDataSource>(),
        ));
    gh.lazySingleton<_i26.CategoryRemoteDataSource>(
        () => _i26.CategoryRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i27.CategoryRepository>(
        () => _i28.CategoryRepositoryImpl(gh<_i26.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i29.DeleteProductFromCartCubit>(() =>
        _i29.DeleteProductFromCartCubit(
            gh<_i6.DeleteProductFromCartUseCase>()));
    gh.lazySingleton<_i30.DeleteProductFromFavoriteUseCase>(() =>
        _i30.DeleteProductFromFavoriteUseCase(gh<_i9.FavoriteRepository>()));
    gh.lazySingleton<_i31.GetCategoryListUseCase>(
        () => _i31.GetCategoryListUseCase(gh<_i27.CategoryRepository>()));
    gh.lazySingleton<_i32.GetFavoriteProductListCubit>(() =>
        _i32.GetFavoriteProductListCubit(
            gh<_i12.GetFavoriteProductListUseCase>()));
    gh.lazySingleton<_i33.GetLoggedUserTokenUseCase>(
        () => _i33.GetLoggedUserTokenUseCase(gh<_i24.AuthRepository>()));
    gh.lazySingleton<_i34.GetProductByIdUseCase>(
        () => _i34.GetProductByIdUseCase(gh<_i17.ProductDetailsRepository>()));
    gh.lazySingleton<_i35.GetProductListByCategoryIdUseCase>(() =>
        _i35.GetProductListByCategoryIdUseCase(gh<_i14.HomeRepository>()));
    gh.lazySingleton<_i36.LoginUseCase>(
        () => _i36.LoginUseCase(gh<_i24.AuthRepository>()));
    gh.lazySingleton<_i37.RegisterUseCase>(
        () => _i37.RegisterUseCase(gh<_i24.AuthRepository>()));
    gh.lazySingleton<_i38.SetLoggedUserTokenUseCase>(
        () => _i38.SetLoggedUserTokenUseCase(gh<_i24.AuthRepository>()));
    gh.lazySingleton<_i39.AddProductToCartCubit>(
        () => _i39.AddProductToCartCubit(gh<_i20.AddProductToCartUseCase>()));
    gh.lazySingleton<_i40.AddProductToFavoriteCubit>(() =>
        _i40.AddProductToFavoriteCubit(gh<_i21.AddProductToFavoriteUseCase>()));
    gh.lazySingleton<_i41.DeleteProductFromFavoriteCubit>(() =>
        _i41.DeleteProductFromFavoriteCubit(
            gh<_i30.DeleteProductFromFavoriteUseCase>()));
    gh.lazySingleton<_i42.GetCartProductListCubit>(
        () => _i42.GetCartProductListCubit(
              gh<_i11.GetCartProductListUseCase>(),
              gh<_i39.AddProductToCartCubit>(),
              gh<_i29.DeleteProductFromCartCubit>(),
            ));
    gh.factory<_i43.GetCategoryListCubit>(
        () => _i43.GetCategoryListCubit(gh<_i31.GetCategoryListUseCase>()));
    gh.factory<_i44.GetProductByIdCubit>(
        () => _i44.GetProductByIdCubit(gh<_i34.GetProductByIdUseCase>()));
    gh.factory<_i45.GetProductListByCategoryIdCubit>(() =>
        _i45.GetProductListByCategoryIdCubit(
            gh<_i35.GetProductListByCategoryIdUseCase>()));
    gh.factory<_i46.LoginCubit>(() => _i46.LoginCubit(
          gh<_i36.LoginUseCase>(),
          gh<_i38.SetLoggedUserTokenUseCase>(),
        ));
    gh.factory<_i47.RegisterCubit>(
        () => _i47.RegisterCubit(gh<_i37.RegisterUseCase>()));
    return this;
  }
}

class _$InjectableModule extends _i48.InjectableModule {}
