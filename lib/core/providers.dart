import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/features/auth/model/user_repository.dart';
import 'package:authentication_template/notification/data/service/push_notification_service.dart';

final analyticsProvider = Provider((ref) => FirebaseAnalytics());
final pnProvider = Provider((ref) => PushNotificationService());

final userRepoProvider = ChangeNotifierProvider<UserRepository>((ref) {
  final notifService = ref.watch(pnProvider);
  return UserRepository.instance(notifService);
});
