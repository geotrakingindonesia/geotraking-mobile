// localization.dart
class Localization {
  static String getAboutUs(String language) {
    switch (language) {
      case 'English':
        return 'About Us';
      case 'Indonesia':
        return 'Tentang Kami';
      default:
        return 'About Us';
    }
  }

  static String getFaqs(String language) {
    switch (language) {
      case 'English':
        return 'Faqs';
      case 'Indonesia':
        return 'FAQ';
      default:
        return 'Faqs';
    }
  }

  static String getContactUs(String language) {
    switch (language) {
      case 'English':
        return 'Contact Us';
      case 'Indonesia':
        return 'Hubungi Kami';
      default:
        return 'Contact Us';
    }
  }

  static String getHelpCenter(String language) {
    switch (language) {
      case 'English':
        return 'Help Center';
      case 'Indonesia':
        return 'Pusat Bantuan';
      default:
        return 'Help Center';
    }
  }

  static String getTabTutorialHelpCenter(String language) {
    switch (language) {
      case 'English':
        return 'Tutorial';
      case 'Indonesia':
        return 'Tutorial';
      default:
        return 'Tutorial';
    }
  }

  static String getTabTutorialBluetrakerHelpCenter(String language) {
    switch (language) {
      case 'English':
        return 'BlueTraker VMS Installation Tutorial';
      case 'Indonesia':
        return 'Tutorial Instal VMS BlueTraker';
      default:
        return 'BlueTraker VMS Installation Tutorial';
    }
  }

  static String getTabTutorialSmartoneHelpCenter(String language) {
    switch (language) {
      case 'English':
        return 'Vessel Monitoring With SmartOne Solar';
      case 'Indonesia':
        return 'Monitoring Kapal Dengan SmartOne Solar';
      default:
        return 'Vessel Monitoring With SmartOne Solar';
    }
  }

  static String getTabTutorialCheckSmartoneSolar(String language) {
    switch (language) {
      case 'English':
        return 'SmartOne Solar Inspection Procedure';
      case 'Indonesia':
        return 'Prosedur Pemeriksaan SmartOne Solar';
      default:
        return 'SmartOne Solar Inspection Procedure';
    }
  }

  static String getTabTutorialInstallationVisionTrak(String language) {
    switch (language) {
      case 'English':
        return 'VisionTrak CCTV Installation Guide';
      case 'Indonesia':
        return 'Panduan Instalasi CCTV VisionTrak';
      default:
        return 'VisionTrak CCTV Installation Guide';
    }
  }

  static String getTabTutorialCheckVMSBluetraker(String language) {
    switch (language) {
      case 'English':
        return 'Bluetraker VMS Inspection Procedure';
      case 'Indonesia':
        return 'Prosedur Pemeriksaan VMS Bluetraker';
      default:
        return 'Bluetraker VMS Inspection Procedure';
    }
  }

  static String getTabSupportServiceHelpCenter(String language) {
    switch (language) {
      case 'English':
        return 'Support Service';
      case 'Indonesia':
        return 'Layanan Dukungan';
      default:
        return 'Support Service';
    }
  }

  static String getChangeLanguage(String language) {
    switch (language) {
      case 'English':
        return 'Change Language';
      case 'Indonesia':
        return 'Ganti Bahasa';
      default:
        return 'Change Language';
    }
  }

  static String getHomePagePriview(String language) {
    switch (language) {
      case 'English':
        return 'Starting to \nKnow Maritimes \nwith Geotraking';
      case 'Indonesia':
        return 'Mulai Mengenal \nMaritim Dengan \nGeotraking';
      default:
        return 'Starting to \nKnow Maritimes \nwith Geotraking';
    }
  }

