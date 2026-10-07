import 'package:flutter/material.dart';
import '../produk/produk_model.dart';
import 'main_navigation.dart';

class DetailProdukPage extends StatefulWidget {
  final ProdukParfum produk;
  const DetailProdukPage({super.key, required this.produk});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  // Notifikasi Atas
  void _tampilkanNotifikasiAtas(String judul, String pesan) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D34),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Color(0xFF66BB6A), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        judul,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pesan,
                        style: const TextStyle(fontSize: 11, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  void _tambahKeKeranjang() {
    setState(() {
      int index = keranjangBelanja.indexWhere((item) => item['produk'].id == widget.produk.id);
      if (index != -1) {
        keranjangBelanja[index]['jumlah'] += 1;
      } else {
        keranjangBelanja.add({
          "produk": widget.produk,
          "jumlah": 1,
          "dipilih": true,
        });
      }
      widget.produk.isSelected = false;
    });

    _tampilkanNotifikasiAtas(
      "Berhasil Ditambahkan!",
      "${widget.produk.nama} dimasukkan ke Keranjang Belanja 🛒",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0C3E),
        elevation: 0,
        title: const Text("Detail Aromatik", style: TextStyle(color: Colors.white, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.pink.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.produk.gambar,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image, size: 80, color: Colors.pink),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MYKONOS • ${widget.produk.ukuran}",
                              style: const TextStyle(color: Color(0xFFE2527A), fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.produk.nama,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2A2D34)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formatRupiah(widget.produk.harga),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),

                  const Text("Deskripsi Varian", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF7A0C3E))),
                  const SizedBox(height: 6),
                  Text(
                    widget.produk.deskripsi,
                    style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: const [
                      Text("Pyramid Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF7A0C3E))),
                      SizedBox(width: 6),
                      Icon(Icons.science_rounded, size: 18, color: Color(0xFF7A0C3E)),
                    ],
                  ),
                  const SizedBox(height: 10),

                  _buildNoteTile("Top Notes", widget.produk.topNotes, Icons.wb_sunny_outlined),
                  _buildNoteTile("Middle Notes", widget.produk.middleNotes, Icons.filter_vintage_outlined),
                  _buildNoteTile("Base Notes", widget.produk.baseNotes, Icons.eco_outlined),
                ],
              ),
            ),
          ),

          // BAR AKSI BAWAH
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.pink.shade100)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Wishlist Button
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.produk.isFavorite = !widget.produk.isFavorite;
                      });
                      _tampilkanNotifikasiAtas(
                        "Wishlist",
                        widget.produk.isFavorite ? "${widget.produk.nama} ditambahkan ke Wishlist ❤️" : "Dihapus dari Wishlist",
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.pink.shade100),
                      ),
                      child: Icon(
                        widget.produk.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFFE2527A),
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // kembali ke Tab Keranjang
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MainNavigation(initialIndex: 2)),
                            (route) => false,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.pink.shade100),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Color(0xFF7A0C3E),
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Tombol Tambah Ke Keranjang
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _tambahKeKeranjang,
                      icon: const Icon(Icons.add_shopping_cart_rounded, color: Colors.white, size: 18),
                      label: const Text(
                        "+ KERANJANG",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A0C3E),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNoteTile(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7A0C3E), size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          )
        ],
      ),
    );
  }
}