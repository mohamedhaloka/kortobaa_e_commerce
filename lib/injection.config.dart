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
    as _i24;
import 'package:kortobaa_ecommerce/auth/data/datasource/remote/auth_remote_data_source.dart'
    as _i25;
import 'package:kortobaa_ecommerce/auth/data/repositories_impl/auth_repository_impl.dart'
    as _i27;
import 'package:kortobaa_ecommerce/auth/domain/repositories/auth_repository.dart'
    as _i26;
import 'package:kortobaa_ecommerce/auth/domain/usecases/get_logged_user_token_use_case.dart'
    as _i36;
import 'package:kortobaa_ecommerce/auth/domain/usecases/login_use_case.dart'
    as _i39;
import 'package:kortobaa_ecommerce/auth/domain/usecases/register_use_case.dart'
    as _i40;
import 'package:kortobaa_ecommerce/auth/domain/usecases/remove_user_token_use_case.dart'
    as _i41;
import 'package:kortobaa_ecommerce/auth/domain/usecases/set_logged_user_token_use_case.dart'
    as _i42;
import 'package:kortobaa_ecommerce/auth/presentation/cubits/get_logged_user_token_cubit.dart'
    as _i49;
import 'package:kortobaa_ecommerce/auth/presentation/cubits/login_cubit.dart'
    as _i52;
import 'package:kortobaa_ecommerce/auth/presentation/cubits/register_cubit.dart'
    as _i53;
import 'package:kortobaa_ecommerce/auth/presentation/cubits/remove_user_token_cubit.dart'
    as _i54;
import 'package:kortobaa_ecommerce/cart/presentation/cubits/add_product_to_cart_cubit.dart'
    as _i43;
import 'package:kortobaa_ecommerce/cart/presentation/cubits/delete_product_from_cart_cubit.dart'
    as _i31;
import 'package:kortobaa_ecommerce/cart/presentation/cubits/get_cart_product_cubit.dart'
    as _i33;
import 'package:kortobaa_ecommerce/cart/presentation/cubits/get_cart_product_list_cubit.dart'
    as _i46;
import 'package:kortobaa_ecommerce/category/data/datasource/remote/category_remote_data_source.dart'
    as _i28;
import 'package:kortobaa_ecommerce/category/data/repositories/category_repository_impl.dart'
    as _i30;
import 'package:kortobaa_ecommerce/category/domain/repositories/category_repository.dart'
    as _i29;
import 'package:kortobaa_ecommerce/category/domain/usecases/get_category_list_use_case.dart'
    as _i34;
import 'package:kortobaa_ecommerce/category/presentation/cubits/get_category_list_cubit.dart'
    as _i47;
import 'package:kortobaa_ecommerce/core/data/datasource/local/cart_local_data_source.dart'
    as _i3;
import 'package:kortobaa_ecommerce/core/data/repositories/cart_repository_impl.dart'
    as _i5;
import 'package:kortobaa_ecommerce/core/domain/respositories/cart_repository.dart'
    as _i4;
import 'package:kortobaa_ecommerce/core/domain/usecases/add_product_to_cart_use_case.dart'
    as _i22;
import 'package:kortobaa_ecommerce/core/domain/usecases/delete_product_from_cart_use_case.dart'
    as _i6;
import 'package:kortobaa_ecommerce/core/domain/usecases/get_cart_product_list_use_case.dart'
    as _i11;
import 'package:kortobaa_ecommerce/core/domain/usecases/get_cart_product_use_case.dart'
    as _i12;
import 'package:kortobaa_ecommerce/favorite/data/datasource/local/favorite_local_data_source.dart'
    as _i8;
import 'package:kortobaa_ecommerce/favorite/data/repositories/favorite_repository_impl.dart'
    as _i10;
import 'package:kortobaa_ecommerce/favorite/domain/repositories/favorite_repository.dart'
    as _i9;
import 'package:kortobaa_ecommerce/favorite/domain/usecases/add_product_to_favorite_use_case.dart'
    as _i23;
import 'package:kortobaa_ecommerce/favorite/domain/usecases/delete_product_from_favorite_use_case.dart'
    as _i32;
import 'package:kortobaa_ecommerce/favorite/domain/usecases/get_favorite_product_list_use_case.dart'
    as _i13;
