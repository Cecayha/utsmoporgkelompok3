import 'package:flutter/material.dart';
import '../produk/produk_model.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    List<ProdukParfum> wishlistItems = daftarProdukParfum.where((p) => p.isFavorite).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0C3E),
        title: Row(
          children: const [
            Text("Wishlist Favorit", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(width: 8),
            Icon(Icons.favorite_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
      body: wishlistItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border, size: 70, color: Colors.pink),
            SizedBox(height: 12),
            Text("Belum ada varian Mykonos favoritmu.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(item.gambar, width: 50, height: 50, fit: BoxFit.cover),
              ),
              title: Text(item.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              subtitle: Text(formatRupiah(item.harga), style: const TextStyle(color: Color(0xFF7A0C3E))),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Color(0xFFE2527A)),
                onPressed: () {
                  setState(() {
                    item.isFavorite = false;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}