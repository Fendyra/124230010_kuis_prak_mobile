import 'package:flutter/material.dart';
import 'package:kuis_prak_mobile/auth/login_page.dart';
import 'package:kuis_prak_mobile/data/game_store.dart';
import 'package:kuis_prak_mobile/model/game_store_model.dart';
import 'package:kuis_prak_mobile/page/game_page.dart'; // Impor DetailPage

class HomePage extends StatelessWidget {
  final String username;
  String get getUsername => username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 49, 138),
        centerTitle: true,
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Center(
            child: Text(
              'Hi, $username!',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        title: Image.asset(
          'assets/images/logo-game.png',
          height: 150,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_outlined),
            color: Colors.white,
          ),
        ],
      ),

      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/logo-game.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Search Your Favorite Game',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.60, // Sedikit diubah agar tombol muat
              ),
              itemBuilder: (context, index) {
                final GameModel game = gameList[index];
                return _gameCard(context, game); // Kirim context
              },
              itemCount: gameList.length,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _gameCard(BuildContext context, GameModel game) {
    bool isNetworkImage = game.imageUrl.startsWith('http');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(game: game),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Hero(
                  tag: game.imageUrl, 
                  child: isNetworkImage
                      ? Image.network(
                          game.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Icon(Icons.image_not_supported_outlined)
                            );
                          },
                        )
                      : Image.asset(
                          game.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Icon(Icons.broken_image_outlined)
                            );
                          },
                        ),
                ),
              ),
              Expanded(
                flex: 5, 
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.gameName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        game.gameDesc,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        game.totalLike.toString() + ' Likes',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Tombol Order
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(game: game),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 1, 49, 138),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'View Details',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}