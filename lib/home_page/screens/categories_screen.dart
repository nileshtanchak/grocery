import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/provider/category_provider.dart';
import 'package:provider/provider.dart';

import '../../category_wise_product/category_page/category_wise_product.dart';
import '../../model/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    context.read<CategoryProvider>().fetchCategory();
    context.read<CategoryProvider>().categoryQuery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// TabBar Category GridViewBuilder
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          child: FutureBuilder(
            future: Provider.of<CategoryProvider>(context).futureCategoryList,
            builder: (context, AsyncSnapshot<List<Category>> streamSnapshot) {
              final provider = Provider.of<CategoryProvider>(context);
              print(streamSnapshot.data?[0].name);
              if (!streamSnapshot.hasData) {
                return const Text("No Data");
              }
              return GridView.builder(
                itemCount: streamSnapshot.data?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 50,
                  crossAxisCount: 3,
                ),
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryWiseProduct(
                                  isBeautyCare: true,
                                  uID: streamSnapshot.data?[index].id ?? "",
                                  productName:
                                      streamSnapshot.data?[index].name ?? "",
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Color(
                                    (math.Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                .withOpacity(0.2),
                            child: CachedNetworkImage(
                              imageUrl: streamSnapshot.data?[index].image ?? "",
                              fit: BoxFit.cover,
                              height: 50,
                              width: 60,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        streamSnapshot.data?[index].name ?? "",
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
