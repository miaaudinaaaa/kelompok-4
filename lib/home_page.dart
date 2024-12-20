import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'product_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> flowers = [
    {
      'name': 'Rose',
      'image': 'https://i.pinimg.com/736x/b3/7f/06/b37f065e4cc8ba2778b22c238471435a.jpg',
      'description': 'Beautiful red rose.'
    },
    {
      'name': 'Tulip',
      'image': 'https://i.pinimg.com/736x/dc/5e/c8/dc5ec8aeed1baf9d3df2f01f42f2b41f.jpg',
      'description': 'Elegant tulip flower.'
    },
    {
      'name': 'Sunflower',
      'image': 'https://i.pinimg.com/736x/a8/19/a4/a819a45568d1322f9236759e1e4ad5d9.jpg',
      'description': 'Bright and cheerful sunflower.'
    },
    {
      'name': 'Lili',
      'image': 'https://i.pinimg.com/736x/b6/79/c4/b679c4fc12111c788bd394c088fcd692.jpg',
      'description': 'Beautiful Lili flower.'
    },
    {
      'name': 'Gerbera',
      'image': 'https://i.pinimg.com/736x/64/64/9c/64649c044eee78b9991c5a633f37f245.jpg',
      'description': 'Elegant Gerbera flower.'
    },
    {
      'name': 'Edelweis',
      'image': 'https://i.pinimg.com/736x/0b/5f/d6/0b5fd69560833a45dc85ee2d50016b7c.jpg',
      'description': 'A mountain flower that is beautiful and enduring.'
    },
  ];

  final List<Map<String, String>> cart = [];
  String searchQuery = '';

  void addToCart(Map<String, String> product) {
    setState(() {
      cart.add(product);
    });
  }

  void removeFromCart(Map<String, String> product) {
    setState(() {
      cart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredFlowers = flowers
        .where((flower) => flower['name']!
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flower Shop'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CartPage(cart: cart, removeFromCart: removeFromCart),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari bunga...',
                prefixIcon: Icon(Icons.search, color: Colors.pinkAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: filteredFlowers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8, // Bayangan agar kotak terlihat lebih jelas
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna dasar kotak
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.pinkAccent, // Border warna pink
                          width: 1.5,
                        ),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            filteredFlowers[index]['image']!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          filteredFlowers[index]['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        subtitle: Text(filteredFlowers[index]['description']!),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.pinkAccent,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                product: filteredFlowers[index],
                                addToCart: addToCart,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
