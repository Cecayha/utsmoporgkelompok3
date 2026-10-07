import 'package:flutter/material.dart';
import '../produk/produk_model.dart';
import 'checkout_page.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    // Hitung total harga item yang tercentang
    int totalHarga = 0;
    int totalItemDipilih = 0;
    for (var item in keranjangBelanja) {
      if (item['dipilih'] == true) {
        ProdukParfum p = item['produk'];
        totalHarga += (p.harga * (item['jumlah'] as int));
        totalItemDipilih += (item['jumlah'] as int);
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0C3E),
        elevation: 0,
        title: Row(
          children: const [
            Text("Keranjang Belanja", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(width: 8),
            Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
      body: keranjangBelanja.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.remove_shopping_cart_rounded, size: 60, color: Colors.grey),
            SizedBox(height: 12),
            Text("Keranjangmu Masih Kosong", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
            SizedBox(height: 4),
            Text("Pilih parfum favoritmu di Beranda dulu ya!", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: keranjangBelanja.length,
              itemBuilder: (context, index) {
                final item = keranjangBelanja[index];
                ProdukParfum produk = item['produk'];
                int jumlah = item['jumlah'];
                bool dipilih = item['dipilih'];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: dipilih ? const Color(0xFF7A0C3E) : Colors.pink.shade100,
                      width: dipilih ? 1.5 : 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Checkboxnya Pilih Item
                        Checkbox(
                          activeColor: const Color(0xFF7A0C3E),
                          value: dipilih,
                          onChanged: (val) {
                            setState(() {
                              item['dipilih'] = val ?? false;
                            });
                          },
                        ),

                        // Gambar Produknya
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            produk.gambar,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image, size: 40, color: Colors.pink),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Nama & Harga
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produk.nama,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                formatRupiah(produk.harga),
                                style: const TextStyle(color: Color(0xFF7A0C3E), fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        // Pengatur Jumlah (+ / -) & Hapus
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (jumlah > 1) {
                                    item['jumlah'] -= 1;
                                  } else {
                                    keranjangBelanja.removeAt(index);
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF0F5),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.remove, size: 14, color: Color(0xFF7A0C3E)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text("$jumlah", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  item['jumlah'] += 1;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7A0C3E),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.add, size: 14, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Ringkasan Pembayaran & Tombol Checkout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.pink.shade100)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -3),
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Total ($totalItemDipilih produk)", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      Text(
                        formatRupiah(totalHarga),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E)),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: totalHarga > 0
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CheckoutPage()),
                      ).then((_) => setState(() {}));
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A0C3E),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Checkout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}