// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprout/blocs/bloc/product_bloc.dart';
import 'package:sprout/model/product_details.dart';

import 'package:sprout/repository/data_provider.dart';
import 'package:sprout/screens/product_details.dart';

import '../model/product_list_model.dart';

class ListofProducts extends StatefulWidget {
  const ListofProducts({super.key});

  @override
  State<ListofProducts> createState() => _ListofProductsState();
}

class _ListofProductsState extends State<ListofProducts> {
  final ProductService productService = ProductService();

  int skip = 0;
  int limit = 10;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductEvent());
  }

  Future refresh() async {
    setState(() {
      if (skip == 90) {
        skip = 0;
      } else {
        skip += 10;
      }
      context.read<ProductBloc>().add(RefreshProductEvent(skip));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        print(state);
        if (state is ProductLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoadedState) {
          print(skip);
          List<Product> productList = state.product!;
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          final productID = productList[index].id;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      productID: productList[index].id)));
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 7.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    child: Image.network(
                                      productList[index].thumbnail!,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(productList[index].title!,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    children: [
                                      Text(
                                          '\$${productList[index].price!.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(1),
                                        color: Colors.green[200],
                                        child: Center(
                                          child: Text(
                                              "${productList[index].discountPercentage!.round()}% Off"),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Stocks: ${productList[index].stock.toString()}"),
                                      Text(
                                          "Item id: ${productList[index].id.toString()}"),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    })),
              ));
        }
        if (state is LoadingErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" Error Loading Data"),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(RefreshProductEvent(skip));
                    },
                    child: Text("Tap to Refresh")),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
