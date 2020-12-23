class TrainDetails{
  String arrival;
  String departure;
  String park;
  String refno;
  String station;
  String crossing;

  TrainDetails(this.arrival, this.departure, this.park, this.refno,
      this.station, this.crossing);

  TrainDetails.fromJson(Map<String,dynamic> json){
    arrival = json['arrival'];
    departure = json['departure'];
    park = json['park'];
    refno = json['refno'];
    station = json['station'];
    crossing = json['crossing'];

  }
}