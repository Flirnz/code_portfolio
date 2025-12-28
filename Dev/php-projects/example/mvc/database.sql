-- Tulis Query SQL kamu di sini untuk latihan/disimpan.
-- Nanti query ini yang akan kita copy-paste ke phpMyAdmin/Terminal MySQL.
create table users (
    ID int NOT NULL AUTO_INCREMENT,
    username varchar(50) NOT NULL,
    password varchar(255) NOT NULL,
    email varchar (100) NOT NULL,
    PRIMARY KEY (ID)
);

-- Hint Struktur:
-- CREATE TABLE users (
--     id ... (ingat KTP!),
--     username ...
--     ...
-- );
