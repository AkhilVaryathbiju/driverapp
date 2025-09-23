class Order {

  final int id;
  final String restaurantNAme;
  final double restaurantLat;
  final double restaurantLng;
  final String customerName;
  final double customerLat;
  final double customerLng;
  final double amount;

    Order({required this.id,
    required this.restaurantNAme,
    required this.restaurantLat,
    required this.customerLng,
    required this.amount,
    required this.customerLat,
    required this.customerName,
    required this.restaurantLng});
}