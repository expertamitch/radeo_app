import 'package:get/get.dart';
import 'package:redeo/models/notification_list_model.dart';
import 'package:redeo/models/payment_intent_model.dart';

import '../../models/plans_model.dart';
import '../../network/internet_exception.dart';
import '../../network/repository/backend_repo.dart';
import '../../utils/snackbar_util.dart';

class AlertsController extends GetxController {
  RxBool notificationsLoading = false.obs;
  RxList<NotificationData> notificationsList = RxList();
  RxBool notificationsListLoading = false.obs;
  NotificationListModel? notificationListModel = null;

  Future<bool> getNotifications() async {
    try {
      notificationsList.clear();
      notificationsListLoading.value = true;
      notificationListModel = await BackendRepo().getAlerts();
      notificationsList.value = notificationListModel!.info?.data ?? [];
      notificationsListLoading.value = false;
      return true;
    } on InternetException {
      notificationsListLoading.value = false;
      return false;
    } catch (e) {
      notificationsListLoading.value = false;
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> getPaginatedNotificationsList() async {
    try {
      notificationListModel = await BackendRepo()
          .getAlerts(path: notificationListModel!.info!.nextPageUrl!);
      notificationsList.value.addAll(notificationListModel!.info?.data ?? []);
      notificationsListLoading.value = false;
      notificationsList.refresh();
      return true;
    } on InternetException {
      return false;
    } catch (e) {
      showErrorSnackBar(e.toString());

      return false;
    }
  }
}
