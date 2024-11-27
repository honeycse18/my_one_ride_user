class FakeIntroContent {
  String localSVGImageLocation;
  String slogan;
  String content;
  FakeIntroContent({
    this.localSVGImageLocation = '',
    this.slogan = '',
    this.content = '',
  });
}

class RecentSalesContent {
  String courseName;
  double price;
  RecentSalesContent({
    required this.courseName,
    required this.price,
  });
}

class FakeCancelRideReason {
  String reasonName;
  FakeCancelRideReason({
    this.reasonName = '',
  });
}

class FakeNotificationModel {
  String timeText;
  bool isRead;
  List<FakeNotificationTextModel> texts;
  FakeNotificationModel({
    required this.timeText,
    required this.isRead,
    required this.texts,
  });
}

class FakeNotificationTextModel {
  String text;
  bool isHashText;
  bool isColoredText;
  bool isBoldText;
  FakeNotificationTextModel({
    required this.text,
    this.isHashText = false,
    this.isColoredText = false,
    this.isBoldText = false,
  });
}
