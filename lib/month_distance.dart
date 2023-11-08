class GDPData{
  GDPData(this.month,this.distance);
  final String month;
  final int distance;
  factory GDPData.fromJson(Map<String,dynamic> parsedJson){
    return GDPData(parsedJson["month"].toString(), parsedJson["distance"]);
  }
}