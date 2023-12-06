
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<String?> uploadImage(String urlPath) async {
  final url = Uri.parse('https://api.cloudinary.com/v1_1/dbj8eedny/upload');
  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = 'c0pxp5ct'
    ..files.add(await http.MultipartFile.fromPath('file', urlPath));
  final response = await request.send();
  if (response.statusCode == 200) {
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    final data = jsonDecode(responseString);
    final imageUrl = data['url'];
    print(imageUrl);
    return imageUrl;
  } else {
    print(response.reasonPhrase);
    null;
  }
}


