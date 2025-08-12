import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/utils/utils.dart';
import 'package:hangangramyeon/core/widgets/app_circular_indicator.dart';
import 'package:hangangramyeon/features/home/blocs/home_cubit.dart';
import 'package:hangangramyeon/features/home/blocs/home_state.dart';
import 'package:hangangramyeon/features/home/models/response/production_response.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/widgets/production_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductItem> products = [];
  String searchQuery = '';
  String selectedCategory = 'Tất cả';

  int lastPage = 0;
  int selectedPage = 1;
  int totalPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getListProduction(selectedPage,searchQuery);
  }

  List<ProductItem> get filteredProducts {
    if (searchQuery.isEmpty && selectedCategory == 'Tất cả') {
      return products;
    }

    return products.where((product) {
      final matchesSearch = product.name.toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.code.toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'Tất cả' || product.categoryName == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<String?> get categories {
    final categories = products.map((p) => p.categoryName).toSet().toList();
    categories.insert(0, 'Tất cả');
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Sản phẩm',),
        centerTitle: true,
        elevation: 0,
      ),
      body:  BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            Utils.showCenterMessage(context, "Có lỗi xảy ra: ${state.message}", isError: true);
          }
          else if(state is GetListProductionSuccess){
            products.addAll(state.productionResponse.data?.items??[]);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                buildBody(context,state),
                Visibility(
                  visible: state is HomeLoading,
                  child: const AppCircularIndicator(),
                )
              ],
            ),

          );
        },
      ),
    );
  }

  buildBody(BuildContext context, HomeState state){
    return Column(
      children: [
        // Search and Filter Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Category Filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    final isSelected = category == selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category.toString()),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category.toString();
                          });
                        },
                        backgroundColor: Colors.grey[200],
                        selectedColor: const Color(0xFF2196F3),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        // Products Grid
        Expanded(
          child:  MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return ProductCard(
                product: product,
                index: index,
                onTap: () {
                  // _showProductDetail(product);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // void _showProductDetail(ProductItem product) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => ProductDetailModal(product: product),
  //   );
  // }
}
