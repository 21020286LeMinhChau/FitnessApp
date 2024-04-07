class RequestStatus {
  // Informational
  static const int request100Continue = 100;
  static const int request101SwitchingProtocols = 101;
  static const int request102Processing = 102;
  static const int request103EarlyHints = 103;

  // Successful
  static const int request200Ok = 200;
  static const int request201Created = 201;
  static const int request202Accepted = 202;
  static const int request203NonAuthoritativeInformation = 203;
  static const int request204NoContent = 204;
  static const int request205ResetContent = 205;
  static const int request206PartialContent = 206;
  static const int request207MultiStatus = 207;
  static const int request208AlreadyReported = 208;
  static const int request226ImUsed = 226;

  // Redirection
  static const int request300MultipleChoices = 300;
  static const int request301MovedPermanently = 301;
  static const int request302Found = 302;
  static const int request303SeeOther = 303;
  static const int request304NotModified = 304;
  static const int request305UseProxy = 305;
  static const int request306Reserved = 306;
  static const int request307TemporaryRedirect = 307;
  static const int request308PermanentRedirect = 308;

  // Client Error
  static const int request400BadRequest = 400;
  static const int request401Unauthorized = 401;
  static const int request402PaymentRequired = 402;
  static const int request403Forbidden = 403;
  static const int request404NotFound = 404;
  static const int request405MethodNotAllowed = 405;
  static const int request406NotAcceptable = 406;
  static const int request407ProxyAuthenticationRequired = 407;
  static const int request408RequestTimeout = 408;
  static const int request409Conflict = 409;
  static const int request410Gone = 410;
  static const int request411LengthRequired = 411;
  static const int request412PreconditionFailed = 412;
  static const int request413RequestEntityTooLarge = 413;
  static const int request414RequestUriTooLong = 414;
  static const int request415UnsupportedMediaType = 415;
  static const int request416RequestedRangeNotSatisfiable = 416;
  static const int request417ExpectationFailed = 417;
  static const int request421MisdirectedRequest = 421;
  static const int request422UnprocessableEntity = 422;
  static const int request423Locked = 423;
  static const int request424FailedDependency = 424;
  static const int request425TooEarly = 425;
  static const int request426UpgradeRequired = 426;
  static const int request428PreconditionRequired = 428;
  static const int request429TooManyRequests = 429;
  static const int request431RequestHeaderFieldsTooLarge = 431;
  static const int request451UnavailableForLegalReasons = 451;

  // Server Error
  static const int request500InternalServerError = 500;
  static const int request501NotImplemented = 501;
  static const int request502BadGateway = 502;
  static const int request503ServiceUnavailable = 503;
  static const int request504GatewayTimeout = 504;
  static const int request505requestVersionNotSupported = 505;
  static const int request506VariantAlsoNegotiates = 506;
  static const int request507InsufficientStorage = 507;
  static const int request508LoopDetected = 508;
  static const int request509BandwidthLimitExceeded = 509;
  static const int request510NotExtended = 510;
  static const int request511NetworkAuthenticationRequired = 511;
}
