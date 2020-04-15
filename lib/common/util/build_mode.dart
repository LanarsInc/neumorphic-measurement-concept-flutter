class BuildMode {
  /// asserts enabled only in debug mode
  static bool get isDebug {
    var debug = false;
    assert(debug = true);
    return debug;
  }
}
