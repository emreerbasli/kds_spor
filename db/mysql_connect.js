const mysql=require('mysql2')
require('dotenv/config')
var dbConn=mysql.createConnection({
    user:process.env.DATABASE_USER,
    password:process.env.DATABASE_PASSWORD,
    database:process.env.DATABASE,
    host:process.env.DATABASE_HOST
})
dbConn.connect((err)=>{
    if(!err){
        console.log("Veritabanına Bağlandı")
    }else{
        console.log("Bağlantı Hatası"+err)
    }
})
module.exports=dbConn