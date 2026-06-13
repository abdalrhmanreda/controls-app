import 'package:control_app/core/api/api_constant.dart';

class ImageHelper {
  static String getFullUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('http')) return url;
    
    // Remove leading slash if present in url or trailing slash in baseUrl
    String cleanBase = ApiConstant.baseUrl;
    if (cleanBase.endsWith('/')) {
      cleanBase = cleanBase.substring(0, cleanBase.length - 1);
    }
    
    String cleanUrl = url;
    if (cleanUrl.startsWith('/')) {
      cleanUrl = cleanUrl.substring(1);
    }
    
    return '$cleanBase/$cleanUrl';
  }
}
