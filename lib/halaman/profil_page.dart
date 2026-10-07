import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0C3E),
        title: Row(
          children: const [
            Text("Akun", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(width: 8),
            Icon(Icons.person_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Kartu Profil Utama
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFF7A0C3E),
                      child: Icon(Icons.person, size: 45, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Raden Krisna Satrio",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Raden.825240075@stu.untar.ac.id",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Chip(
                      avatar: const Icon(Icons.workspace_premium_rounded, size: 16, color: Color(0xFF7A0C3E)),
                      label: const Text("Mykonos VIP Member", style: TextStyle(fontSize: 11, color: Color(0xFF7A0C3E), fontWeight: FontWeight.bold)),
                      backgroundColor: const Color(0xFFFCE4EC),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Kartu Informasi Tugas Kelompok 3 UTS
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFF7A0C3E), width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.groups_rounded, color: Color(0xFF7A0C3E), size: 24),
                        SizedBox(width: 8),
                        Text(
                          "Informasi Kelompok 3 UTS",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF7A0C3E)),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    _buildInfoRow("Mata Kuliah", "Mobile Programming (SI34006)"),
                    _buildInfoRow("Dosen Pengampu", "Novario Jaya Perdana, S.Kom., M.T."),
                    _buildInfoRow("Program Studi", "Sistem Informasi - Untar"),
                    const SizedBox(height: 12),
                    const Text(
                      "Anggota Kelompok 3:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    _buildAnggotaTile("1. Raden Krisna Satrio", "NIM: 825240075 (Ketua)"),
                    _buildAnggotaTile("2. Lateef Ahmad Syaukany", "NIM: 825240145"),
                    _buildAnggotaTile("3. Hillary Natalia", "NIM: 825240086"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Menu Pengaturan & Pilihan
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_box_rounded, color: Color(0xFF7A0C3E)),
                    title: const Text("Data Diri & Pengaturan", style: TextStyle(fontSize: 13)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.favorite_rounded, color: Color(0xFF7A0C3E)),
                    title: const Text("Hobi & Preferensi", style: TextStyle(fontSize: 13)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded, color: Color(0xFF7A0C3E)),
                    title: const Text("Tentang Aplikasi Mykonos", style: TextStyle(fontSize: 13)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _buildAnggotaTile(String nama, String nim) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          Text(nim, style: const TextStyle(fontSize: 12, color: Color(0xFF7A0C3E), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}