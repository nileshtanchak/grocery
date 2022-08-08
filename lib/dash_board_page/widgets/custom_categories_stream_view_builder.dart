import 'package:flutter/material.dart';
import 'package:on_boarding/model/category.dart';
import 'package:on_boarding/provider/category_provider.dart';
import 'package:provider/provider.dart';

import '../../category_wise_product/category_page/category_wise_product.dart';
import 'categories_list.dart';

class CustomCategoriesStreamViewBuilder extends StatefulWidget {
  const CustomCategoriesStreamViewBuilder({Key? key}) : super(key: key);

  @override
  State<CustomCategoriesStreamViewBuilder> createState() =>
      _CustomCategoriesStreamViewBuilderState();
}

class _CustomCategoriesStreamViewBuilderState
    extends State<CustomCategoriesStreamViewBuilder> {
  @override
  void initState() {
    context.read<CategoryProvider>().fetchCategory();
    context.read<CategoryProvider>().categoryQuery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: FutureBuilder(
        future: Provider.of<CategoryProvider>(context).futureCategoryList,
        builder: (context, AsyncSnapshot<List<Category>> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!streamSnapshot.hasData) {
            return const Text("No Data");
          } else if (streamSnapshot.hasError) {
            return const Text("Something Went Wrong");
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return CategoriesList(
                image: streamSnapshot.data?[index].image ?? "",
                title: streamSnapshot.data?[index].name ?? "",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryWiseProduct(
                        isBeautyCare: true,
                        uID: streamSnapshot.data?[index].id ?? "",
                        productName: streamSnapshot.data?[index].name ?? "",
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
