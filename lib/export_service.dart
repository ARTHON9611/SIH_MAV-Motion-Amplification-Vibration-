import 'dart:developer';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter_min/return_code.dart';
import 'package:ffmpeg_kit_flutter_min/statistics.dart';
import 'package:video_editor/video_editor.dart';

class ExportService {
  static Future<void> dispose() async {
    final executions = await FFmpegKit.listSessions();
    if (executions.isNotEmpty) await FFmpegKit.cancel();
  }

  static Future<FFmpegSession> runFFmpegCommand(
    FFmpegVideoEditorExecute execute, {
    required void Function(File file) onCompleted,
    void Function(Object, StackTrace)? onError,
    void Function(Statistics)? onProgress,
  }) {
    log('FFmpeg start process with command = ${execute.command}');
    return FFmpegKit.executeAsync(
      execute.command,
      (session) async {
        final state =
            FFmpegKitConfig.sessionStateToString(await session.getState());
        final code = await session.getReturnCode();

        if (ReturnCode.isSuccess(code)) {
          onCompleted(File(execute.outputPath));
        } else {
          if (onError != null) {
            onError(
              Exception(
                  'FFmpeg process exited with state $state and return code $code.\n${await session.getOutput()}'),
              StackTrace.current,
            );
          }
          return;
        }
      },
      null,
      onProgress,
    );
  }
}

//    static Future<FFmpegSession> runFFmpegCommand(
//     FFmpegVideoEditorExecute execute, {
//     required void Function(File file) onCompleted,
//     void Function(Object, StackTrace)? onError,
//     void Function(Statistics)? onProgress,
//   }) {
//     log('FFmpeg start process with command = ${execute.command}');
    
//     // Set additional parameters to maintain video quality
//     final additionalParameters = <String>[
//       // Specify the video codec (e.g., libx264 for H.264 codec)
//       '-c:v', 'libx264',
      
//       // Set the video bitrate (adjust as needed to balance size and quality)
//       '-b:v', '5M', // Example bitrate (5 Mbps), adjust according to requirements
      
//       // Preserve input resolution (optional, only if resizing is undesired)
//       '-vf', 'scale=iw:ih', // Uncomment to maintain input resolution
//     ];

//     // Add the additional parameters to the FFmpeg command
//     final List<String> fullCommand = List.from(execute.command as Iterable)..addAll(additionalParameters);

//     return FFmpegKit.executeAsync(
//       fullCommand as String,
//       (session) async {
//         final state =
//             FFmpegKitConfig.sessionStateToString(await session.getState());
//         final code = await session.getReturnCode();

//         if (ReturnCode.isSuccess(code)) {
//           onCompleted(File(execute.outputPath));
//         } else {
//           if (onError != null) {
//             onError(
//               Exception(
//                   'FFmpeg process exited with state $state and return code $code.\n${await session.getOutput()}'),
//               StackTrace.current,
//             );
//           }
//           return;
//         }
//       },
//       null,
//       onProgress,
//     );
//   }
// }