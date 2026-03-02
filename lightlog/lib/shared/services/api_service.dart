import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';

class ApiService {
  static ApiService? _instance;
  late Dio _dio;

  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3001', // Our secure proxy server
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // Add request/response interceptors for logging and error handling
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print('[API] $obj'),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        print('[API Error] ${error.type}: ${error.message}');
        handler.next(error);
      },
    ));
  }

  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  // AI Analysis API call
  Future<AIAnalysisResponse> getAIAnalysis({
    required String content,
    required String mode,
  }) async {
    try {
      final response = await _dio.post('/api/ai-analysis', data: {
        'content': content,
        'mode': mode,
      });

      return AIAnalysisResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Voice to text API call (future implementation)
  Future<String> voiceToText(String audioPath) async {
    try {
      // TODO: Implement file upload to Whisper API
      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(audioPath),
      });

      final response = await _dio.post('/api/voice-to-text', data: formData);
      return response.data['text'] as String;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Health check
  Future<bool> checkHealth() async {
    try {
      final response = await _dio.get('/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  ApiException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('연결 시간이 초과되었습니다. 네트워크를 확인해주세요.');
      
      case DioExceptionType.connectionError:
        return ApiException('서버에 연결할 수 없습니다. 네트워크를 확인해주세요.');
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['error'] ?? '서버 오류가 발생했습니다.';
        
        if (statusCode == 429) {
          return ApiException('요청이 너무 많습니다. 잠시 후 다시 시도해주세요.');
        } else if (statusCode == 500) {
          return ApiException('서버 내부 오류가 발생했습니다.');
        }
        
        return ApiException(message);
      
      default:
        return ApiException('알 수 없는 오류가 발생했습니다.');
    }
  }
}

class AIAnalysisResponse {
  final String analysis;
  final String mode;
  final String timestamp;

  AIAnalysisResponse({
    required this.analysis,
    required this.mode,
    required this.timestamp,
  });

  factory AIAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return AIAnalysisResponse(
      analysis: json['analysis'] as String,
      mode: json['mode'] as String,
      timestamp: json['timestamp'] as String,
    );
  }
}

class ApiException implements Exception {
  final String message;
  
  ApiException(this.message);
  
  @override
  String toString() => message;
}