
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reclamos_anakena/barrels.dart';


Future<String?> uploadImage(String urlPath) async {
  final url = Uri.parse(dotenv.env['CLOUDINARY_API']!);
  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = 'c0pxp5ct'
    ..files.add(await http.MultipartFile.fromPath('file', urlPath));
  final response = await request.send();
  if (response.statusCode == 200) {
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    final data = jsonDecode(responseString);
    final imageUrl = data['url'];
    return imageUrl;
  } else {
    null;
  }
  return null;
}


