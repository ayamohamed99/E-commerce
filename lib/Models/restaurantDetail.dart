class RestaurantDetail {
  String name;
  String location;
  String img;
  num rate;
  String catId;
  String rId;

  num numSeats;
  num numTables;
  num timeRes;
  String description;
  

  RestaurantDetail(
      {this.name,this.description,this.numSeats,this.numTables,this.timeRes,
       this.location, this.img, this.rate, this.rId, this.catId});

  RestaurantDetail.fromMap(Map snapshot, String id)
      : rId = id ?? '',
        name = snapshot['name'] ?? '',
        location = snapshot['location'] ?? '',
        img = snapshot['img'] ?? '',
        catId = snapshot['catId'] ??'',
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
      "catId":catId,
      "rate": rate,
      "numSeats":numSeats,
      "numTables":numTables,
      "timeRes": timeRes,
      "description":description,
    };
  }
}
