class ApiErrorModel {
  final int statusCode;
  final String message;
  final String? details;
  final DateTime timestamp;

  ApiErrorModel({
    required this.statusCode,
    required this.message,
    this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  // Factory constructor to create error from status code
  factory ApiErrorModel.fromStatusCode(
    int statusCode, {
    String? customMessage,
    String? details,
  }) {
    final errorInfo = ApiErrorModel.getErrorInfo(statusCode);
    return ApiErrorModel(
      statusCode: statusCode,
      message: customMessage ?? errorInfo['message']!,
      details: details ?? errorInfo['details'],
    );
  }

  // Get error information based on status code
  static Map<String, String> getErrorInfo(int statusCode) {
    return _errorMessages[statusCode] ??
        {
          'message': 'Unknown Error',
          'details':
              'An unexpected error occurred with status code: $statusCode',
        };
  }

  // Check error type
  bool get isClientError => statusCode >= 400 && statusCode < 500;

  bool get isServerError => statusCode >= 500 && statusCode < 600;

  bool get isNetworkError => statusCode == 0 || statusCode == -1;

  // Convert to JSON
  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'message': message,
    'details': details,
    'timestamp': timestamp.toIso8601String(),
  };

  // Create from JSON
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
    statusCode: json['statusCode'],
    message: json['message'],
    details: json['details'],
    timestamp: DateTime.parse(json['timestamp']),
  );

  @override
  String toString() =>
      'AppError($statusCode): $message${details != null ? ' - $details' : ''}';

