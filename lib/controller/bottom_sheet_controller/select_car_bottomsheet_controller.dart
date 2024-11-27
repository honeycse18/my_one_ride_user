/* import 'package:get/get.dart';
import 'package:one_ride_user/controller/select_car_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/select_car_bottomsheet_parameter.dart';

class SelectCarBottomSheetController extends GetxController {
  SelectCarBottomSheetParameter? screenParameter;
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  NearestCarsListData nearestCarsListData = NearestCarsListData();
  List<NearestCarsListRide> rides = [];
  List<NearestCarsListCategory> categories = [];

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SelectCarBottomSheetParameter) {
      screenParameter = params;
      nearestCarsListData = params.nearestCarsListData;
      pickupLocation = screenParameter!.pickupLocation;
      dropLocation = screenParameter!.dropLocation;
      update();
      rides = nearestCarsListData.rides;
      categories = nearestCarsListData.categories;
      update();
    }
  }
/* _assignParameters() async {
    var pickupIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20, 20)),
        AppAssetImages.pickupMarkerPngIcon);
    var dropIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20, 20)),
        AppAssetImages.dropMarkerPngIcon);
    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerId),
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickupIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropIcon));

    update();
  } */

  @override
  void onInit() {
    _getScreenParameters();
    var screenController = Get.find<>();
    // _assignParameters();
    super.onInit();
  }
}
 */
