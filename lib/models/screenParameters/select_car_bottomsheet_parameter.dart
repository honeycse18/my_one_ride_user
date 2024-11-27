import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/models/location_model.dart';

class SelectCarBottomSheetParameter {
  LocationModel pickupLocation;
  LocationModel dropLocation;
  NearestCarsListData nearestCarsListData;
  SelectCarBottomSheetParameter(
      {required this.pickupLocation,
      required this.dropLocation,
      required this.nearestCarsListData});
}
