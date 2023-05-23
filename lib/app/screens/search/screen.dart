import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:get/get.dart';

import '../../app.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      color: ThemeColor.white,
      onPressed: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(),
        );
      },
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    final input = query.toLowerCase();

    PagewiseLoadController<ProductModel> pageLoadController = PagewiseLoadController<ProductModel>(
        pageSize: Constants.pageSize,
        pageFuture: (pageIndex) async {
          debugPrint('page index $pageIndex');
          final Map<String, dynamic> params = {
            'currency': 'TMT',
            'locale': await getLocale(),
            'key': query.toLowerCase(),
            'page': pageIndex! + 1,
            'perPage': Constants.pageSize,
          };
          return ProductApi.search(params);
        });

    Widget itemBuilder(context, ProductModel product, _) {
      return Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              debugPrint('product');
              Get.to(() => ProductDetailScreen(model: product));
            },
            leading: const Icon(Icons.search),
            title: Text(product.name),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider()
        ],
      );
    }

    return isNullOrEmpty(input)
        ? Center(child: Text('general_search_key'.tr))
        : PagewiseListView<ProductModel>(
            pageLoadController: pageLoadController,
            itemBuilder: itemBuilder,
            loadingBuilder: (_) => const CustomLoader(),
            noItemsFoundBuilder: (_) => const NotFoundWidget(),
            retryBuilder: (context, _) => RetryWidget(onRetry: () {
              pageLoadController.retry();
            }),
          );
  }

  // Center(
  //       child: Text(
  //         query,
  //         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 64),
  //       ),
  //     );

  @override
  Widget buildSuggestions(BuildContext context) {
    final input = query.toLowerCase();

    PagewiseLoadController<ProductModel> pageLoadController = PagewiseLoadController<ProductModel>(
        pageSize: Constants.pageSize,
        pageFuture: (pageIndex) async {
          debugPrint('page index $pageIndex');
          final Map<String, dynamic> params = {
            'currency': 'TMT',
            'locale': await getLocale(),
            'key': query.toLowerCase(),
            'page': pageIndex! + 1,
            'perPage': Constants.pageSize,
          };
          return ProductApi.search(params);
        });

    Widget itemBuilder(context, ProductModel product, _) {
      return Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              debugPrint('product');
              Get.to(() => ProductDetailScreen(model: product));
            },
            leading: const Icon(Icons.search),
            title: Text(product.name),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider()
        ],
      );
    }

    return isNullOrEmpty(input)
        ? Center(child: Text('general_search_key'.tr))
        : PagewiseListView<ProductModel>(
            pageLoadController: pageLoadController,
            itemBuilder: itemBuilder,
            loadingBuilder: (_) => const CustomLoader(),
            noItemsFoundBuilder: (_) => const NotFoundWidget(),
            retryBuilder: (context, _) => RetryWidget(onRetry: () {
              pageLoadController.retry();
            }),
          );
  }

  @override
  String get searchFieldLabel => 'general_search'.tr;
}
