class TimeConvert {
  String secondToHourAndSecond(int? second) {
   
    int hour = second! ~/ 60;
    int sscond= (second % 60).toInt();

    return "$hour${"h"}$sscond${"m"}";
  }
}