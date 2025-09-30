class GameModel {
  String gameName;
  String imageUrl;
  String gameDesc;
  String gamePublisher;
  String gamePublishDate;
  String price;
  int totalLike;

  GameModel({
    required this.gameName,
    required this.imageUrl,
    required this.gameDesc,
    required this.gamePublisher,
    required this.gamePublishDate,
    required this.price,
    required this.totalLike,
  });
}