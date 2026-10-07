import 'package:flutter/material.dart';
import '../produk/produk_model.dart';
import 'detail_produk_page.dart';

class BerandaPage extends StatefulWidget {
  final VoidCallback? onPindahKeKeranjang;
  const BerandaPage({super.key, this.onPindahKeKeranjang});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
//VARIABEL DATA & FILTER
  String kategoriTerpilih = "Semua";
  String kataKunciCari = "";
  final TextEditingController _searchController = TextEditingController();

  final List<String> daftarKategori = [
    "Semua",
    "Luxury Oud",
    "Floral Sweet",
    "Gourmand Sweet",
    "Woody Spicy",
    "Fresh Citrus"
  ];

  //Notifikasi Melayang buat keranjang
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

  // Long Press
  void _tampilkanQuickPreview(BuildContext context, ProdukParfum produk) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(produk.gambar, width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produk.nama,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          formatRupiah(produk.harga),
                          style: const TextStyle(color: Color(0xFF7A0C3E), fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text("Quick Notes Preview:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF7A0C3E))),
              const SizedBox(height: 6),
              Text("• Top Notes: ${produk.topNotes}", style: const TextStyle(fontSize: 12)),
              Text("• Middle Notes: ${produk.middleNotes}", style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
              Text("• Base Notes: ${produk.baseNotes}", style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailProdukPage(produk: produk)),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                  label: const Text("Lihat Detail Selengkapnya", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A0C3E),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //Logika untuk tambah keranjangnyaa
  void _tambahKeKeranjangDirect(ProdukParfum produk) {
    setState(() {
      int index = keranjangBelanja.indexWhere((item) => item['produk'].id == produk.id);
      if (index != -1) {
        keranjangBelanja[index]['jumlah'] += 1;
      } else {
        keranjangBelanja.add({
          "produk": produk,
          "jumlah": 1,
          "dipilih": true,
        });
      }
    });
    _tampilkanNotifikasiAtas(
      "Keranjang Berhasil Ditambahkan!",
      "${produk.nama} masuk ke keranjang belanja 🛒",
    );
  }

  @override
  Widget build(BuildContext context) {
    // logika filter pencarian dan kategori
    List<ProdukParfum> produkTampil = daftarProdukParfum.where((p) {
      bool cocokKategori = (kategoriTerpilih == "Semua") || (p.kategori == kategoriTerpilih);
      bool cocokCari = kataKunciCari.isEmpty || p.nama.toLowerCase().contains(kataKunciCari.toLowerCase());
      return cocokKategori && cocokCari;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),

      //App bar my konos
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF7A0C3E),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white30),
              ),
              child: const Text(
                "MYKONOS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 2.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "PARFUM",
              style: TextStyle(fontSize: 12, color: Color(0xFFFCE4EC), fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      kataKunciCari = val;
                    });
                  },
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search_rounded, color: Color(0xFF7A0C3E), size: 20),
                    hintText: "Cari varian Mykonos (misal: Imperium, Vanilla)...",
                    hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                    border: InputBorder.none,
                    suffixIcon: kataKunciCari.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, size: 18, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          kataKunciCari = "";
                        });
                      },
                    )
                        : null,
                  ),
                ),
              ),
            ),

            // banner nyaa
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF7A0C3E), Color(0xFFE2527A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7A0C3E).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "Luxury Line",
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 14),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Official Mykonos Store",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Tap 1x: Detail | Double Tap: Suka | Long Press: Preview",
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.auto_awesome_rounded, size: 40, color: Colors.white),
                ],
              ),
            ),

            // chipsnya kategori aroma
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                "Kategori Varian Aroma",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E)),
              ),
            ),
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: daftarKategori.length,
                itemBuilder: (context, index) {
                  bool isSelected = kategoriTerpilih == daftarKategori[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(daftarKategori[index]),
                      selected: isSelected,
                      selectedColor: const Color(0xFF7A0C3E),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: isSelected ? const Color(0xFF7A0C3E) : Colors.pink.shade100,
                      ),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF7A0C3E),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 11,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          kategoriTerpilih = daftarKategori[index];
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // judul katalog
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Katalog Produk",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E)),
                  ),
                  Text(
                    "${produkTampil.length} Varian Ditemukan",
                    style: TextStyle(color: Colors.pink.shade800, fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            if (produkTampil.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text("Produk yang kamu cari tidak ditemukan", style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.58,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: produkTampil.length,
                itemBuilder: (context, index) {
                  final item = produkTampil[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProdukPage(produk: item),
                        ),
                      );
                    },

                    onDoubleTap: () {
                      setState(() {
                        item.likes++;
                        item.isFavorite = true;
                      });
                    },

                    onLongPress: () {
                      _tampilkanQuickPreview(context, item);
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
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          item.isFavorite ? Icons.favorite : Icons.favorite_border,
                                          color: const Color(0xFFE2527A),
                                          size: 12,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          "${item.likes}",
                                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

                                // tombol tambah keranjang
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ElevatedButton.icon(
                                    onPressed: () => _tambahKeKeranjangDirect(item),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}