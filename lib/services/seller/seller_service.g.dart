// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'seller_service.dart';

// // **************************************************************************
// // RiverpodGenerator
// // **************************************************************************

// String _$getSellerProductsByTagHash() =>
//     r'1742407558b42e772ad3b3b4ee181faedea8df42';

// /// Copied from Dart SDK
// class _SystemHash {
//   _SystemHash._();

//   static int combine(int hash, int value) {
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + value);
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
//     return hash ^ (hash >> 6);
//   }

//   static int finish(int hash) {
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
//     // ignore: parameter_assignments
//     hash = hash ^ (hash >> 11);
//     return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
//   }
// }

// /// See also [getSellerProductsByTag].
// @ProviderFor(getSellerProductsByTag)
// const getSellerProductsByTagProvider = GetSellerProductsByTagFamily();

// /// See also [getSellerProductsByTag].
// class GetSellerProductsByTagFamily
//     extends Family<AsyncValue<List<ProductModel>>> {
//   /// See also [getSellerProductsByTag].
//   const GetSellerProductsByTagFamily();

//   /// See also [getSellerProductsByTag].
//   GetSellerProductsByTagProvider call(
//     String categoryId,
//     String tagId,
//     String token,
//     int page,
//   ) {
//     return GetSellerProductsByTagProvider(
//       categoryId,
//       tagId,
//       token,
//       page,
//     );
//   }

//   @override
//   GetSellerProductsByTagProvider getProviderOverride(
//     covariant GetSellerProductsByTagProvider provider,
//   ) {
//     return call(
//       provider.categoryId,
//       provider.tagId,
//       provider.token,
//       provider.page,
//     );
//   }

//   static const Iterable<ProviderOrFamily>? _dependencies = null;

//   @override
//   Iterable<ProviderOrFamily>? get dependencies => _dependencies;

//   static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

//   @override
//   Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
//       _allTransitiveDependencies;

//   @override
//   String? get name => r'getSellerProductsByTagProvider';
// }

// /// See also [getSellerProductsByTag].
// class GetSellerProductsByTagProvider
//     extends AutoDisposeFutureProvider<List<ProductModel>> {
//   /// See also [getSellerProductsByTag].
//   GetSellerProductsByTagProvider(
//     String categoryId,
//     String tagId,
//     String token,
//     int page,
//   ) : this._internal(
//           (ref) => getSellerProductsByTag(
//             ref as GetSellerProductsByTagRef,
//             categoryId,
//             tagId,
//             token,
//             page,
//           ),
//           from: getSellerProductsByTagProvider,
//           name: r'getSellerProductsByTagProvider',
//           debugGetCreateSourceHash:
//               const bool.fromEnvironment('dart.vm.product')
//                   ? null
//                   : _$getSellerProductsByTagHash,
//           dependencies: GetSellerProductsByTagFamily._dependencies,
//           allTransitiveDependencies:
//               GetSellerProductsByTagFamily._allTransitiveDependencies,
//           categoryId: categoryId,
//           tagId: tagId,
//           token: token,
//           page: page,
//         );

//   GetSellerProductsByTagProvider._internal(
//     super._createNotifier, {
//     required super.name,
//     required super.dependencies,
//     required super.allTransitiveDependencies,
//     required super.debugGetCreateSourceHash,
//     required super.from,
//     required this.categoryId,
//     required this.tagId,
//     required this.token,
//     required this.page,
//   }) : super.internal();

//   final String categoryId;
//   final String tagId;
//   final String token;
//   final int page;

//   @override
//   Override overrideWith(
//     FutureOr<List<ProductModel>> Function(GetSellerProductsByTagRef provider)
//         create,
//   ) {
//     return ProviderOverride(
//       origin: this,
//       override: GetSellerProductsByTagProvider._internal(
//         (ref) => create(ref as GetSellerProductsByTagRef),
//         from: from,
//         name: null,
//         dependencies: null,
//         allTransitiveDependencies: null,
//         debugGetCreateSourceHash: null,
//         categoryId: categoryId,
//         tagId: tagId,
//         token: token,
//         page: page,
//       ),
//     );
//   }

//   @override
//   AutoDisposeFutureProviderElement<List<ProductModel>> createElement() {
//     return _GetSellerProductsByTagProviderElement(this);
//   }

//   @override
//   bool operator ==(Object other) {
//     return other is GetSellerProductsByTagProvider &&
//         other.categoryId == categoryId &&
//         other.tagId == tagId &&
//         other.token == token &&
//         other.page == page;
//   }

//   @override
//   int get hashCode {
//     var hash = _SystemHash.combine(0, runtimeType.hashCode);
//     hash = _SystemHash.combine(hash, categoryId.hashCode);
//     hash = _SystemHash.combine(hash, tagId.hashCode);
//     hash = _SystemHash.combine(hash, token.hashCode);
//     hash = _SystemHash.combine(hash, page.hashCode);

//     return _SystemHash.finish(hash);
//   }
// }

// mixin GetSellerProductsByTagRef
//     on AutoDisposeFutureProviderRef<List<ProductModel>> {
//   /// The parameter `categoryId` of this provider.
//   String get categoryId;

//   /// The parameter `tagId` of this provider.
//   String get tagId;

//   /// The parameter `token` of this provider.
//   String get token;

//   /// The parameter `page` of this provider.
//   int get page;
// }

// class _GetSellerProductsByTagProviderElement
//     extends AutoDisposeFutureProviderElement<List<ProductModel>>
//     with GetSellerProductsByTagRef {
//   _GetSellerProductsByTagProviderElement(super.provider);

//   @override
//   String get categoryId =>
//       (origin as GetSellerProductsByTagProvider).categoryId;
//   @override
//   String get tagId => (origin as GetSellerProductsByTagProvider).tagId;
//   @override
//   String get token => (origin as GetSellerProductsByTagProvider).token;
//   @override
//   int get page => (origin as GetSellerProductsByTagProvider).page;
// }
// // ignore_for_file: type=lint
// // ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
