import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

/// Notification Service for EGet
/// Handles local notifications for budget alerts
class NotificationService {
    NotificationService._();
    static final NotificationService instance = NotificationService._();

    final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
    bool _initialized = false;

    /// Initialize notification service
    Future<void> initialize() async {
          if (_initialized) return;

          const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
          const iosSettings = DarwinInitializationSettings(
                  requestAlertPermission: true,
                  requestBadgePermission: true,
                  requestSoundPermission: true,
                );

          const initSettings = InitializationSettings(
                  android: androidSettings,
                  iOS: iosSettings,
                );

          await _notifications.initialize(
                  initSettings,
                  onDidReceiveNotificationResponse: _onNotificationTap,
                );

          _initialized = true;
          debugPrint('NotificationService initialized');
    }

    /// Handle notification tap
    void _onNotificationTap(NotificationResponse response) {
          debugPrint('Notification tapped: ${response.payload}');
    }

    /// Request notification permissions
    Future<bool> requestPermission() async {
          final android = _notifications.resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>();

          if (android != null) {
                  final granted = await android.requestNotificationsPermission();
                  return granted ?? false;
          }

          final ios = _notifications.resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>();

          if (ios != null) {
                  final granted = await ios.requestPermissions(
                            alert: true,
                            badge: true,
                            sound: true,
                          );
                  return granted ?? false;
          }

          return false;
    }

    /// Show budget alert notification
    Future<void> showBudgetAlert({
          required String title,
          required String body,
          String? payload,
    }) async {
          const androidDetails = AndroidNotificationDetails(
                  'budget_alerts',
                  'Alertas de Orçamento',
                  channelDescription: 'Notificações sobre seu orçamento mensal',
                  importance: Importance.high,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher',
                  color: Color(0xFFFF6B35),
                  enableVibration: true,
                  playSound: true,
                );

          const iosDetails = DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                );

          const details = NotificationDetails(
                  android: androidDetails,
                  iOS: iosDetails,
                );

          await _notifications.show(
                  DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  title,
                  body,
                  details,
                  payload: payload,
                );
    }

    /// Show threshold alert (80%, 90%, 100%)
    Future<void> showThresholdAlert({
          required int percentage,
          required String userName,
          required String customMessage,
          required double currentSpent,
          required double budget,
          required int daysRemaining,
    }) async {
          // Replace template variables
          String message = customMessage
                    .replaceAll('{nome}', userName)
                    .replaceAll('{percentual}', '$percentage%')
                    .replaceAll('{teto}', 'R\$ ${budget.toStringAsFixed(2)}')
                    .replaceAll('{gasto_atual}', 'R\$ ${currentSpent.toStringAsFixed(2)}')
                    .replaceAll('{dias_restantes}', '$daysRemaining');

          String title;
          if (percentage >= 100) {
                  title = '⚠️ Teto atingido!';
          } else if (percentage >= 90) {
                  title = '🔴 Alerta: $percentage% do teto';
          } else {
                  title = '🟡 Atenção: $percentage% do teto';
          }

          await showBudgetAlert(
                  title: title,
                  body: message,
                  payload: 'threshold_$percentage',
                );
    }

    /// Show projection alert
    Future<void> showProjectionAlert({
          required String userName,
          required double projectedSpent,
          required double budget,
          required int daysRemaining,
    }) async {
          final title = '📊 Projeção de gastos';
          final body = 'Sr(a). $userName, sua projeção de gastos para este mês é de '
                    'R\$ ${projectedSpent.toStringAsFixed(2)}, '
                    'acima do seu teto de R\$ ${budget.toStringAsFixed(2)}. '
                    'Restam $daysRemaining dias no mês.';

          await showBudgetAlert(
                  title: title,
                  body: body,
                  payload: 'projection',
                );
    }

    /// Cancel all notifications
    Future<void> cancelAll() async {
          await _notifications.cancelAll();
    }

    /// Cancel notification by ID
    Future<void> cancel(int id) async {
          await _notifications.cancel(id);
    }
}

// Color class for notification (Android)
class Color {
    final int value;
    const Color(this.value);
}
