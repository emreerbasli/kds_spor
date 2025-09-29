-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 20 Ara 2023, 15:47:40
-- Sunucu sürümü: 8.0.31
-- PHP Sürümü: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `kds_spor`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `ist_aya_gore_toplam_sube_gelirleri`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ist_aya_gore_toplam_sube_gelirleri` ()   SELECT sube.sube_ad,SUM(kurs.kurs_ucret) as aralik
FROM sube LEFT JOIN uye ON uye.sube_id = sube.sube_id
LEFT JOIN uye_kurs ON uye.uye_id = uye_kurs.uye_id
LEFT JOIN kurs ON kurs.kurs_id = uye_kurs.kurs_id
WHERE extract(month FROM uye_kurs.baslangic) = 12
GROUP BY sube.sube_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cinsiyet`
--

DROP TABLE IF EXISTS `cinsiyet`;
CREATE TABLE IF NOT EXISTS `cinsiyet` (
  `cinsiyet_id` int NOT NULL,
  `cinsiyet_ad` varchar(64) COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`cinsiyet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `cinsiyet`
--

INSERT INTO `cinsiyet` (`cinsiyet_id`, `cinsiyet_ad`) VALUES
(1, 'erkek'),
(2, 'kadın');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `egitmen`
--

DROP TABLE IF EXISTS `egitmen`;
CREATE TABLE IF NOT EXISTS `egitmen` (
  `egitmen_id` int NOT NULL AUTO_INCREMENT,
  `egitmen_ad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `egitmen_soyad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `cinsiyet_id` int NOT NULL,
  `uzmanlik_id` int NOT NULL,
  `sube_id` int NOT NULL,
  `maas` int NOT NULL,
  PRIMARY KEY (`egitmen_id`),
  KEY `cinsiyet_id` (`cinsiyet_id`),
  KEY `sube_id` (`sube_id`),
  KEY `uzmanlik` (`uzmanlik_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `egitmen`
--

INSERT INTO `egitmen` (`egitmen_id`, `egitmen_ad`, `egitmen_soyad`, `cinsiyet_id`, `uzmanlik_id`, `sube_id`, `maas`) VALUES
(1, 'Mustafa Emin', 'Şuşarlıoğlu', 1, 5, 1, 15000),
(2, 'Ayşe', 'Eriş', 2, 1, 1, 15000);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ilce`
--

DROP TABLE IF EXISTS `ilce`;
CREATE TABLE IF NOT EXISTS `ilce` (
  `ilce_id` int NOT NULL AUTO_INCREMENT,
  `ilce_ad` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`ilce_id`)
) ENGINE=InnoDB AUTO_INCREMENT=968 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Tablo döküm verisi `ilce`
--

INSERT INTO `ilce` (`ilce_id`, `ilce_ad`) VALUES
(1, 'Aliağa'),
(2, 'Bayındır'),
(3, 'Bergama'),
(4, 'Bornova'),
(5, 'Çeşme'),
(6, 'Dikili'),
(7, 'Foça'),
(8, 'Karaburun'),
(9, 'Karşıyaka'),
(10, 'Kemalpaşa'),
(11, 'Kınık'),
(12, 'Kiraz'),
(13, 'Menemen'),
(14, 'Ödemiş'),
(15, 'Seferihisar'),
(16, 'Selçuk'),
(17, 'Tire'),
(18, 'Torbalı'),
(19, 'Urla'),
(20, 'Beydağ'),
(21, 'Buca'),
(22, 'Konak'),
(23, 'Menderes'),
(24, 'Balçova'),
(25, 'Çiğli'),
(26, 'Gaziemir'),
(27, 'Narlıdere'),
(28, 'Güzelbahçe'),
(29, 'Bayraklı'),
(30, 'Karabağlar');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kurs`
--

DROP TABLE IF EXISTS `kurs`;
CREATE TABLE IF NOT EXISTS `kurs` (
  `kurs_id` int NOT NULL AUTO_INCREMENT,
  `kurs_ad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `kurs_ucret` int NOT NULL,
  PRIMARY KEY (`kurs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `kurs`
--

INSERT INTO `kurs` (`kurs_id`, `kurs_ad`, `kurs_ucret`) VALUES
(1, 'Pilates ve Yoga', 600),
(2, 'Aerobik ve Zumba', 850),
(3, 'Kickbox', 600),
(4, 'Jimnastik', 550),
(5, 'Fitness', 600);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sube`
--

DROP TABLE IF EXISTS `sube`;
CREATE TABLE IF NOT EXISTS `sube` (
  `sube_id` int NOT NULL AUTO_INCREMENT,
  `sube_ad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `ilce_id` int NOT NULL,
  `gelir` int DEFAULT NULL,
  `gider` int DEFAULT NULL,
  PRIMARY KEY (`sube_id`),
  KEY `ilce_id` (`ilce_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `sube`
--

INSERT INTO `sube` (`sube_id`, `sube_ad`, `ilce_id`, `gelir`, `gider`) VALUES
(1, 'Buca', 21, NULL, NULL),
(2, 'Bornova', 4, NULL, NULL),
(3, 'Bayraklı', 29, NULL, NULL),
(4, 'Karabağlar', 30, NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sube_kurs`
--

DROP TABLE IF EXISTS `sube_kurs`;
CREATE TABLE IF NOT EXISTS `sube_kurs` (
  `sube_id` int NOT NULL,
  `kurs_id` int NOT NULL,
  KEY `sube_id` (`sube_id`),
  KEY `kurs_id` (`kurs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `sube_kurs`
--

INSERT INTO `sube_kurs` (`sube_id`, `kurs_id`) VALUES
(1, 2),
(1, 5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `uye`
--

DROP TABLE IF EXISTS `uye`;
CREATE TABLE IF NOT EXISTS `uye` (
  `uye_id` int NOT NULL AUTO_INCREMENT,
  `uye_ad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `uye_soyad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `sube_id` int NOT NULL,
  `cinsiyet_id` int NOT NULL,
  `kayit_tarih` date NOT NULL,
  PRIMARY KEY (`uye_id`),
  KEY `sube_id` (`sube_id`),
  KEY `cinsiyet_id` (`cinsiyet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `uye`
--

INSERT INTO `uye` (`uye_id`, `uye_ad`, `uye_soyad`, `sube_id`, `cinsiyet_id`, `kayit_tarih`) VALUES
(2, 'Muhammed Ali', 'Algın', 1, 1, '2023-12-20'),
(3, 'Mustafa', 'Çamkaya', 2, 1, '2023-12-20');

--
-- Tetikleyiciler `uye`
--
DROP TRIGGER IF EXISTS `t_gun_uye`;
DELIMITER $$
CREATE TRIGGER `t_gun_uye` BEFORE INSERT ON `uye` FOR EACH ROW SET new.kayit_tarih = now()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `uye_kurs`
--

DROP TABLE IF EXISTS `uye_kurs`;
CREATE TABLE IF NOT EXISTS `uye_kurs` (
  `uye_id` int NOT NULL,
  `kurs_id` int NOT NULL,
  `baslangic` date NOT NULL,
  `bitis` date NOT NULL,
  KEY `uye_id` (`uye_id`),
  KEY `kurs_id` (`kurs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `uye_kurs`
--

INSERT INTO `uye_kurs` (`uye_id`, `kurs_id`, `baslangic`, `bitis`) VALUES
(2, 5, '2023-12-20', '2024-01-19'),
(2, 1, '2023-12-20', '2024-01-19'),
(3, 3, '2023-12-20', '2024-01-19');

--
-- Tetikleyiciler `uye_kurs`
--
DROP TRIGGER IF EXISTS `bitis_guncelle`;
DELIMITER $$
CREATE TRIGGER `bitis_guncelle` BEFORE INSERT ON `uye_kurs` FOR EACH ROW SET new.bitis = date_add(new.baslangic, INTERVAL 30 DAY)
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `tarih_guncelle`;
DELIMITER $$
CREATE TRIGGER `tarih_guncelle` BEFORE INSERT ON `uye_kurs` FOR EACH ROW SET new.baslangic=now()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `uzmanlik`
--

DROP TABLE IF EXISTS `uzmanlik`;
CREATE TABLE IF NOT EXISTS `uzmanlik` (
  `uzmanlik_id` int NOT NULL,
  `uzmanlik_ad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`uzmanlik_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `uzmanlik`
--

INSERT INTO `uzmanlik` (`uzmanlik_id`, `uzmanlik_ad`) VALUES
(1, 'Pilates ve Yoga'),
(2, 'Aerobik ve Zumba'),
(3, 'Kickbox'),
(4, 'Jimnastik'),
(5, 'Fitness');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yonetici`
--

DROP TABLE IF EXISTS `yonetici`;
CREATE TABLE IF NOT EXISTS `yonetici` (
  `yonetici_id` int NOT NULL AUTO_INCREMENT,
  `yonetici_ad` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `sifre` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`yonetici_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `yonetici`
--

INSERT INTO `yonetici` (`yonetici_id`, `yonetici_ad`, `sifre`) VALUES
(1, 'mustafa', '6616');

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `egitmen`
--
ALTER TABLE `egitmen`
  ADD CONSTRAINT `cinsiyet_e` FOREIGN KEY (`cinsiyet_id`) REFERENCES `cinsiyet` (`cinsiyet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sube_e` FOREIGN KEY (`sube_id`) REFERENCES `sube` (`sube_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `uzmanlik` FOREIGN KEY (`uzmanlik_id`) REFERENCES `uzmanlik` (`uzmanlik_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `sube`
--
ALTER TABLE `sube`
  ADD CONSTRAINT `ilce` FOREIGN KEY (`ilce_id`) REFERENCES `ilce` (`ilce_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `sube_kurs`
--
ALTER TABLE `sube_kurs`
  ADD CONSTRAINT `sube_w` FOREIGN KEY (`kurs_id`) REFERENCES `kurs` (`kurs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sube_Ww` FOREIGN KEY (`sube_id`) REFERENCES `sube` (`sube_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `uye`
--
ALTER TABLE `uye`
  ADD CONSTRAINT `cinsiyet` FOREIGN KEY (`cinsiyet_id`) REFERENCES `cinsiyet` (`cinsiyet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sube_u` FOREIGN KEY (`sube_id`) REFERENCES `sube` (`sube_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `uye_kurs`
--
ALTER TABLE `uye_kurs`
  ADD CONSTRAINT `kurs` FOREIGN KEY (`kurs_id`) REFERENCES `kurs` (`kurs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `uye` FOREIGN KEY (`uye_id`) REFERENCES `uye` (`uye_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
