const mysql = require('mysql2');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // غيّرها إذا كانت عندك كلمة سر
  database: 'poomsae_judging'
});

db.connect((err) => {
  if (err) {
    console.error('❌ DB connection error:', err);
    return;
  }
  console.log('✅ Connected to MySQL DB.');
});

module.exports = db;
