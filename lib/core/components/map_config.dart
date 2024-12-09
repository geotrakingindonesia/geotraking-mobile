// MapConfig.dart
class MapConfig {
  static String getUrlTemplate(String selectedMapProvider) {
    switch (selectedMapProvider) {
      case 'OpenStreetMap':
        return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
      case 'CyclOSM':
        return 'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png';
      case 'OpenTopo Map':
        return 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png';
      case 'Hot OSM':
        return 'https://b.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png';
      case 'Esri NatGeoWorldMap':
        // return 'https://tiles.stadiamaps.com/tiles/alidade_satellite/{z}/{x}/{y}{r}.jpg';
        return 'https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}';
      case 'OSM Piano':
        return 'https://{s}.piano.tiles.quaidorsay.fr/fr/{z}/{x}/{y}.png';
      default:
        return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }

  static List<String> getMapProviders() {
    return [
      'OpenStreetMap',
      'CyclOSM',
      'Hot OSM',
      'OpenTopo Map',
      'Esri NatGeoWorldMap',
      'OSM Piano',
    ];
  }
}
