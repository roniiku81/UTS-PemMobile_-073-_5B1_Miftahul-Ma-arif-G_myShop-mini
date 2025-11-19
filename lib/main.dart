import 'package:flutter/material.dart';

// Model untuk Category
class Category {
  final String name;
  final IconData icon;
  const Category({required this.name, required this.icon});
}

// Model untuk Product
class Product {
  final String name;
  final IconData icon;
  final String price;
  final String location;
  final double rating;
  const Product({
    required this.name,
    required this.icon,
    required this.price,
    this.location = 'Jakarta',
    this.rating = 4.5,
  });
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop Mini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo,
          elevation: 0,
        ),
        useMaterial3: false,
      ),
      home: HomeScreen(),
    );
  }
}

// Halaman HomeScreen
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Category> categories = [
    const Category(name: 'Makanan', icon: Icons.fastfood),
    const Category(name: 'Minuman', icon: Icons.local_drink),
    const Category(name: 'Elektronik', icon: Icons.devices),
    const Category(name: 'Otomotif', icon: Icons.two_wheeler),
    const Category(name: 'Tanaman', icon: Icons.local_florist),
    const Category(name: 'Baju', icon: Icons.checkroom),
    const Category(name: 'Celana', icon: Icons.kitesurfing),
    const Category(name: 'Dapur', icon: Icons.kitchen),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: const [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 10),
              Text('Cari di MyShop Mini...', style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Promo
            Container(
              width: double.infinity,
              height: 120,
              color: Colors.indigo[100],
              child: const Center(
                child: Text(
                  "DISKON HARI INI\nSAMPAI 70%",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("Kategori", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),

            // Bagian Kategori
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  
                  // --- PERBAIKAN UTAMA DI SINI ---
                  // 1. Menghapus properti 'borderRadius' agar tidak bentrok dengan 'shape'
                  // 2. Mengganti 'withOpacity' dengan 'withValues'
                  return Material(
                    color: Colors.white,
                    elevation: 2,
                    shadowColor: Colors.grey.withValues(alpha: 0.2), // PERBAIKAN WARNING
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => ProductListScreen(category: cat),
                      )),
                      hoverColor: Colors.indigo.withValues(alpha: 0.05), // PERBAIKAN WARNING
                      splashColor: Colors.indigo.withValues(alpha: 0.1), // PERBAIKAN WARNING
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat.icon, color: Colors.indigo, size: 28),
                          const SizedBox(height: 5),
                          Text(cat.name, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("Rekomendasi Untukmu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            
            Container(
              height: 200,
              color: Colors.white,
              child: const Center(child: Text("Scroll ke bawah untuk melihat produk lainnya")),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman ProductListScreen
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, required this.category});

  final Category category;

  List<Product> getProducts() {
    switch (category.name) {
      case 'Makanan':
        return [
          const Product(name: 'Nasi Goreng Spesial', icon: Icons.rice_bowl, price: 'Rp 25.000'),
          const Product(name: 'Ayam Bakar Madu', icon: Icons.restaurant, price: 'Rp 30.000'),
          const Product(name: 'Sate Ayam', icon: Icons.kebab_dining, price: 'Rp 20.000'),
        ];
      case 'Minuman':
        return [
          const Product(name: 'Es Teh Manis', icon: Icons.local_cafe, price: 'Rp 5.000'),
          const Product(name: 'Jus Alpukat', icon: Icons.local_drink, price: 'Rp 15.000'),
        ];
      case 'Elektronik':
        return [
          const Product(name: 'Headphone Bass', icon: Icons.headphones, price: 'Rp 150.000'),
          const Product(name: 'Mouse Gaming', icon: Icons.mouse, price: 'Rp 85.000'),
          const Product(name: 'Laptop Keren', icon: Icons.computer, price: 'Rp 5.000.000'),
        ];
      case 'Otomotif':
        return [
          const Product(name: 'Helm Full Face', icon: Icons.two_wheeler, price: 'Rp 350.000'),
          const Product(name: 'Oli Mesin', icon: Icons.build, price: 'Rp 45.000'),
          const Product(name: 'Sarung Tangan', icon: Icons.pan_tool, price: 'Rp 25.000'),
        ];
      case 'Tanaman':
        return [
          const Product(name: 'Kaktus Mini', icon: Icons.local_florist, price: 'Rp 15.000', location: 'Bandung'),
          const Product(name: 'Monstera', icon: Icons.grass, price: 'Rp 75.000'),
        ];
      case 'Baju':
        return [
          const Product(name: 'Kaos Polos Hitam', icon: Icons.checkroom, price: 'Rp 35.000'),
          const Product(name: 'Kemeja Flanel', icon: Icons.checkroom, price: 'Rp 99.000'),
        ];
      case 'Celana':
        return [
          const Product(name: 'Celana Chino', icon: Icons.kitesurfing, price: 'Rp 120.000'),
          const Product(name: 'Celana Jeans', icon: Icons.kitesurfing, price: 'Rp 150.000'),
        ];
      case 'Dapur':
        return [
          const Product(name: 'Wajan Anti Lengket', icon: Icons.kitchen, price: 'Rp 85.000'),
          const Product(name: 'Pisau Set', icon: Icons.restaurant_menu, price: 'Rp 40.000'),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(category.name, style: const TextStyle(color: Colors.black)),
        actions: const [
           Icon(Icons.search, color: Colors.black),
           SizedBox(width: 15),
           Icon(Icons.shopping_cart_outlined, color: Colors.black),
           SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Terpopuler"),
                Text("Terbaru"),
                Text("Terlaris"),
                Text("Harga"),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              children: getProducts().map((product) => Card(
                elevation: 2,
                color: Colors.white,
                margin: const EdgeInsets.all(6),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product),
                  )),
                  splashColor: Colors.orange.withValues(alpha: 0.2), // PERBAIKAN WARNING
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: Icon(product.icon, size: 60, color: Colors.grey[600]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name, 
                              maxLines: 2, 
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14)
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.price, 
                              style: const TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.deepOrange
                              )
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                Text(" ${product.location}", style: const TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman ProductDetailScreen
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: const BackButton(color: Colors.black)
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.white,
                    child: Icon(product.icon, size: 150, color: Colors.indigo),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.price, 
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange)
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.name, 
                          style: const TextStyle(fontSize: 18)
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            Text(" ${product.rating}/5.0", style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            Text("| Terjual 100+", style: TextStyle(color: Colors.grey[600])),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Deskripsi Produk", style: TextStyle(fontWeight: FontWeight.bold)),
                         SizedBox(height: 5),
                         Text("Ini adalah produk berkualitas tinggi yang sangat direkomendasikan untuk kebutuhan Anda sehari-hari."),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -2))],
            ),
            child: Row(
              children: [
                Column(
                  children: const [
                    Icon(Icons.chat, color: Colors.indigo),
                    Text("Chat", style: TextStyle(fontSize: 10)),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text("Tambah Troli"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text("Beli Sekarang"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}