class ApiConfig {
  static const baseUrl = 'YOUR_API_URL_HERE';
}

/// Placeholder HTTP layer. Add an HTTP client and implement later.
class ApiService {
  Future<Map<String, dynamic>> get(String path) async =>
      throw UnimplementedError('Connect API: ${ApiConfig.baseUrl}$path');
  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async =>
      throw UnimplementedError('Connect API: ${ApiConfig.baseUrl}$path');
}
