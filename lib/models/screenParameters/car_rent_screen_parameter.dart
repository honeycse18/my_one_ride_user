import 'package:flutter/material.dart';
import 'package:one_ride_user/models/api_responses/car_rent_details_response.dart';
import 'package:one_ride_user/models/enums.dart';

class CarRentScreenParameter {
  CarRentItem carRentDetails;
  RentCarStatusStatus messageTypeTab;
  int count;
  double totalAmount;
  DateTime selectedStartDate;
  TimeOfDay selectedStartTime;

  CarRentScreenParameter({
    required this.carRentDetails,
    required this.messageTypeTab,
    required this.count,
    required this.selectedStartDate,
    required this.selectedStartTime,
    required this.totalAmount,
  });
}

class SendLocationParams {
  double lat;
  double lng;
  bool withoutLogin;

  SendLocationParams({
    required this.lat,
    required this.lng,
    required this.withoutLogin,
  });
}