  // Complete status codes with explanations
  static final Map<int, Map<String, String>> _errorMessages = {
    // Network Errors (Custom)
    0: {
      'message': 'No Internet Connection',
      'details': 'Please check your internet connection and try again.',
    },
    -1: {
      'message': 'Network Error',
      'details': 'Unable to connect to the server. Please try again later.',
    },

    // 1xx Informational
    100: {
      'message': 'Continue',
      'details':
          'The server has received the request headers, and the client should proceed to send the request body.',
    },
    101: {
      'message': 'Switching Protocols',
      'details':
          'The server is switching protocols as requested by the client.',
    },
    102: {
      'message': 'Processing',
      'details':
          'The server has received and is processing the request, but no response is available yet.',
    },
    103: {
      'message': 'Early Hints',
      'details':
          'Used to return some response headers before final HTTP message.',
    },

    // 2xx Success
    200: {'message': 'OK', 'details': 'The request was successful.'},
    201: {
      'message': 'Created',
      'details': 'The request was successful and a new resource was created.',
    },
    202: {
      'message': 'Accepted',
      'details':
          'The request has been accepted for processing, but processing is not complete.',
    },
    203: {
      'message': 'Non-Authoritative Information',
      'details':
          'The request was successful but the enclosed payload has been modified from the origin server.',
    },
    204: {
      'message': 'No Content',
      'details': 'The request was successful but there is no content to send.',
    },
    205: {
      'message': 'Reset Content',
      'details':
          'The request was successful and the client should reset the document view.',
    },
    206: {
      'message': 'Partial Content',
      'details':
          'The server is delivering only part of the resource due to a range header sent by the client.',
    },

    // 3xx Redirection
    300: {
      'message': 'Multiple Choices',
      'details':
          'The request has more than one possible response. User should choose one.',
    },
    301: {
      'message': 'Moved Permanently',
      'details':
          'The requested resource has been permanently moved to a new URL.',
    },
    302: {
      'message': 'Found',
      'details':
          'The requested resource has been temporarily moved to a different URL.',
    },
    303: {
      'message': 'See Other',
      'details':
          'The response can be found under a different URL using a GET method.',
    },
    304: {
      'message': 'Not Modified',
      'details': 'The resource has not been modified since the last request.',
    },
    307: {
      'message': 'Temporary Redirect',
      'details':
          'The request should be repeated with another URL, but future requests should use the original URL.',
    },
    308: {
      'message': 'Permanent Redirect',
      'details':
          'The request and all future requests should be repeated using another URL.',
    },

    // 4xx Client Errors
    400: {
      'message': 'Bad Request',
      'details':
          'The server cannot process the request due to invalid syntax or malformed request.',
    },
    401: {
      'message': 'Unauthorized',
      'details': 'Authentication is required. Please log in and try again.',
    },
    402: {
      'message': 'Payment Required',
      'details': 'Payment is required to access this resource.',
    },
    403: {
      'message': 'Forbidden',
      'details': 'You do not have permission to access this resource.',
    },
    404: {
      'message': 'Not Found',
      'details': 'The requested resource could not be found on the server.',
    },
    405: {
      'message': 'Method Not Allowed',
      'details': 'The HTTP method used is not allowed for this resource.',
    },
    406: {
      'message': 'Not Acceptable',
      'details':
          'The server cannot produce a response matching the list of acceptable values.',
    },
    407: {
      'message': 'Proxy Authentication Required',
      'details': 'Authentication with the proxy is required.',
    },
    408: {
      'message': 'Request Timeout',
      'details': 'The server timed out waiting for the request.',
    },
    409: {
      'message': 'Conflict',
      'details': 'The request conflicts with the current state of the server.',
    },
    410: {
      'message': 'Gone',
      'details':
          'The requested resource is no longer available and will not be available again.',
    },
    411: {
      'message': 'Length Required',
      'details': 'The request did not specify the length of its content.',
    },
    412: {
      'message': 'Precondition Failed',
      'details':
          'The server does not meet one of the preconditions specified in the request.',
    },
    413: {
      'message': 'Payload Too Large',
      'details':
          'The request entity is larger than the server is willing to process.',
    },
    414: {
      'message': 'URI Too Long',
      'details': 'The URI provided was too long for the server to process.',
    },
    415: {
      'message': 'Unsupported Media Type',
      'details':
          'The media format of the requested data is not supported by the server.',
    },
    416: {
      'message': 'Range Not Satisfiable',
      'details':
          'The range specified in the request header cannot be fulfilled.',
    },
    417: {
      'message': 'Expectation Failed',
      'details':
          'The server cannot meet the requirements of the Expect request-header field.',
    },
    418: {
      'message': 'I\'m a Teapot',
      'details':
          'The server refuses to brew coffee because it is a teapot (April Fools\' joke).',
    },
    421: {
      'message': 'Misdirected Request',
      'details':
          'The request was directed at a server that is not able to produce a response.',
    },
    422: {
      'message': 'Unprocessable Entity',
      'details': 'The request was well-formed but contains semantic errors.',
    },
    423: {
      'message': 'Locked',
      'details': 'The resource being accessed is locked.',
    },
    424: {
      'message': 'Failed Dependency',
      'details': 'The request failed due to failure of a previous request.',
    },
    425: {
      'message': 'Too Early',
      'details':
          'The server is unwilling to process a request that might be replayed.',
    },
    426: {
      'message': 'Upgrade Required',
      'details': 'The client should switch to a different protocol.',
    },
    428: {
      'message': 'Precondition Required',
      'details': 'The server requires the request to be conditional.',
    },
    429: {
      'message': 'Too Many Requests',
      'details':
          'You have sent too many requests in a given time. Please try again later.',
    },
    431: {
      'message': 'Request Header Fields Too Large',
      'details':
          'The server is unwilling to process the request because the header fields are too large.',
    },
    451: {
      'message': 'Unavailable For Legal Reasons',
      'details': 'The resource is unavailable due to legal reasons.',
    },

    // 5xx Server Errors
    500: {
      'message': 'Internal Server Error',
      'details':
          'The server encountered an unexpected condition that prevented it from fulfilling the request.',
    },
    501: {
      'message': 'Not Implemented',
      'details':
          'The server does not support the functionality required to fulfill the request.',
    },
    502: {
      'message': 'Bad Gateway',
      'details':
          'The server received an invalid response from the upstream server.',
    },
    503: {
      'message': 'Service Unavailable',
      'details':
          'The server is temporarily unable to handle the request. Please try again later.',
    },
    504: {
      'message': 'Gateway Timeout',
      'details':
          'The server did not receive a timely response from the upstream server.',
    },
    505: {
      'message': 'HTTP Version Not Supported',
      'details':
          'The server does not support the HTTP protocol version used in the request.',
    },
    506: {
      'message': 'Variant Also Negotiates',
      'details': 'The server has an internal configuration error.',
    },
    507: {
      'message': 'Insufficient Storage',
      'details':
          'The server is unable to store the representation needed to complete the request.',
    },
    508: {
      'message': 'Loop Detected',
      'details':
          'The server detected an infinite loop while processing the request.',
    },
    510: {
      'message': 'Not Extended',
      'details':
          'Further extensions to the request are required for the server to fulfill it.',
    },
    511: {
      'message': 'Network Authentication Required',
      'details': 'The client needs to authenticate to gain network access.',
    },
  };
}
