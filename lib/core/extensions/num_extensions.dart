extension ClampDouble on num {
  double clampDouble(num min, num max) {
    return this.clamp(min, max).toDouble();
  }
}
