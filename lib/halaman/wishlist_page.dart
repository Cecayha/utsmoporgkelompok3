import 'package:flutter/material.dart';
import '../produk/produk_model.dart';
import 'detail_produk_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    //  AMBIL PRODUK DENGAN STATUS FAVORIT = TRUE SECARA REALTIME
    final produkFavorit = daftarProdukParfum.where((p) => p.isFavorite).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),

      //APPBAR WISHLIST
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0C3E),
        elevation: 0,
        title: Row(
          children: const [
            Text("Wishlist Favorit", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Icon(Icons.favorite_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),

      // TAMPILAN WISHLIST
      body: produkFavorit.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border_rounded, size: 60, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              "Belum Ada Produk Favorit",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 4),
            Text(
              "Double tap produk di Beranda buat masukin ke sini!",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.58,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: produkFavorit.length,
        itemBuilder: (context, index) {
          final item = produkFavorit[index];

          return GestureDetector(
            // Tap: Buka Halaman Detail Produk
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProdukPage(produk: item),
                ),
              ).then((_) => setState(() {}));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.pink.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.shade100.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GAMBAR DAN TOMBOL HAPUS FAVORIT
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(
                            item.gambar,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stack) => Container(
                              color: Colors.pink.shade50,
                              child: const Center(
                                child: Icon(Icons.broken_image, color: Colors.pink),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                item.isFavorite = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: Color(0xFFE2527A),
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // INFORMASI NAMA & HARGA
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "MYKONOS • ${item.ukuran}",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.pink.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          formatRupiah(item.harga),
                          style: const TextStyle(
                            color: Color(0xFF7A0C3E),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // TOMBOL DAN KERANJANG DARI WISHLIST
                        SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                int idx = keranjangBelanja.indexWhere((k) => k['produk'].id == item.id);
                                if (idx != -1) {
                                  keranjangBelanja[idx]['jumlah'] += 1;
                                } else {
                                  keranjangBelanja.add({
                                    "produk": item,
                                    "jumlah": 1,
                                    "dipilih": true,
                                  });
                                }
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${item.nama} masuk ke keranjang! 🛒"),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: const Color(0xFF7A0C3E),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add_shopping_cart, size: 13, color: Colors.white),
                            label: const Text(
                              "+ KERANJANG",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7A0C3E),
                              elevation: 0,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}