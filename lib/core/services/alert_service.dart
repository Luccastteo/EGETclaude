import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_service.dart';

/// Alert Service - Smart Budget Alerts
class AlertService {
    AlertService._();
    static final AlertService instance = AlertService._();

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final NotificationService _notifications = NotificationService.instance;

    Future<void> checkAlerts({
          required String userId,
          required String userName,
          required double currentSpent,
          required double budget,
          required String customMessage,
    }) async {
          if (budget <= 0) return;
          final percentage = (currentSpent / budget * 100).round();
          await _checkThresholdAlert(userId: userId, userName: userName, percentage: percentage, currentSpent: currentSpent, budget: budget, customMessage: customMessage);
          await _checkProjectionAlert(userId: userId, userName: userName, currentSpent: currentSpent, budget: budget);
    }

    Future<void> _checkThresholdAlert({required String userId, required String userName, required int percentage, required double currentSpent, required double budget, required String customMessage}) async {
          final thresholds = [80, 90, 100];
          final currentMonth = _getCurrentMonth();
          final daysRemaining = _getDaysRemaining();
          for (final threshold in thresholds) {
                  if (percentage >= threshold) {
                            final alreadyNotified = await _hasBeenNotified(userId: userId, alertType: 'threshold_$threshold', month: currentMonth);
                            if (!alreadyNotified) {
                                        await _notifications.showThresholdAlert(percentage: threshold, userName: userName, customMessage: customMessage, currentSpent: currentSpent, budget: budget, daysRemaining: daysRemaining);
                                        await _logNotification(userId: userId, alertType: 'threshold_$threshold', month: currentMonth);
                            }
                  }
          }
    }

    Future<void> _checkProjectionAlert({required String userId, required String userName, required double currentSpent, required double budget}) async {
          final now = DateTime.now();
          final daysPassed = now.day;
          final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
          if (daysPassed < 5) return;
          final dailyAverage = currentSpent / daysPassed;
          final projectedSpent = dailyAverage * daysInMonth;
          if (projectedSpent > budget) {
                  final currentMonth = _getCurrentMonth();
                  final alreadyNotified = await _hasBeenNotified(userId: userId, alertType: 'projection', month: currentMonth);
                  if (!alreadyNotified) {
                            await _notifications.showProjectionAlert(userName: userName, projectedSpent: projectedSpent, budget: budget, daysRemaining: daysInMonth - daysPassed);
                            await _logNotification(userId: userId, alertType: 'projection', month: currentMonth);
                  }
          }
    }

    Future<bool> _hasBeenNotified({required String userId, required String alertType, required String month}) async {
          try {
                  final doc = await _firestore.collection('users').doc(userId).collection('notificationLogs').doc('${alertType}_$month').get();
                  return doc.exists;
          } catch (e) { return false; }
    }

    Future<void> _logNotification({required String userId, required String alertType, required String month}) async {
          await _firestore.collection('users').doc(userId).collection('notificationLogs').doc('${alertType}_$month').set({'alertType': alertType, 'month': month, 'sentAt': FieldValue.serverTimestamp()});
    }

    String _getCurrentMonth() { final now = DateTime.now(); return '${now.year}-${now.month.toString().padLeft(2, '0')}'; }
    int _getDaysRemaining() { final now = DateTime.now(); return DateTime(now.year, now.month + 1, 0).day - now.day; }
}
