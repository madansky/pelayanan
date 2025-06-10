import 'dart:io';
import 'package:http/http.dart' as http;

class UploadService {
  static Future<String?> uploadFile(File file, String filename, String scriptUrl) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(scriptUrl));
      request.files.add(await http.MultipartFile.fromPath('file', file.path, filename: filename));
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return responseBody; // Google Apps Script bisa return link download
      } else {
        print('Upload gagal: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}