import 'package:kortobaa_ecommerce/favorite/domain/usecases/get_favorite_product_use_case.dart'
    as _i14;
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/add_product_to_favorite_cubit.dart'
    as _i44;
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/delete_product_from_favorite_cubit.dart'
    as _i45;
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/get_favorite_product_cubit.dart'
    as _i35;
import 'package:kortobaa_ecommerce/favorite/presentation/cubits/get_favorite_product_list_cubit.dart'
    as _i48;
import 'package:kortobaa_ecommerce/home/data/datasource/remote/home_remote_data_source.dart'
    as _i15;
import 'package:kortobaa_ecommerce/home/data/repositories/home_repository_impl.dart'
    as _i17;
import 'package:kortobaa_ecommerce/home/domain/repositories/home_repository.dart'
    as _i16;
import 'package:kortobaa_ecommerce/home/domain/usecases/get_product_list_by_category_id_use_case.dart'
    as _i38;
import 'package:kortobaa_ecommerce/home/presentation/cubits/get_product_list_by_category_id_cubit.dart'
    as _i51;
import 'package:kortobaa_ecommerce/injectable_module.dart' as _i55;
import 'package:kortobaa_ecommerce/product_details/data/datasource/remote/product_details_remote_data_source.dart'
    as _i18;
import 'package:kortobaa_ecommerce/product_details/data/repositories/product_details_repository_impl.dart'
    as _i20;
import 'package:kortobaa_ecommerce/product_details/domain/repositories/product_details_repository.dart'
    as _i19;
import 'package:kortobaa_ecommerce/product_details/domain/usecases/get_product_by_id_use_case.dart'
    as _i37;
import 'package:kortobaa_ecommerce/product_details/presentation/cubits/get_product_by_id_cubit.dart'
    as _i50;