  static String getTeksAboutUs(String language) {
    switch (language) {
      case 'English':
        return '''
          "Geotraking" is a maritime tracking application designed to provide a seamless and intuitive experience in monitoring ship movements, accessing Basarnas points, and obtaining information about ports throughout Indonesia.
          \nWith this application, users can:\n- Track ships in real-time, including current position and speed\n- Access the complete Basarnas point database, including location, contact information\n- Get detailed information about ports in Indonesia, including location and contact information\n- Seeing the differences in fisheries management areas (WPP) in Indonesia\n- Use a troubleshooting system to resolve technical issues and ensure the application runs smoothly\n- Utilize the airtime extension feature which allows users to extend their active airtime period easily and quickly
          ''';
      case 'Indonesia':
        return '''
          "Geotraking" adalah aplikasi pelacakan maritim yang dirancang untuk memberikan pengalaman yang mulus dan intuitif dalam memantau pergerakan kapal, mengakses titik-titik Basarnas, dan memperoleh informasi tentang pelabuhan di seluruh Indonesia.
          \nDengan aplikasi ini, pengguna dapat:\n- Lacak kapal secara real-time, termasuk posisi dan kecepatan saat ini\n- Akses database titik Basarnas yang lengkap, termasuk lokasi, informasi kontak\n- Mendapatkan informasi detail mengenai pelabuhan di Indonesia, termasuk lokasi, dan informasi kontak\n- Melihat perbedaan wilayah pengelolaan perikanan (WPP) di Indonesia\n- Menggunakan sistem pemecahan masalah untuk menyelesaikan masalah teknis dan memastikan aplikasi berjalan dengan lancar\n- Memanfaatkan fitur perpanjangan airtime yang memungkinkan pengguna memperpanjang masa aktif airtime dengan mudah dan cepat
          ''';
      default:
        return '''
          "Geotraking" is a maritime tracking application designed to provide a seamless and intuitive experience in monitoring ship movements, accessing Basarnas points, and obtaining information about ports throughout Indonesia.
          \nWith this application, users can:\n- Track ships in real-time, including current position and speed\n- Access the complete Basarnas point database, including location, contact information\n- Get detailed information about ports in Indonesia, including location and contact information\n- Seeing the differences in fisheries management areas (WPP) in Indonesia\n- Use a troubleshooting system to resolve technical issues and ensure the application runs smoothly\n- Utilize the airtime extension feature which allows users to extend their active airtime period easily and quickly
          ''';
    }
  }

  static String getTextVersiApk(String language) {
    switch (language) {
      case 'English':
        return '''
          \n**Version 0.1**\nLaunched with REST API integration, marking the beginning of our maritime tracking journey.
          \n**Version 0.2**\nMajor update! We've shifted from REST API to direct Database connection, enhancing data retrieval and processing speed. Additionally, we've refreshed our design to provide a more intuitive and user-friendly experience.
          \n**Version 0.3-0.6**\nVessel History Trace Feature Optimization Update.
          ''';
      case 'Indonesia':
        return '''
          \n**Versi 0.1**\nDiluncurkan dengan integrasi REST API, menandai awal perjalanan pelacakan maritim kami.
          \n**Versi 0.2**\nPembaruan besar! Kami telah beralih dari REST API ke koneksi Database langsung, sehingga meningkatkan pengambilan data dan kecepatan pemrosesan. Selain itu, kami telah memperbarui desain kami untuk memberikan pengalaman yang lebih intuitif dan ramah pengguna.
          \n**Versi 0.3-0.6**\nPembaruan Optimalisasi Fitur Jejak Riwayat Kapal.
          ''';
      default:
        return '''
          \n**Version 0.1**\nLaunched with REST API integration, marking the beginning of our maritime tracking journey.
          \n**Version 0.2**\nMajor update! We've shifted from REST API to direct Database connection, enhancing data retrieval and processing speed. Additionally, we've refreshed our design to provide a more intuitive and user-friendly experience.
          \n**Version 0.3-0.6**\nVessel History Trace Feature Optimization Update.
          ''';
    }
  }

  static String getCatalogue(String language) {
    switch (language) {
      case 'English':
        return 'Catalog';
      case 'Indonesia':
        return 'Katalog';
      default:
        return 'Catalog';
    }
  }

  static String getGallery(String language) {
    switch (language) {
      case 'English':
        return 'Our Galleries';
      case 'Indonesia':
        return 'Galeri Kami';
      default:
        return 'Our Galleries';
    }
  }

  static String getGalleryDetail(String language) {
    switch (language) {
      case 'English':
        return 'Gallery Detail';
      case 'Indonesia':
        return 'Detail Galeri';
      default:
        return 'Gallery Detail';
    }
  }

  static String getNotification(String language) {
    switch (language) {
      case 'English':
        return 'Notifications';
      case 'Indonesia':
        return 'Notifikasi';
      default:
        return 'Notifications';
    }
  }

  static String getNotificationDetail(String language) {
    switch (language) {
      case 'English':
        return 'Notification Detail';
      case 'Indonesia':
        return 'Detail Notifikasi';
      default:
        return 'Notification Detail';
    }
  }

  static String getProfile(String language) {
    switch (language) {
      case 'English':
        return 'My Profile';
      case 'Indonesia':
        return 'Profile Saya';
      default:
        return 'My Profile';
    }
  }

  static String getSetting(String language) {
    switch (language) {
      case 'English':
        return 'Setting';
      case 'Indonesia':
        return 'Pengaturan';
      default:
        return 'Setting';
    }
  }

  static String getLogout(String language) {
    switch (language) {
      case 'English':
        return 'Logout';
      case 'Indonesia':
        return 'Keluar';
      default:
        return 'Logout';
    }
  }

