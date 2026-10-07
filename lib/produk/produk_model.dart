class ProdukParfum {
  final String id;
  final String nama;
  final String kategori;
  final int harga;
  final String gambar;
  final String deskripsi;
  final String topNotes;
  final String middleNotes;
  final String baseNotes;
  final String ukuran;
  bool isFavorite;
  int likes;
  bool isSelected;

  ProdukParfum({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.gambar,
    required this.deskripsi,
    required this.topNotes,
    required this.middleNotes,
    required this.baseNotes,
    this.ukuran = "100ml",
    this.isFavorite = false,
    this.likes = 12,
    this.isSelected = false,
  });
}

// 10 Data Resmi Mykonos
List<ProdukParfum> daftarProdukParfum = [
  ProdukParfum(
    id: "1",
    nama: "Mykonos Imperium",
    kategori: "Luxury Oud",
    harga: 799000,
    gambar: "https://officialmykonos.com/cdn/shop/files/imperium_100ml_2_1.jpg?v=1786634272&width=690",
    deskripsi: "Kemewahan berkelas tinggi dengan paduan kayu gaharu hangat, saffron emas, serta manisnya vanilla amber yang memikat.",
    topNotes: "Bergamot, Saffron",
    middleNotes: "Damask Rose, Cinnamon",
    baseNotes: "Oud Wood, Amber, Vanilla",
    likes: 54,
  ),
  ProdukParfum(
    id: "2",
    nama: "Mykonos Dreamscape",
    kategori: "Floral Sweet",
    harga: 449000,
    gambar: "https://officialmykonos.com/cdn/shop/files/dreamscape_50ml_1.jpg?v=1788871687&width=690",
    ukuran: "50ml",
    deskripsi: "Kelembutan bunga segar dan pear manis yang dibalut vanila creamy, seperti melangkah di dalam mimpi yang indah.",
    topNotes: "Pear, Peach Blossom",
    middleNotes: "Jasmine, Soft Peony",
    baseNotes: "Bourbon Vanilla, White Musk",
    likes: 42,
  ),
  ProdukParfum(
    id: "3",
    nama: "Mykonos Dark Secret",
    kategori: "Woody Spicy",
    harga: 799000,
    gambar: "https://officialmykonos.com/cdn/shop/files/DSPDP3.jpg?v=1762434891&width=690",
    deskripsi: "Karakter misterius yang elegan. Perpaduan cokelat pekat, kopi hangat, dan saus karamel lumer yang tahan seharian.",
    topNotes: "Pink Pepper, Nutmeg",
    middleNotes: "Dark Espresso, Cocoa",
    baseNotes: "Caramel, Sandalwood",
    likes: 68,
  ),
  ProdukParfum(
    id: "4",
    nama: "Mykonos Crimson",
    kategori: "Sensual Rose",
    harga: 799000,
    gambar: "https://officialmykonos.com/cdn/shop/files/sku_pic_3_crimson.jpg?v=1767772589&width=690",
    deskripsi: "Keanggunan mawar crimson merona bersatu dengan kehangatan kayu cedar dan sentuhan buah raspberry manis.",
    topNotes: "Fresh Raspberry, Bergamot",
    middleNotes: "Crimson Rose, Patchouli",
    baseNotes: "Cedarwood, Tonka Bean",
    likes: 31,
  ),
  ProdukParfum(
    id: "5",
    nama: "Mykonos Inferno",
    kategori: "Warm Intense",
    harga: 799000,
    gambar: "https://officialmykonos.com/cdn/shop/files/Inferno_100ml_1_2.jpg?v=1786634270&width=690",
    deskripsi: "Aroma hangat penuh pesona dengan karakter smoky amber, madu hutan, dan vanilla gourmand yang berani.",
    topNotes: "Smoky Incense, Tobacco",
    middleNotes: "Wild Honey, Spiced Tonka",
    baseNotes: "Warm Amber, Vanilla",
    likes: 45,
  ),
  ProdukParfum(
    id: "6",
    nama: "Mykonos Inception",
    kategori: "Fresh Citrus",
    harga: 449000,
    gambar: "https://officialmykonos.com/cdn/shop/files/skuinception3.jpg?v=1769063599&width=690",
    ukuran: "50ml",
    deskripsi: "Kesegaran buah jeruk sitrus dipadukan dengan garam laut dan bunga putih yang memberikan dorongan energi positif.",
    topNotes: "Grapefruit, Lemon Zest",
    middleNotes: "Lily of the Valley, Sea Salt",
    baseNotes: "White Musk, Vetiver",
    likes: 27,
  ),
  ProdukParfum(
    id: "7",
    nama: "Mykonos Moroccan Vanilla",
    kategori: "Gourmand Sweet",
    harga: 799000,
    gambar: "https://officialmykonos.com/cdn/shop/files/MVPDP3.jpg?v=1765964215&width=690",
    deskripsi: "Kehangatan vanila Maroko asli dipadu renyahnya almond dan mentega karamel yang memberikan aura manis eksotis.",
    topNotes: "Moroccan Vanilla, Almond",
    middleNotes: "Coconut Cream, White Orchid",
    baseNotes: "Brown Sugar, Sandalwood",
    likes: 89,
    isFavorite: true,
  ),
  ProdukParfum(
    id: "8",
    nama: "Mykonos Satin Blanc",
    kategori: "Soft Musky",
    harga: 799000,
    gambar: "https://officialmykonos.com/cdn/shop/files/satinPDP7.jpg?v=1762436181&width=690",
    deskripsi: "Sensasi kain sutra putih yang bersih dan tenang, dipadu aroma teh putih serta kelopak bunga melati yang halus.",
    topNotes: "White Tea, Bergamot",
    middleNotes: "White Musk, Jasmine",
    baseNotes: "Blonde Woods, Ambergris",
    likes: 58,
  ),
  ProdukParfum(
    id: "9",
    nama: "Mykonos Utopia",
    kategori: "Exotic Tropical",
    harga: 799000,
    gambar: "https://officialmykonos.com/cdn/shop/files/UtopPDP2.jpg?v=1762437457&width=690",
    deskripsi: "Suasana liburan musim panas tropis dengan wangi buah mangga segar, air kelapa muda, dan kayu hanyut pantai.",
    topNotes: "Ripe Mango, Passionfruit",
    middleNotes: "Coconut Water, Tiare Flower",
    baseNotes: "Driftwood, Soft Musk",
    likes: 39,
  ),
  ProdukParfum(
    id: "10",
    nama: "Mykonos Xoxo Rosy",
    kategori: "Cute Floral",
    harga: 449000,
    gambar: "https://officialmykonos.com/cdn/shop/files/xoxo_rosy_1.jpg?v=1781752058&width=690",
    ukuran: "50ml",
    deskripsi: "Sentuhan manis kelopak mawar pink, stroberi juicy, dan marshmallow lembut yang sangat ceria dan feminin.",
    topNotes: "Sweet Strawberry, Pink Pepper",
    middleNotes: "Damask Rose, Lychee",
    baseNotes: "Fluffy Marshmallow, Vanilla",
    likes: 76,
    isFavorite: true,
  ),
];

// Shopping Cart List
List<Map<String, dynamic>> keranjangBelanja = [
  {
    "produk": daftarProdukParfum[0],
    "jumlah": 1,
    "dipilih": true,
  },
  {
    "produk": daftarProdukParfum[6],
    "jumlah": 1,
    "dipilih": true,
  }
];

// mengubah angka mentah integer jadi format teks mata uang Rupiah
String formatRupiah(int value) {
  String str = value.toString();
  String result = '';
  int count = 0;
  for (int i = str.length - 1; i >= 0; i--) {
    result = str[i] + result;
    count++;
    if (count == 3 && i != 0) {
      result = '.$result';
      count = 0;
    }
  }
  return 'Rp $result';
}