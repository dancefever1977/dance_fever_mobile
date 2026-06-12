// data layer
// don't cross the boundary from data layer to domain layer
// the core rule is catch exceptions in data layer and return failures to domain layer

class ServerException implements Exception {}

class CacheException implements Exception {}

class AuthException implements Exception {}

class NetworkException implements Exception {}
