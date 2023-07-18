// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter_background_executor/flutter_background_executor.dart';
// import 'package:flutter/material.dart';
//
//
//
//
// class MyAppBackground extends StatefulWidget {
//   const MyAppBackground({Key? key}) : super(key: key);
//
//   @override
//   State<MyAppBackground> createState() => _MyAppBackgroundState();
// }
//
// class _MyAppBackgroundState extends State<MyAppBackground> {
//   final _backgroundExecutor = FlutterBackgroundExecutor();
//   String? _message;
//   String? _taskStatus;
//
//   Future<void> _startImmediatelyClick() async {
//     final result = await _backgroundExecutor.runImmediatelyBackgroundTask(
//       callback: immediately,
//       cancellable: true,
//       withMessages: true,
//     );
//     result.connector?.messageStream.listen((event) {});
//     _backgroundExecutor.createConnector().messageStream.listen((event) {
//       if (!mounted) return;
//       setState(() {
//         _message = 'Message from ${event.from}:\n${event.content}';
//       });
//     });
//   }
//
//   Future<void> _planRefreshTaskClick() async {
//     final response = await _backgroundExecutor.createRefreshTask(
//       callback: refresh,
//       settings: RefreshTaskSettings(
//         androidDetails:
//         AndroidRefreshTaskDetails(initialDelay: Duration(seconds: 10)),
//         iosDetails:
//         IosRefreshTaskDetails(taskIdentifier: 'com.calling.truecaller'),
//       ),
//     );
//     if (Platform.isIOS) {
//       print(
//           'To simulate the refresh task you can use next command:'
//               ' "e -l objc -- (void)[[BGTaskScheduler sharedScheduler]'
//               ' _simulateLaunchForTaskWithIdentifier:@"com.dsr_corporation.task1"]"');
//     }
//   }
//
//   Future<void> _checkBackgroundTaskClick() async {
//     final response = await _backgroundExecutor.isTaskRunning();
//     if (!mounted) return;
//     setState(() {
//       _taskStatus = response
//           ? 'The background task is running'
//           : 'The background task is not running';
//     });
//   }
//
//   Future<void> _checkRefreshTaskClick() async {
//     final response = await _backgroundExecutor.isRefreshTaskRunning();
//     if (!mounted) return;
//     setState(() {
//       _taskStatus = response
//           ? 'The refresh task is running'
//           : 'The refresh task is not running';
//     });
//   }
//
//   Future<void> _checkAnyTaskClick() async {
//     final response = await _backgroundExecutor.hasRunningTasks();
//     if (!mounted) return;
//     setState(() {
//       _taskStatus =
//       response ? 'Some task is running' : 'Some task is not running';
//     });
//   }
//
//   Future<void> _stopBackgroundTaskClick() async {
//     await _backgroundExecutor.stopExecutingTask();
//   }
//
//   Future<void> _stopRefreshTaskClick() async {
//     await _backgroundExecutor.stopRefreshTask();
//   }
//
//   Future<void> _stopAllTaskClick() async {
//     await _backgroundExecutor.stopAllExecutingTasks();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             if (_message != null) _messageWidget,
//             if (_message != null) _spacer,
//             if (_taskStatus != null) _taskStatusWidget,
//             if (_taskStatus != null) _spacer,
//             _startImmediately,
//             _spacer,
//             _planRefreshTask,
//             _spacer,
//             _checkTask,
//             _spacer,
//             _checkRefreshTask,
//             _spacer,
//             _checkAnyTask,
//             _spacer,
//             _stopBackgroundTask,
//             _spacer,
//             _stopRefreshTask,
//             _spacer,
//             _stopAllTask,
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget get _spacer => const SizedBox(height: 16);
//
//   Widget get _messageWidget => Text(_message ?? '');
//
//   Widget get _taskStatusWidget => Text(_taskStatus ?? '');
//
//   Widget get _startImmediately =>
//       _button(text: 'Start immediately task', onClick: _startImmediatelyClick);
//
//   Widget get _planRefreshTask =>
//       _button(text: 'Plan refresh task', onClick: _planRefreshTaskClick);
//
//   Widget get _checkTask => _button(
//       text: 'Check background task', onClick: _checkBackgroundTaskClick);
//
//   Widget get _checkRefreshTask =>
//       _button(text: 'Check refresh task', onClick: _checkRefreshTaskClick);
//
//   Widget get _checkAnyTask =>
//       _button(text: 'Check all tasks', onClick: _checkAnyTaskClick);
//
//   Widget get _stopBackgroundTask =>
//       _button(text: 'Stop background task', onClick: _stopBackgroundTaskClick);
//
//   Widget get _stopRefreshTask =>
//       _button(text: 'Stop refresh task', onClick: _stopRefreshTaskClick);
//
//   Widget get _stopAllTask =>
//       _button(text: 'Stop all tasks', onClick: _stopAllTaskClick);
//
//   Widget _button({required String text, required VoidCallback onClick}) =>
//       ElevatedButton(
//         onPressed: onClick,
//         child: Text(text),
//       );
// }
//
// @pragma('vm:entry-point')
// Future<void> refresh() async {
//   final start = DateTime.now();
//   while (true) {
//     await Future.delayed(const Duration(seconds: 1));
//     final str = 'refresh ${DateTime.now().difference(start)}';
//     print(str);
//     if (DateTime.now().difference(start) > Duration(seconds: 20)) {
//       print('end refresh task');
//       return;
//     }
//   }
// }
//
// @pragma('vm:entry-point')
// Future<void> immediately(EngineConnector? connector) async {
//   final start = DateTime.now();
//   while (true) {
//     await Future.delayed(const Duration(seconds: 1));
//     final str = 'immediately ${DateTime.now().difference(start)}';
//     final result = await connector?.messageSender(
//       to: Tasks.mainApplication,
//       message: str,
//     );
//     if (result != true) {
//       return;
//     }
//   }
// }