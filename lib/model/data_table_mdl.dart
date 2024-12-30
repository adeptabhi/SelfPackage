class DataTableMdl {
  final String id;
  final String name;
  final String description;
  final String status;
  final double amount;
  final DateTime date;

  DataTableMdl({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.amount,
    required this.date,
  });

  String toAdd() {
    return (id +
            name +
            description +
            status +
            amount.toString() +
            date.toString())
        .toLowerCase();
  }
}
