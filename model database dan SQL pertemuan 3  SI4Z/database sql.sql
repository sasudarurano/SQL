-- primary key boleh lebih dari satu

-- buat database baru
create database dbdarren_SI4Z;


-- hapus database 
drop database dbdarren_si4z;

-- aktifkan databasenya
use dbdarren_si4z;

-- buat table baru : anggota
create table anggota
(id_anggota char(10) not null primary key,
nama varchar(100),
alamat varchar (255),
no_telp varchar(100))engine = InnoDB;

-- buat table pustakawan 
create table pustakawan 
(id_pustakawan char(10) not null primary key,
nama varchar(100),
alamat varchar(100),
no_telp varchar(100)) engine=InnoDB;

-- buat table penerbit
create table penerbit
(id_penerbit char (10) not null primary key,
Nama_penerbit varchar(100),
alamat varchar (100),
no_telp varchar(100))engine=InnoDB;

-- buat table buku
create table buku
(id_buku char(10) not null primary key, 
id_penerbit char(10), -- foreign key must exist in line
judul varchar(155),
tahun_terbit year,
foreign key (id_penerbit) references penerbit(id_penerbit))engine=InnoDB;

-- buat table penulis 
create table penulis
(id_penulis char(10) not null primary key,
nama varchar(100),
alamat varchar(100),
bidang_ilmu varchar(100))engine=InnoDB;

-- buat table relasi penulisan
create table penulisan
(id_penulis char(10),
id_buku char(10),
foreign key (id_penulis) references penulis(id_penulis),
foreign key (id_buku) references buku(id_buku))engine=InnoDB;

-- buat table peminjaman
create table peminjaman
(id_peminjaman char(10) not null primary key,
id_anggota char(10),
id_pustakawan char (10),
tanggal_pinjam date,
lama_pinjam int,
tanggal_kembali date, -- perintah hapus kolom
foreign key (id_anggota) references anggota(id_anggota),
foreign key (id_pustakawan ) references pustakawan(id_pustakawan))engine=InnoDB;


-- buat table detail_peminjaman
create table detail_peminjaman
(id_peminjaman char(10),
id_buku char(10), -- jika boleh pinjam buku yang sama >1 tambahkan kolom jumlah
foreign key (id_buku) references buku(id_buku),
foreign key (id_peminjaman) references peminjaman(id_peminjaman))engine=InnoDB;

-- hapus kolom tanggal_kembali di peminjaman
alter table peminjaman drop column tanggal_kembali;

use dbdarren_si4z; -- dijalankan saat baru mulai

create database if not exists dbdarren_si4z;

-- database tidak bisa dibuat adalah database yang ada tanda/symbol tapi dengan tanda $ bisa
create database dbi;
drop database if exists dbi;

-- menampilkan seluruh database yang ada
show databases;

-- menampilkan struktur tabel dari tabel anggota
explain anggota;

-- ubah tipe kolom no_telp pada tabel anggota menjadi varchar (255) dan yang bisa di modify itu yang bukan primary key
alter table anggota modify no_telp varchar (255);

-- ubah tipe kolom id_anggota pada tabel anggota menjadi int
alter table anggota modify id_anggota int; -- tidak bisa karena ada relasi antar tabel

-- ubah nama kolom no_telp pada tabel anggota menjadi telepon;
alter table anggota change no_telp telepon varchar (100);

-- menampilkan seluruh isi tabel anggota
select * from anggota;

-- buat table coba (untuk eksekusi rename)
create table coba
(id int auto_increment primary key, -- syarat auto increment adalah primary key sehingga tidak bisa diubah/dihapus
nama varchar(25))engine=InnoDB;

-- ubah nama table coba menjadi coba1,dan hanya bisa jika belum berelasi
rename table coba to coba1;

explain coba1; 
-- menghilangkan primary key di coba 1
alter table coba1 drop primary key;

-- ubah nama table sudah berelasi
rename table anggota to anggota1;

create table coba2
(id int primary key ,
nama char(10))engine=InnoDB;

-- hapus coba 2
alter table coba2 drop primary key;

-- tambahkan kolom baru pada tabel coba2
alter table coba2 add alamat varchar(100);

explain coba2;

-- tambahkan kolom jenis pada tabel coba2 setelah kolom nama
alter table coba2 add jenis varchar(25) after nama;

-- -----------------------------
select * from anggota1;
rename table anggota1 to anggota;

-- masukkan baris/ record ke tabel anggota (harus berurutan)
insert into anggota values("2226240011","DJALI SUANDRE","Jl rajawali no 14","0711-367-400");
-- masukkkan baris (sesuai kolom)
insert into anggota(id_anggota,alamat,nama)values("2226240023","jl sudirman 900","Olivia");

select * from anggota;
insert into anggota(alamat,nama) values("jl sudirman 900","Olivia");
delete from anggota where id_anggota="";

insert into anggota values("2226240031","BENNY CHANDRA","jalan veteran no 900","1231423");
insert into anggota values("2226240033","DARREN LOWELL","jalan km 5 no 100","0809001");
insert into anggota values("2226240044","Marcel Alpih Santy","jalan amphibi no 517","613467");
insert into anggota values("2226240088","MUHAMMAD AKBAR","jalan veteran no 200","7661423");
insert into anggota values("2226240090","JESSICA","jalan veteran no 900","34531423");
insert into anggota values("2226240124","TRIA NANDA MUGHNY","jalan pom xi no 809","08241423");
insert into anggota values("2226240125","CINDY","jalan mangkunegara 2","5861423");

-- masukkan baris table pustakawan
insert into pustakawan values("12345","ali sadikin","jalan 15 ilir","0812-42131");
insert into pustakawan values("12388","santi susanto","jalan vetean 9","0811-6688");

-- tampilkan alamat dari pustakawan yang bernama Ali sadikin
-- select (kolom yang ingin ditampilkan) from (tabel) where 
select alamat from pustakawan where nama="Ali sadikin";


-- tampilkan seluruh kolom tabel anggota dimana no_telp mengandung angka 8
select * from anggota where telepon like "%3%";
-- like %a -> belakangnya alter
-- like a% ->depannya a
-- like %a% -> didepan atau dibelakang atau ditengah karena ada a