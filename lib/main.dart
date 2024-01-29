import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProgressBarNotification(),
    );
  }
}

class ProgressBarNotification extends StatefulWidget {
  const ProgressBarNotification({Key? key}) : super(key: key);

  @override
  State<ProgressBarNotification> createState() =>
      _ProgressBarNotificationState();
}

class _ProgressBarNotificationState extends State<ProgressBarNotification> {
  double _progress = 0.0;
  @override
  void initState() {
    super.initState();
  }

  void _simulateProgress() async {
    double progressNotification = 0;
    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _progress = i * .1;
        progressNotification = i * 10;
      });
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'progress_channel',
          title: 'Downloading file...',
          body: 'Progress: ${(_progress * 100).toInt()}%',
          notificationLayout: NotificationLayout.ProgressBar,
          progress: progressNotification,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Bar Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Progress: ${(_progress * 100).toInt()}%',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 20,
              lineHeight: 14,
              percent: _progress,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().initialize(
                  '',
                  [
                    NotificationChannel(
                      channelKey: 'progress_channel',
                      channelName: 'Progress notifications',
                      channelDescription:
                          'Notification channel for progress updates',
                      defaultColor: Colors.blue,
                      ledColor: Colors.white,
                      playSound: false,
                      importance: NotificationImportance.Low,
                      defaultRingtoneType: DefaultRingtoneType.Notification,
                    )
                  ],
                );
                _simulateProgress();
              },
              child: const Text("Mostrar Progresso"),
            ),
          ],
        ),
      ),
    );
  }
}
