enum SVGAssets {
  hierarchy('assets/svg/hierarchy.svg'),
  component('assets/svg/component.svg'),
  location('assets/svg/location.svg'),
  asset('assets/svg/asset.svg');

  const SVGAssets(this.name);

  final String name;
}

enum ImageAssets {
  logo('assets/images/logo.png');

  const ImageAssets(this.name);

  final String name;
}

enum VideoAssets {
  loadingScreen('assets/videos/video.mp4');

  const VideoAssets(this.name);

  final String name;
}
