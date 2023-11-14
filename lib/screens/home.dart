import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprout/blocs/bloc/product_bloc.dart';
import 'package:sprout/model/product_list_model.dart';
import 'package:sprout/repository/data_provider.dart';
import 'package:sprout/screens/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int skip = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Product List"),
      ),
      body: RepositoryProvider(
        create: (context) => ProductService(),
        child: BlocProvider(
          create: (context) =>
              ProductBloc(RepositoryProvider.of<ProductService>(context), skip)
                ..add(const LoadProductEvent()),
          child: const ListofProducts(),
        ),
      ),
    );
  }
}
