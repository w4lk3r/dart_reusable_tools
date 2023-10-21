part of '../reusable_tools_base.dart';

/// Copied from https://github.com/gokberkbar/memory_cache
///
/// https://pub.dev/packages/memory_cache
class _CacheItem<T> {
  const _CacheItem({
    required this.createdAt,
    this.expiry,
    this.value,
  });

  factory _CacheItem.create(T? value, {DateTime? expiry}) => _CacheItem(
        createdAt: DateTime.now(),
        expiry: expiry,
        value: value,
      );
  final DateTime createdAt;
  final DateTime? expiry;
  final T? value;

  _CacheItem<T> copyWith({
    DateTime? createdAt,
    DateTime? expiry,
    T? value,
  }) {
    return _CacheItem<T>(
      createdAt: createdAt ?? this.createdAt,
      expiry: expiry ?? this.expiry,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => '$value';
}

/// SimpleCache is a simple and fast in-memory cache.
class InMemoryCache<T> {
  /// Public Constructor, for local caches
  InMemoryCache();

  /// Private Constructor, for global cache
  InMemoryCache._();

  /// Singleton instance of MemoryCache, for global cache
  static final InMemoryCache instance = InMemoryCache._();

  /// internal cache
  final Map<String, _CacheItem<T>> _cache = {};

  /// Checks if cache is empty.
  bool get isEmpty {
    _cache.removeWhere((key, value) => _isExpired(value));
    return _cache.isEmpty;
  }

  /// Checks if cache is not empty.
  bool get isNotEmpty => !isEmpty;

  /// If cache contains a value for the [key], returns the value.
  /// If cache does not contains a value for the [key], returns null.
  T? read(String key) {
    if (_expiryAwareContains(key)) {
      final item = _cache[key]!;
      return item.value as T;
    }
    return null;
  }

  /// Sets the [value] to the cache.
  /// If cache contains a value for the [key], overrides the value in the cache.
  void create(String key, T value, {Duration? expiry}) =>
      _cache[key] = _CacheItem<T>.create(value, expiry: _setExpiry(expiry));

  /// If cache does not contains a value for the [key], sets the [value] to the cache and returns true.
  /// If cache contains a value for the [key], returns false.
  bool createIfAbsent(String key, T value, {Duration? expiry}) {
    if (!_expiryAwareContains(key)) {
      create(key, value, expiry: expiry);
      return true;
    }
    return false;
  }

  /// If cache contains a value for the [key], updates the value on the cache and returns true.
  /// If cache does not contains a value for the [key], returns false.
  bool update(String key, T value, {Duration? expiry}) {
    if (_expiryAwareContains(key)) {
      _cache[key] = _cache[key]!.copyWith(
        value: value,
        expiry: _setExpiry(expiry),
      );
      return true;
    }
    return false;
  }

  /// Removes value from cache.
  void delete(String key) {
    _cache.remove(key);
  }

  /// Invalidates all cached values.
  void invalidate() {
    _cache.clear();
  }

  /// Returns true if cached value exists.
  bool contains(String key) {
    return _expiryAwareContains(key);
  }

  /// Adds [expiry] to DateTime.now() and returns it.
  DateTime? _setExpiry(Duration? expiry) =>
      expiry != null ? DateTime.now().add(expiry) : null;

  /// Checks if [item] is expired.
  bool _isExpired(_CacheItem<T> item) {
    if (item.expiry != null && item.expiry!.isBefore(DateTime.now())) {
      return true;
    }
    return false;
  }

  /// Returns true if cached value exists but not expired.
  /// If cached value expired removes from cache.
  bool _expiryAwareContains(String key) {
    final item = _cache[key];
    if (item == null) {
      return false;
    } else if (_isExpired(item)) {
      delete(key);
      return false;
    }
    return true;
  }

  @override
  String toString() => _cache.toString();
}
