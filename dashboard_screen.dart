import 'package:flutter/material.dart';

import '../models/product_item.dart';
import '../services/api_service.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/metric_card.dart';
import '../widgets/product_grid.dart';
import '../widgets/sales_list_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<ProductItem>> futureProducts;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    futureProducts = ApiService().fetchProducts();
  }

  Future<void> refreshData() async {
    setState(() {
      loadData();
    });

    await futureProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UMKM Insight Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                loadData();
              });
            },
          ),
        ],
      ),

      body: FutureBuilder<List<ProductItem>>(
        future: futureProducts,
        builder: (context, snapshot) {

          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loadData();
                      });
                    },
                    child: const Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          }

          final products = snapshot.data ?? [];

          double totalHarga = 0;
          int totalTerjual = 0;
          int trendUp = 0;
          int trendDown = 0;

          for (var item in products) {
            totalHarga += item.price;
            totalTerjual += item.sold;

            if (item.trend == "up") {
              trendUp++;
            } else {
              trendDown++;
            }
          }

          double rataHarga =
          products.isEmpty ? 0 : totalHarga / products.length;

          return LayoutBuilder(
            builder: (context, constraints) {

              bool isTablet = constraints.maxWidth >= 600;

              return RefreshIndicator(
                onRefresh: refreshData,

                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const DashboardHeader(),

                      const SizedBox(height: 20),

                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [

                          MetricCard(
                            title: "Total Produk",
                            value: "${products.length}",
                            icon: Icons.inventory,
                            color: Colors.blue,
                            isTablet: isTablet,
                          ),

                          MetricCard(
                            title: "Rata-rata Harga",
                            value: "Rp ${rataHarga.toStringAsFixed(0)}",
                            icon: Icons.payments,
                            color: Colors.green,
                            isTablet: isTablet,
                          ),

                          MetricCard(
                            title: "Total Terjual",
                            value: "$totalTerjual",
                            icon: Icons.shopping_cart,
                            color: Colors.orange,
                            isTablet: isTablet,
                          ),

                          MetricCard(
                            title: "Trend Naik",
                            value: "$trendUp",
                            icon: Icons.trending_up,
                            color: Colors.teal,
                            isTablet: isTablet,
                          ),

                          MetricCard(
                            title: "Trend Turun",
                            value: "$trendDown",
                            icon: Icons.trending_down,
                            color: Colors.red,
                            isTablet: isTablet,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Daftar Produk",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ProductGrid(
                        products: products,
                        isTablet: isTablet,
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Aktivitas Penjualan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return SalesListItem(
                            product: products[index],
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
