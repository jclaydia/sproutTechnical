import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprout/blocs/bloc/product_bloc.dart';

import 'package:sprout/model/product_details.dart';
import 'package:sprout/repository/data_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int? productID;
  const ProductDetailsScreen({
    Key? key,
    required this.productID,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

final ProductService productService = ProductService();

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductService(),
      child: BlocProvider(
        create: (context) => ProductDetailsBloc(
            RepositoryProvider.of<ProductService>(context), widget.productID)
          ..add(const LoadProductDetailsEvent()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            centerTitle: true,
            title: const Text("Product Details"),
          ),
          body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              print("State received: $state");
              if (state is ProductDetailsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductDetailsLoadedState) {
                print("State received: $state");
                ProductDetails productDetails = state.products;
                return constructProductDetails(productDetails);
              }
              if (state is LoadingErrorState) {
                return const Center(
                  child: Text(" Error Loading Data"),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget constructProductDetails(ProductDetails productDetails) {
    List<String>? images = productDetails.images;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: images!.length,
              itemBuilder: ((context, index, realIndex) {
                final urlImage = images[index];
                return buildImage(urlImage, index);
              }),
              options: CarouselOptions(
                  height: 350,
                  viewportFraction: 1,
                  enableInfiniteScroll: false),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.green[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${productDetails.price!.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("-${productDetails.discountPercentage!.round()}% Off"),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(productDetails.title!,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Text(productDetails.description!,
                style: const TextStyle(
                  fontSize: 18,
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.green[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Stocks  ${productDetails.stock}'),
                    const Divider(),
                    Text('Brand  ${productDetails.brand}'),
                    const Divider(),
                    Text('Category  ${productDetails.category}'),
                    const Divider(),
                    Text('Rating  ${productDetails.rating!.round()}%'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        // margin: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
