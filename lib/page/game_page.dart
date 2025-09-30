import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kuis_prak_mobile/model/game_store_model.dart';

class DetailPage extends StatefulWidget {
  final GameModel game;

  const DetailPage({super.key, required this.game});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    String mainPricePart = widget.game.price.split(',')[0];
    final priceString = mainPricePart.replaceAll(RegExp(r'[^0-9]'), '');
    final price = double.parse(priceString);

    setState(() {
      _totalPrice = price * _quantity;
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _calculateTotalPrice();
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _calculateTotalPrice();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNetworkImage = widget.game.imageUrl.startsWith('http');
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 1, 49, 138),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Hero(
              tag: widget.game.imageUrl,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: isNetworkImage
                    ? Image.network(
                        widget.game.imageUrl,
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        widget.game.imageUrl,
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.game.gameName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: _decrementQuantity,
                              color: Colors.red,
                            ),
                            Text(
                              '$_quantity',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: _incrementQuantity,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        Text(
                          currencyFormatter.format(_totalPrice),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 49, 138),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 24),
                    const Text(
                      'About',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.game.gameDesc,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}