class Data_Point {
  final String name;
  final String date;
  final int amount;


  const Data_Point({required this.name, required this.date, required this.amount, });

  @override
  String toString() {
    return 'Data_Point{name: $name, date: $date, amount: $amount}';
  }
}