  static String getKapalKu(String language) {
    switch (language) {
      case 'English':
        return 'My-Vessel';
      case 'Indonesia':
        return 'Kapal-Ku';
      default:
        return 'My-Vessel';
    }
  }

  static String getTrackKapalKu(String language) {
    switch (language) {
      case 'English':
        return 'Track My-Vessel';
      case 'Indonesia':
        return 'Lacak Kapal-Ku';
      default:
        return 'Track My-Vessel';
    }
  }

  static String getTroubleshoot(String language) {
    switch (language) {
      case 'English':
        return 'TroubleShoot';
      case 'Indonesia':
        return 'Pemecah Masalah';
      default:
        return 'TroubleShoot';
    }
  }

  static String getHistoryExtend(String language) {
    switch (language) {
      case 'English':
        return 'History Extend Airtime';
      case 'Indonesia':
        return 'History Perpanjang Airtime';
      default:
        return 'History Extend Airtime';
    }
  }

  static String getTransaction(String language) {
    switch (language) {
      case 'English':
        return 'Transaction';
      case 'Indonesia':
        return 'Transaksi';
      default:
        return 'Transaction';
    }
  }

  static String getChangePassword(String language) {
    switch (language) {
      case 'English':
        return 'Change Password';
      case 'Indonesia':
        return 'Ganti Password';
      default:
        return 'Change Password';
    }
  }

  static String getNewPassword(String language) {
    switch (language) {
      case 'English':
        return 'New Password';
      case 'Indonesia':
        return 'Password Baru';
      default:
        return 'New Password';
    }
  }

  static String getConfirmPassword(String language) {
    switch (language) {
      case 'English':
        return 'Confirmed Password';
      case 'Indonesia':
        return 'Konfirmasi Password';
      default:
        return 'Confirmed Password';
    }
  }

  static String getUpdate(String language) {
    switch (language) {
      case 'English':
        return 'Update';
      case 'Indonesia':
        return 'Ubah';
      default:
        return 'Update';
    }
  }

  static String getProcess(String language) {
    switch (language) {
      case 'English':
        return 'Process';
      case 'Indonesia':
        return 'Proses';
      default:
        return 'Process';
    }
  }

  static String getHistory(String language) {
    switch (language) {
      case 'English':
        return 'History';
      case 'Indonesia':
        return 'Histori';
      default:
        return 'History';
    }
  }

  static String getPaidOff(String language) {
    switch (language) {
      case 'English':
        return 'Paid Off';
      case 'Indonesia':
        return 'Lunas';
      default:
        return 'Paid Off';
    }
  }
  
  static String getCancel(String language) {
    switch (language) {
      case 'English':
        return 'Cancel';
      case 'Indonesia':
        return 'Batal';
      default:
        return 'Cancel';
    }
  }

  static String getReplace(String language) {
    switch (language) {
      case 'English':
        return 'Replace';
      case 'Indonesia':
        return 'Mengganti';
      default:
        return 'Replace';
    }
  }

  static String account(String language) {
    switch (language) {
      case 'English':
        return 'Account';
      case 'Indonesia':
        return 'Akun';
      default:
        return 'Account';
    }
  }

  static String logBook(String language) {
    switch (language) {
      case 'English':
        return 'Log Book';
      case 'Indonesia':
        return 'Buku Catatan';
      default:
        return 'Log Book';
    }
  }

  static String preferences(String language) {
    switch (language) {
      case 'English':
        return 'Preferences';
      case 'Indonesia':
        return 'Preferensi';
      default:
        return 'Preferences';
    }
  }

  static String logout(String language) {
    switch (language) {
      case 'English':
        return 'Logout';
      case 'Indonesia':
        return 'Keluar';
      default:
        return 'Logout';
    }
  }

  static String report(String language) {
    switch (language) {
      case 'English':
        return 'Report';
      case 'Indonesia':
        return 'Laporan';
      default:
        return 'Report';
    }
  }

  static String jarakTempuh(String language) {
    switch (language) {
      case 'English':
        return 'Mileage';
      case 'Indonesia':
        return 'Jarak Tempuh';
      default:
        return 'Mileage';
    }
  }

  static String legendInformasi(String language) {
    switch (language) {
      case 'English':
        return 'Legend Information';
      case 'Indonesia':
        return 'Informasi Legend';
      default:
        return 'Legend Information';
    }
  }

  static String privacyPolice(String language) {
    switch (language) {
      case 'English':
        return 'Privacy Police';
      case 'Indonesia':
        return 'Kebijakan Privasi';
      default:
        return 'Privacy Police';
    }
  }
}
