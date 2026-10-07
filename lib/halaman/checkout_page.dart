import 'package:flutter/material.dart';
import '../produk/produk_model.dart';
import 'main_navigation.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String metodePembayaran = "E-Wallet (GoPay/OVO/Dana)";

  @override
  Widget build(BuildContext context) {
    // Ambil produk yang dipilih saja
    List<Map<String, dynamic>> itemDipilih =
    keranjangBelanja.where((item) => item['dipilih'] == true).toList();

    int totalBayar = 0;
    for (var item in itemDipilih) {
      ProdukParfum p = item['produk'];
      totalBayar += (p.harga * (item['jumlah'] as int));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0C3E),
        elevation: 0,
        title: Row(
          children: const [
            Text("Ringkasan Checkout", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(width: 8),
            Icon(Icons.assignment_turned_in_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.pink.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.location_on_rounded, color: Color(0xFF7A0C3E), size: 16),
                      SizedBox(width: 6),
                      Text("Alamat Pengiriman", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text("Kriswii - (0812-3456-7890)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  const Text("Jl. Kebon Jeruk No. 11, Jakarta Barat", style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Daftar Ringkasan Produk Yang Dibeli
            const Text("Item Yang Dibeli", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E), fontSize: 13)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemDipilih.length,
              itemBuilder: (context, index) {
                ProdukParfum p = itemDipilih[index]['produk'];
                int jumlah = itemDipilih[index]['jumlah'];
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.pink.shade100),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(p.gambar, width: 40, height: 40, fit: BoxFit.cover),
                    ),
                    title: Text(p.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    subtitle: Text("${jumlah}x • ${formatRupiah(p.harga)}", style: const TextStyle(fontSize: 11)),
                    trailing: Text(
                      formatRupiah(p.harga * jumlah),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E), fontSize: 12),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Pilih Metode Pembayaran
            const Text("Metode Pembayaran", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E), fontSize: 13)),
            const SizedBox(height: 8),
            _buildMetodeCard("E-Wallet (GoPay/OVO/Dana)"),
            _buildMetodeCard("Transfer Bank (BCA/Mandiri)"),
            _buildMetodeCard("COD (Bayar di Tempat)"),

            const SizedBox(height: 20),

            // Rincian Biaya
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.pink.shade100),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal Produk", style: TextStyle(fontSize: 12)),
                      Text(formatRupiah(totalBayar), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Biaya Pengiriman (Express)", style: TextStyle(fontSize: 12)),
                      Text("Rp 15.000", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Pembayaran", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(
                        formatRupiah(totalBayar + 15000),
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E), fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Tombol Bayar Sekarang
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Row(
                      children: const [
                        Icon(Icons.check_circle_rounded, color: Colors.green, size: 26),
                        SizedBox(width: 8),
                        Text("Pesanan Berhasil!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    content: const Text(
                      "Terima kasih telah berbelanja di Mykonos Official Store. Pesananmu segera diproses!",
                      style: TextStyle(fontSize: 12),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Membersihkan produk yang sudah dibeli dari keranjang
                          setState(() {
                            keranjangBelanja.removeWhere((item) => item['dipilih'] == true);
                          });

                          Navigator.pop(ctx);

                          // Kembali ke Beranda Utama
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainNavigation(initialIndex: 0)),
                                (route) => false,
                          );
                        },
                        child: const Text("OK", style: TextStyle(color: Color(0xFF7A0C3E), fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7A0C3E),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Bayar Sekarang", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  SizedBox(width: 8),
                  Icon(Icons.payment_rounded, color: Colors.white, size: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMetodeCard(String title) {
    bool isSelected = (metodePembayaran == title);
    return Card(
      elevation: 0,
      color: isSelected ? const Color(0xFFFFF0F5) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected ? const Color(0xFF7A0C3E) : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: ListTile(
        dense: true,
        title: Text(title, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        trailing: Icon(
          isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
          color: isSelected ? const Color(0xFF7A0C3E) : Colors.grey,
          size: 20,
        ),
        onTap: () {
          setState(() {
            metodePembayaran = title;
          });
        },
      ),
    );
  }
}