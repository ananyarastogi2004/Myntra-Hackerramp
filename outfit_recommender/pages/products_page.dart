// lib/pages/products_page.dart
import 'package:flutter/material.dart';
import 'package:myntra1/pages/questions.dart';
import '../services/database_helper.dart';
import '../models/product.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = DatabaseHelper().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text('Products'),
        ),
        body: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    // Handle product tap
                  },
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10.0)),
                            child: Image.network(
                              product.img,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                product.category,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 10.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                product.subcategory,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 10.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'Rs ${product.price}',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: ElevatedButton(
              style: ButtonStyle(
                  elevation: WidgetStateProperty.all<double>(15),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  backgroundColor: WidgetStateProperty.all(Colors.grey[100]),
                  minimumSize: WidgetStateProperty.all(Size(160, 70))),
              child: const Text(
                "Discover",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormScreen()));
              }),
        ));
  }
}
