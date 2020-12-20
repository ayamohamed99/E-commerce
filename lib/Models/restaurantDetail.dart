class RestaurantDetail {
  String name;
  String location;
  String img;
  num rate;
  String sort;
  String rId;
  num numSeats;
  num numTables;
  num timeRes;
  String description;
  

  RestaurantDetail(
      {this.name,this.description,this.numSeats,this.numTables,this.timeRes,
       this.location, this.img, this.rate, this.rId, this.sort});

  RestaurantDetail.fromMap(Map snapshot, String id)
      : rId = id ?? '',
        name = snapshot['name'] ?? '',
        location = snapshot['location'] ?? '',
        img = snapshot['img'] ?? '',
        sort = snapshot['sort'] ??'',
        rate = snapshot['rate'] ?? '' ,
        numSeats = snapshot['numSeats']??'',
        numTables = snapshot['numTables']??'',
        timeRes=snapshot['timeRes']??'',
        description=snapshot['description']??'';

        

  toJson() {
    return {
      "rId": rId,
      "name": name,
      "location": location,
      "img": img,
      "sort":sort,
      "rate": rate,
      "numSeats":numSeats,
      "numTables":numTables,
      "timeRes": timeRes,
      "description":description,
    };
  }
}
