bool isNullOrEmpty(dynamic obj) => obj == null || ((obj is String || obj is List || obj is Map) && obj.isEmpty);
