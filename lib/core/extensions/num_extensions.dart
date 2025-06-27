extension ClampDouble on num {
  double clampDouble(num min, num max) {
    return clamp(min, max).toDouble();
  }
}
