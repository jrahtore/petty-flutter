// import 'dart:io';
// import 'dart:isolate';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
//
// import '../screens/utils.dart';
//
// class FileDownloadContainer extends StatefulWidget {
//   final String fileUrl;
//   FileDownloadContainer(this.fileUrl, {Key key}) : super(key: key);
//
//   @override
//   State<FileDownloadContainer> createState() => _FileDownloadContainerState();
// }
//
// class _FileDownloadContainerState extends State<FileDownloadContainer> {
//   ReceivePort _port = ReceivePort();
//   bool isDownloading = false;
//   double progress = 0.0;
//   String fileName = "";
//
//   getFileName() {
//     if (fileName.isEmpty) {
//       fileName = widget.fileUrl.split("/").last;
//     }
//     return fileName;
//   }
//
//   createDirectory() async {
//     // PermissionStatus permissionResult =
//     //     await SimplePermissions.requestPermission(
//     //         Permission.WriteExternalStorage);
//     // if (permissionResult == PermissionStatus.authorized) {
//     Directory directory = Directory('/sdcard/download/New');
//     bool isDirectoryExist = await directory.exists();
//     if (!isDirectoryExist) await Directory('/sdcard/download/New').create();
//     return true;
//     // }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     IsolateNameServer.registerPortWithName(
//         _port.sendPort, 'downloader_send_port');
//     _port.listen((dynamic data) {
//       String id = data[0];
//       DownloadTaskStatus status = data[1];
//
//       setState(() {
//         progress = data[2] / 100.0;
//       });
//     });
//
//     FlutterDownloader.registerCallback(downloadCallback);
//   }
//
//   @override
//   void dispose() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//     super.dispose();
//   }
//
//   @pragma('vm:entry-point')
//   static void downloadCallback(
//       String id, DownloadTaskStatus status, int progress) {
//     final SendPort send =
//         IsolateNameServer.lookupPortByName('downloader_send_port');
//     send.send([id, status, progress]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         await createDirectory();
//
//         await FlutterDownloader.enqueue(
//           url: widget.fileUrl,
//           savedDir: '/sdcard/download/New',
//           showNotification:
//               true, // show download progress in status bar (for Android)
//           openFileFromNotification:
//               false, // click on notification to open downloaded file (for Android)
//         );
//         setState(() {
//           isDownloading = !isDownloading;
//         });
//       },
//       child: Row(
//         children: [
//           Icon(Icons.insert_drive_file),
//           SizedBox(
//             width: 5.0,
//           ),
//           Expanded(
//             child: Text(
//               getFileName(),
//               style: Theme.of(context).textTheme.bodyText1.apply(
//                     color: Color(mainColor),
//                   ),
//             ),
//           ),
//           SizedBox(
//             width: 5.0,
//           ),
//           Builder(builder: (context) {
//             return isDownloading
//                 ? CircularProgressIndicator(
//                     value: progress,
//                     valueColor: AlwaysStoppedAnimation(Colors.red),
//                     backgroundColor: Colors.grey,
//                   )
//                 : Icon(Icons.download_rounded);
//           }),
//         ],
//       ),
//     );
//     ;
//   }
// }
