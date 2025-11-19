import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('UTB Futsal APPS'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const ElegantHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: const [
                SectionTitle(title: 'Berita Terbaru'),
                SizedBox(height: 8),
                NewsList(),
                SizedBox(height: 20),
                SectionTitle(title: 'Produk UTB'),
                SizedBox(height: 8),
                ProductList(),
                SizedBox(height: 20),
                SectionTitle(title: 'Player UTB'),
                SizedBox(height: 8),
                PlayerList(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fitur tambah produk segera hadir!')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}

// --- Elegant Header dengan shimmer ---
class ElegantHeader extends StatefulWidget {
  const ElegantHeader({super.key});

  @override
  State<ElegantHeader> createState() => _ElegantHeaderState();
}

class _ElegantHeaderState extends State<ElegantHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shineAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _shineAnim = Tween<double>(
      begin: -1,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade300.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- LOGO dengan shimmer ---
          AnimatedBuilder(
            animation: _shineAnim,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.1),
                    ],
                    stops: [
                      _shineAnim.value - 0.2,
                      _shineAnim.value,
                      _shineAnim.value + 0.2,
                    ],
                  ).createShader(rect);
                },
                blendMode: BlendMode.srcATop,
                child: child,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/logo.jpg',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // --- Info Klub ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UTB FUTSAL CLUB',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Berita terkini, produk unggulan, dan profil pemain',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          // --- Tombol Profil ---
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buka profil UTB Futsal!')),
              );
            },
            icon: const Icon(Icons.person_outline, size: 18),
            label: const Text('Profil'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Section Title ---
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.sports_soccer, color: Colors.blue.shade900, size: 20),
        const SizedBox(width: 6),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}

// --- News List ---
class NewsList extends StatelessWidget {
  const NewsList({super.key});

  final List<Map<String, String>> _news = const [
    {
      'title': 'UTB Menang Adu Penalti di Turnamen Lokal',
      'subtitle': 'UTB vs Unikom',
      'image': 'assets/images/match1.jpg',
    },
    {
      'title': 'UTB Menang 2-0 di Turnamen Daerah',
      'subtitle': 'UTB vs UPI PWK',
      'image': 'assets/images/match2.jpg',
    },
    {
      'title': 'UTB Kalah Tipis Lewat Adu Penalti',
      'subtitle': 'UTB vs UPI Bandung (Electro)',
      'image': 'assets/images/match3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: _news.map((n) => NewsCard(data: n)).toList());
  }
}

class NewsCard extends StatelessWidget {
  final Map<String, String> data;
  const NewsCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(data['title']!),
              content: Text(data['subtitle']!),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
              child: Image.asset(
                data['image']!,
                width: 110,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data['subtitle']!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Product List ---
class ProductList extends StatelessWidget {
  const ProductList({super.key});

  static final List<Map<String, String>> _products = [
    {
      'name': 'Sepatu Futsal UTB',
      'price': 'Rp 450.000',
      'image': 'assets/images/sepatu.jpg',
    },
    {
      'name': 'Kaos Tim UTB',
      'price': 'Rp 200.000',
      'image': 'assets/images/jersey.jpg',
    },
    {
      'name': 'Bola UTB Official',
      'price': 'Rp 180.000',
      'image': 'assets/images/bola.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final p = _products[i];
          return ProductCard(
            name: p['name']!,
            price: p['price']!,
            image: p['image']!,
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  const ProductCard({
    required this.name,
    required this.price,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Player List dengan animasi interaktif ---
class PlayerList extends StatelessWidget {
  const PlayerList({super.key});

  final List<Map<String, String>> _players = const [
    {'name': 'Hasbi', 'role': 'Anchor', 'image': 'assets/images/player1.jpg'},
    {'name': 'Bang Jey', 'role': 'Wing', 'image': 'assets/images/player2.jpg'},
    {
      'name': 'Deden',
      'role': 'Goalkeeper',
      'image': 'assets/images/player3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: _players.map((p) => PlayerTile(data: p)).toList());
  }
}

class PlayerTile extends StatefulWidget {
  final Map<String, String> data;
  const PlayerTile({required this.data, super.key});

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _big ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: GestureDetector(
        onTap: () => setState(() => _big = !_big),
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(widget.data['image']!),
            ),
            title: Text(
              widget.data['name']!,
              style: TextStyle(color: Colors.blue.shade900, fontSize: 16),
            ),
            subtitle: Text(
              widget.data['role']!,
              style: const TextStyle(color: Colors.black54),
            ),
            trailing: Icon(
              _big ? Icons.expand_less : Icons.expand_more,
              color: Colors.blue.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
