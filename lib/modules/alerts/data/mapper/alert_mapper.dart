import '../../domain/entity/alert.dart';
import '../model/json/alert_remote_model.dart';

class AlertMapper {
  static List<Alert> fromJson(dynamic json) {
    List<Alert> alerts = [];
    json.forEach((e) {
      final temp = AlertRemoteModel.fromJson(e);
      alerts.add(Alert(
          id: temp.id,
          title: temp.title,
          message: temp.message,
          isRead: temp.isRead,
          sentAt: temp.sentAt));
    });

    return alerts;
  }
}