import 'package:shared_preferences/shared_preferences.dart' as _i21;

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
    gh.lazySingleton<_i12.GetCartProductUseCase>(
        () => _i12.GetCartProductUseCase(gh<_i4.CartRepository>()));
    gh.lazySingleton<_i13.GetFavoriteProductListUseCase>(
        () => _i13.GetFavoriteProductListUseCase(gh<_i9.FavoriteRepository>()));
    gh.lazySingleton<_i14.GetFavoriteProductUseCase>(
        () => _i14.GetFavoriteProductUseCase(gh<_i9.FavoriteRepository>()));
    gh.lazySingleton<_i15.HomeRemoteDataSource>(
        () => _i15.HomeRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i16.HomeRepository>(
        () => _i17.HomeRepositoryImpl(gh<_i15.HomeRemoteDataSource>()));
    gh.lazySingleton<_i18.ProductDetailsRemoteDataSource>(
        () => _i18.ProductDetailsRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i19.ProductDetailsRepository>(() =>
        _i20.ProductDetailsRepositoryImpl(
            gh<_i18.ProductDetailsRemoteDataSource>()));
    await gh.lazySingletonAsync<_i21.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i22.AddProductToCartUseCase>(
        () => _i22.AddProductToCartUseCase(gh<_i4.CartRepository>()));
    gh.lazySingleton<_i23.AddProductToFavoriteUseCase>(
        () => _i23.AddProductToFavoriteUseCase(gh<_i9.FavoriteRepository>()));
    gh.lazySingleton<_i24.AuthLocalDataSource>(
        () => _i24.AuthLocalDataSourceImpl(gh<_i21.SharedPreferences>()));
    gh.lazySingleton<_i25.AuthRemoteDataSource>(
        () => _i25.AuthRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i26.AuthRepository>(() => _i27.AuthRepositoryImpl(
          gh<_i25.AuthRemoteDataSource>(),
          gh<_i24.AuthLocalDataSource>(),
        ));
    gh.lazySingleton<_i28.CategoryRemoteDataSource>(
        () => _i28.CategoryRemoteDataSourceImpl(gh<_i7.Dio>()));
    gh.lazySingleton<_i29.CategoryRepository>(
        () => _i30.CategoryRepositoryImpl(gh<_i28.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i31.DeleteProductFromCartCubit>(() =>
        _i31.DeleteProductFromCartCubit(
            gh<_i6.DeleteProductFromCartUseCase>()));
    gh.lazySingleton<_i32.DeleteProductFromFavoriteUseCase>(() =>
        _i32.DeleteProductFromFavoriteUseCase(gh<_i9.FavoriteRepository>()));
    gh.lazySingleton<_i33.GetCartProductCubit>(
        () => _i33.GetCartProductCubit(gh<_i12.GetCartProductUseCase>()));
    gh.lazySingleton<_i34.GetCategoryListUseCase>(
        () => _i34.GetCategoryListUseCase(gh<_i29.CategoryRepository>()));
    gh.lazySingleton<_i35.GetFavoriteProductCubit>(() =>
        _i35.GetFavoriteProductCubit(gh<_i14.GetFavoriteProductUseCase>()));
    gh.lazySingleton<_i36.GetLoggedUserTokenUseCase>(
        () => _i36.GetLoggedUserTokenUseCase(gh<_i26.AuthRepository>()));
    gh.lazySingleton<_i37.GetProductByIdUseCase>(
        () => _i37.GetProductByIdUseCase(gh<_i19.ProductDetailsRepository>()));
    gh.lazySingleton<_i38.GetProductListByCategoryIdUseCase>(() =>
        _i38.GetProductListByCategoryIdUseCase(gh<_i16.HomeRepository>()));
    gh.lazySingleton<_i39.LoginUseCase>(
        () => _i39.LoginUseCase(gh<_i26.AuthRepository>()));
    gh.lazySingleton<_i40.RegisterUseCase>(
        () => _i40.RegisterUseCase(gh<_i26.AuthRepository>()));
    gh.lazySingleton<_i41.RemoveUserTokenUseCase>(
        () => _i41.RemoveUserTokenUseCase(gh<_i26.AuthRepository>()));
    gh.lazySingleton<_i42.SetLoggedUserTokenUseCase>(
        () => _i42.SetLoggedUserTokenUseCase(gh<_i26.AuthRepository>()));
    gh.lazySingleton<_i43.AddProductToCartCubit>(
        () => _i43.AddProductToCartCubit(gh<_i22.AddProductToCartUseCase>()));
    gh.lazySingleton<_i44.AddProductToFavoriteCubit>(() =>
        _i44.AddProductToFavoriteCubit(gh<_i23.AddProductToFavoriteUseCase>()));
    gh.lazySingleton<_i45.DeleteProductFromFavoriteCubit>(() =>
        _i45.DeleteProductFromFavoriteCubit(
            gh<_i32.DeleteProductFromFavoriteUseCase>()));
    gh.factory<_i46.GetCartProductListCubit>(() => _i46.GetCartProductListCubit(
          gh<_i11.GetCartProductListUseCase>(),
          gh<_i43.AddProductToCartCubit>(),
          gh<_i31.DeleteProductFromCartCubit>(),
        ));
    gh.factory<_i47.GetCategoryListCubit>(
        () => _i47.GetCategoryListCubit(gh<_i34.GetCategoryListUseCase>()));
    gh.factory<_i48.GetFavoriteProductListCubit>(
        () => _i48.GetFavoriteProductListCubit(
              gh<_i13.GetFavoriteProductListUseCase>(),
              gh<_i45.DeleteProductFromFavoriteCubit>(),
              gh<_i44.AddProductToFavoriteCubit>(),
            ));
    gh.factory<_i49.GetLoggedUserTokenCubit>(() =>
        _i49.GetLoggedUserTokenCubit(gh<_i36.GetLoggedUserTokenUseCase>()));
    gh.factory<_i50.GetProductByIdCubit>(
        () => _i50.GetProductByIdCubit(gh<_i37.GetProductByIdUseCase>()));
    gh.factory<_i51.GetProductListByCategoryIdCubit>(() =>
        _i51.GetProductListByCategoryIdCubit(
            gh<_i38.GetProductListByCategoryIdUseCase>()));
    gh.factory<_i52.LoginCubit>(() => _i52.LoginCubit(
          gh<_i39.LoginUseCase>(),
          gh<_i42.SetLoggedUserTokenUseCase>(),
        ));
    gh.factory<_i53.RegisterCubit>(
        () => _i53.RegisterCubit(gh<_i40.RegisterUseCase>()));
    gh.factory<_i54.RemoveUserTokenCubit>(
        () => _i54.RemoveUserTokenCubit(gh<_i41.RemoveUserTokenUseCase>()));
    return this;
  }
}

class _$InjectableModule extends _i55.InjectableModule {}
