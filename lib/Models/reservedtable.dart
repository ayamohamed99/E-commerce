class ReservedTable {
  String resTableId;
  num tableNum;
  num chairNum;
  String restaurantId;
  String date;
  String time;

  ReservedTable({
    this.resTableId,
    this.chairNum,
    this.date,
    this.restaurantId,
    this.tableNum,
    this.time
  });

  ReservedTable.fromMap(Map snapshot, String id)
      : resTableId = id ?? '',
        tableNum = snapshot['tableNum'] ?? 0,
        chairNum = snapshot['chairNum'] ?? 0,
        date = snapshot['date'] ?? '',
        time = snapshot['time'] ?? '',
        restaurantId = snapshot['restaurantId'] ?? '';
        // timeRes =
        //     snapshot['timeRes'].map<String>((el) => el.toString()).toList() ??
                // [];

  toJson() {
    return {
      "resTableId": resTableId,
      "tableNum": tableNum,
      "chairNum": chairNum,
      "date": date,
      "time": time,
      "restaurantId": restaurantId,
      
      // "timeRes": timeRes,
      
    };
  }
}
