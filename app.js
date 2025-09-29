// app.js

// Gerekli modülleri ve yapılandırmaları ekleyin

const express = require("express");
const path = require("path");
const ejs = require("ejs")
const app = express();
const publicDirectory = path.join(__dirname, './public');
app.use(express.static(publicDirectory));
app.use(express.urlencoded({ extended: true }));

app.set('view engine', 'ejs');
const dbConn = require("./db/mysql_connect")
// GET isteği - Ana sayfayı render et
app.get('/', (req, res) => {
    res.render('index');
});
app.use('/', require('./routes/pages'))

app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Kullanıcı adı ve şifreyi veritabanında sorgula
    dbConn.query(
        "SELECT * FROM yonetici WHERE yonetici_ad = ? AND sifre = ?", 
        [username, password], 
        (err, results) => {
            if (err) {
                console.error(err);
                res.status(500).send("Veritabanı hatası");
            } else {
                if (results.length > 0) {
                    res.redirect("/homepage");
                } else {
                    res.redirect("/");
                }
            }
        }
    );
});

app.get('/uyeler', (req, res) => {
    dbConn.query("SELECT * FROM uye,sube,uye_kurs,kurs WHERE uye.sube_id = sube.sube_id AND uye.uye_id = uye_kurs.uye_id AND kurs.kurs_id = uye_kurs.kurs_id ORDER BY sube.sube_id ASC;", (error, results) => { 
      if (error) throw error;
      res.render('uyeler', { uye: results });
    });
 });
 app.get('/egitmen', (req, res) => {
    dbConn.query("SELECT * FROM egitmen,uzmanlik,sube,ortalama WHERE egitmen.sube_id = sube.sube_id AND uzmanlik.uzmanlik_id = egitmen.uzmanlik_id", (error, results) => { 
      if (error) throw error;
      res.render('egitmen', { egitmen: results });
    });
 });
 app.get('/sube', (req, res) => {
    dbConn.query("SELECT gelir.sube_id,gelir.sube_ad,gelir.gelir,gider.gider,sube.aciklama FROM sube,gelir,gider where gelir.sube_id = gider.sube_id AND sube.sube_id = gider.sube_id", (error, results) => { 
      if (error) throw error;
      res.render('sube', { sube: results });
    });
 });
 app.get('/kurs', (req, res) => {
    dbConn.query("SELECT * FROM kurs", (error, results) => { 
      if (error) throw error;
      res.render('kurs', { kurs: results });
    });
 });
 ///input
 app.post('/sube_aciklama', (req, res) => {
  const { deger,esne } = req.body;

  // Kullanıcı adı ve şifreyi veritabanında sorgula
  dbConn.query("SET @p0 = ?;", [deger], (err, results) => {
      if (err) {
          console.error(err);
          res.send(err)
          res.status(500).send("Veritabanı hatası");
          return;
      }
  dbConn.query("set @p1=?;",[esne], (err, results) => {
        if (err) {
          console.error(err);
          res.send(err)
          res.status(500).send("Veritabanı hatası1");
          return;
        }
    });

      // @p0 değişkenini kullanarak saklı yordamı çağır
      dbConn.query("CALL aciklama(@p0,@p1);", (err, results) => {
          if (err) {
              console.error(err);

              // Hata mesajını al ve istemciye gönder
              const errorMessage = err.message || 'Saklı yordam hatası';
              res.status(500).send(errorMessage);
          } else {
              res.redirect('/sube');
          }
      });
  });
}); 
app.get('/sube_sayisi', (req, res) => {
    const query = 'SELECT sube.sube_id, sube.sube_ad, SUM(gelir.gelir - gider.gider) AS net_gelir FROM sube LEFT JOIN gelir ON gelir.sube_id = sube.sube_id LEFT JOIN gider ON gider.sube_id = sube.sube_id GROUP BY sube.sube_id, sube.sube_ad';
    dbConn.query(query, (error, data) => {
      if (error) {
        console.error('MySQL query error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
      res.json(data);
    });
});
app.get('/uye_sayisi', (req, res) => {
    const query = 'SELECT kurs.kurs_ad, COUNT(uye.uye_id) AS uye_sayisi FROM kurs, uye, uye_kurs WHERE uye.uye_id = uye_kurs.uye_id AND uye_kurs.kurs_id = kurs.kurs_id GROUP BY kurs.kurs_id';
    dbConn.query(query, (error, data) => {
      if (error) {
        console.error('MySQL query error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
      res.json(data);
    });
});
app.get('/kurs_ucret', (req, res) => {
    const query = 'SELECT kurs.kurs_ad, kurs.kurs_ucret FROM kurs';
    dbConn.query(query, (error, data) => {
      if (error) {
        console.error('MySQL query error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
      res.json(data);
    });
});
app.get('/sube_uye', (req, res) => {
    const query = 'SELECT sube.sube_id, sube.sube_ad, COUNT(uye.uye_id) AS uye_sayisi FROM sube,uye WHERE sube.sube_id=uye.sube_id GROUP BY sube.sube_id';
    dbConn.query(query, (error, data) => {
      if (error) {
        console.error('MySQL query error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
      res.json(data);
    });
});
app.listen(5000, () => {
    console.log("Server başlatıldı. Port = 5000");
});