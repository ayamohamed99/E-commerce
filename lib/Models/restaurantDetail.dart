class RestaurantDetail {
  String name;
  String location;
  String img;
  num rate;
  String sort;
  String rId;
  String description;
  String category;
  num numSeats;
  num numTables;
  num timeRes;

  

  RestaurantDetail(
      {this.name, this.location, this.img, this.rate, this.rId, this.sort,
      this.description, this.category, this.numSeats, this.numTables , this.timeRes});

  RestaurantDetail.fromMap(Map snapshot, String id)
      : rId = id ?? '',
        name = snapshot['name'] ?? '',
        location = snapshot['location'] ?? '',
        img = snapshot['img'] ?? '',
        sort = snapshot['sort'],
        description = snapshot[' description'],
        category = snapshot['category'],
        numSeats = snapshot[' numSeats'],
        numTables = snapshot['numTables'],
        timeRes = snapshot[' timeRes'],
        rate = snapshot['rate'] ?? '' ;
        

  toJson() {
    return {
      "rId": rId,
      "name": name,
      "location": location,
      "img": img,
      "sort":sort,
      "rate": rate,
      "description": description,
      "category": category,
      "numSeats": numSeats,
      "numTables": numTables,
      "timeRes":timeRes,

    };
  }
}
