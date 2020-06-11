CREATE DATABASE hanbai1;

USE hanbai1;

CREATE TABLE bumon (
 bumonCode varchar(3) NOT NULL COMMENT '部門コード',
 bumonmei varchar(18) DEFAULT NULL COMMENT '部門名',
 PRIMARY KEY (bumonCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE shiiresaki(
 shiiresakiCode varchar(4) NOT NULL COMMENT '仕入先コード',
 shiiresakimeiKana varchar(20) COMMENT '仕入先名カナ',
 shiiresakimei varchar(40) COMMENT '仕入先名',
 shiiresakiJuushoKana varchar(40) COMMENT '仕入先住所カナ',
 shiiresakiJuusho varchar(80) COMMENT '仕入先住所',
 shiiresakiYuubinBangou varchar(8) COMMENT '仕入先郵便番号',
 shiiresakiDenwaBangou varchar(12) COMMENT '仕入先電話番号',
 shiiresakiFAXbangou varchar(12) COMMENT '仕入先FAX番号',
 shiiresakiTourokubi date COMMENT '仕入先登録日',
 shiiresakiTantousya varchar(14) COMMENT '仕入先担当者',
 kaikakekinZandaka int(8) COMMENT '買掛金残高',
 PRIMARY KEY (shiiresakiCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE shouhin (
  shouhinCode varchar(5) NOT NULL COMMENT '商品コード',
  shouhinmei varchar(40) DEFAULT NULL COMMENT '商品名',
  uriageTanka int(6) DEFAULT NULL COMMENT '売上単価',
  tani varchar(6) DEFAULT NULL COMMENT '単位',
  shiireTanka int(11) DEFAULT NULL COMMENT '仕入単価',
  shiiresakiCode varchar(4) NOT NULL COMMENT '仕入先コード',
  zaikosuu int(4) DEFAULT NULL COMMENT '在庫数',
  anzenZaikosuu int(4) DEFAULT NULL COMMENT '安全在庫数',
  hacchuuTani int(4) DEFAULT NULL COMMENT '発注単位',
  hacchuuHuragu varchar(1) DEFAULT '0' COMMENT '発注フラグ',
  PRIMARY KEY (shouhinCode),
  FOREIGN KEY (shiiresakiCode) REFERENCES shiiresaki(shiiresakiCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE shiharai(
shiharaiCode int(3) NOT NULL COMMENT '支払コード',
shiharaiHiduke date COMMENT '支払日付',
shiiresakiCode varchar(4) NOT NULL COMMENT '仕入先コード',
shiharaigaku int(8) COMMENT '支払額',
PRIMARY KEY (shiharaiCode),
FOREIGN KEY (shiiresakiCode) REFERENCES shiiresaki(shiiresakiCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE hachuudata(
hachuuCode int(4) NOT NULL COMMENT '発注コード',
hachuuhiduke date COMMENT '発注日付',
shiiresakiCode varchar(4) NOT NULL COMMENT '仕入先コード',
hachuuKibouNounyuuHiduke date COMMENT '発注希望納入日付',
hachuuNounyuuHiduke date COMMENT '発注納入日付',
PRIMARY KEY (hachuuCode),
FOREIGN KEY (shiiresakiCode) REFERENCES shiiresaki(shiiresakiCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tantousya (
  tantousyaCode varchar(3) NOT NULL COMMENT '担当者コード',
  tantousyaName varchar(18) DEFAULT NULL COMMENT '担当者名',
  password varchar(12) NOT NULL COMMENT '担当者パスワード',
  bumonCode varchar(3) DEFAULT NULL COMMENT '部門コード',
  PRIMARY KEY (tantousyaCode),
  FOREIGN KEY (bumonCode) REFERENCES bumon(bumonCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE kokyaku(
  kokyakuCode varchar(5) NOT NULL COMMENT '顧客コード',
  kokyakumeiKana varchar(20) DEFAULT NULL COMMENT '顧客名カナ',
  kokyakumei varchar(40) DEFAULT NULL COMMENT '顧客名',
  kokyakuJuushoKana varchar(40) DEFAULT NULL COMMENT '顧客住所カナ',
  kokyakuJuusho varchar(80) DEFAULT NULL COMMENT '顧客住所',
  kokyakuYuubinBangou varchar(8) DEFAULT NULL COMMENT '顧客郵便番号',
  kokyakuDenwaBangou varchar(12) DEFAULT NULL COMMENT '顧客電話番号',
  kokyakuFAXbangou varchar(12) DEFAULT NULL COMMENT '顧客ＦＡＸ番号',
  kokyakuTourokubi date DEFAULT NULL COMMENT '顧客登録日',
  shinyouGendogaku int(8) DEFAULT NULL COMMENT '信用限度額',
  eigyouTantouCode varchar(3) NOT NULL COMMENT '営業担当コード',
  urikakekinZandaka int(8) DEFAULT NULL COMMENT '売掛金残高',
  PRIMARY KEY (kokyakuCode),
  FOREIGN KEY(eigyouTantouCode) REFERENCES tantousya(tantousyaCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE nyukindata(
nyukinCode int(4) NOT NULL COMMENT '入金コード',
nyukinHiduke date DEFAULT NULL COMMENT '入金日付',
PRIMARY KEY (nyukinCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE seikyuudata(
seikyuusyoBangou int(4) NOT NULL COMMENT '請求データ',
seikyuuhiduke date COMMENT '請求日付',
nyukinCode int(4) COMMENT '入金コード',
PRIMARY KEY (seikyuusyoBangou),
FOREIGN KEY (nyukinCode) REFERENCES nyukindata(nyukinCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE uriagedata (
  juchuuCode int(5) NOT NULL COMMENT '受注コード',
  juchuuHiduke date DEFAULT NULL COMMENT '受注日付',
  nounyuuKiboubi date DEFAULT NULL COMMENT '納入希望日',
  nounyuuHiduke date DEFAULT NULL COMMENT '納入日付',
  kokyakuCode varchar(5) NOT NULL COMMENT '顧客コード',
  nounyuuSaki varchar(80) DEFAULT NULL COMMENT '納入先',
  tantousyaCode varchar(3) NOT NULL COMMENT '担当者コード',
  seikyuusyoBangou int(4) DEFAULT NULL COMMENT '請求書番号',
  PRIMARY KEY (juchuuCode),
  FOREIGN KEY (kokyakuCode) REFERENCES kokyaku(kokyakuCode),
  FOREIGN KEY (tantousyaCode) REFERENCES tantousya(tantousyaCode),
  FOREIGN KEY (seikyuusyoBangou) REFERENCES seikyuudata(seikyuusyoBangou)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE uriagemeisaidata (
  juchuuCode int(11) NOT NULL DEFAULT '0' COMMENT '受注コード',
  shouhinCode varchar(5) NOT NULL DEFAULT '' COMMENT '商品コード',
  uriageSuuryou int(11) DEFAULT NULL COMMENT '売上数量',
  PRIMARY KEY (juchuuCode,shouhinCode),
  FOREIGN KEY (juchuuCode) REFERENCES uriagedata(juchuuCode),
  FOREIGN KEY (shouhinCode) REFERENCES shouhin(shouhinCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE hachuumeisaidata(
hachuuCode int(4) NOT NULL COMMENT '発注コード',
shouhinCode varchar(5) NOT NULL COMMENT '商品コード',
shiiresuuryou int(4) DEFAULT NULL COMMENT '仕入数量',
PRIMARY KEY (hachuuCode,shouhinCode),
FOREIGN KEY (hachuuCode) REFERENCES hachuudata(hachuuCode),
FOREIGN KEY (shouhinCode) REFERENCES shouhin(shouhinCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into bumon(bumonCode,bumonmei) values('1','経理課');
insert into bumon(bumonCode,bumonmei) values('2','営業課');
insert into bumon(bumonCode,bumonmei) values('3','倉庫課');
insert into bumon(bumonCode,bumonmei) values('4','管理課');

insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('1101','ﾐﾄﾞﾘｼｮｳｼ','緑商事','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾜｾﾀﾞﾂﾙﾏｷﾏ?XXX','東京都新宿区早稲田鶴巻町 ＸＸＸ','162-XXXX','03-3202-XXX','03-3202-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'小北喜美','10500');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('1102','ﾁｮｳﾓﾝｼｮｳｼﾞ','長門商事','ﾔﾏｸﾞﾁｹﾝｼﾓﾉｾｷｼﾋｺｼﾏﾑｶｲﾁｮ?X-X-XX','山口県下関市彦島向井町 Ｘ－Ｘ－ＸＸ','750-XXXX','0832-67-XXX','0832-67-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'潮田恵子','24150');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('1201','ﾑｻｼﾌﾞｯｻﾝ','武蔵物産','ﾆｲｶﾞﾀｹﾝｶｼﾜｻﾞｷｼﾔﾏﾓﾄ XXX-XX','新潟県柏崎市山本 ＸＸＸ－ＸＸ','945-XXXX','0257-27-XXX','0257-24-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'桑野久美','693000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('1301','ｲｯｷｭｳﾃﾞﾝｺｳ','一休電工','ﾄｳｷｮｳﾄﾑｻｼﾉｼｾｷﾏ?X-X-XX','東京都武蔵野市関前 Ｘ－Ｘ－ＸＸ','180-XXXX','0422-55-XXX','0422-55-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'鈴木保美','281400');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('1302','ｷﾘｼﾀｺｳｷﾞｮｳ','桐下工業','ｶﾅｶﾞﾜｹﾝｶﾜｻｷｼﾀﾏ?X-X-X','神奈川県川崎市多摩区 Ｘ－Ｘ－Ｘ','214-XXXX','044-254-XXX','044-254-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'細野庄司','69300');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('1401','ｴﾊﾗｵﾛｼﾄﾝ','江原卸問屋','ﾄｳｷｮｳﾄｽﾐﾀﾞｸﾀﾁﾊﾞﾅ XXX-XX','東京都墨田区橘 ＸＸＸ－ＸＸ','131-XXXX','03-3613-XXX','03-3613-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'岸田翔子','31500');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2101','ﾒﾀﾞﾁｾｲｻｸｼｮ','目立製作所','ﾄｳｷｮｳﾄｼﾅﾝﾞﾜｸﾐﾅﾐｵｵｲ X-X-XX','東京都品川区南大井 Ｘ－Ｘ－ＸＸ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'高田庄一','25766400');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2102','ﾊﾀ','ＨＡＴＡＣＨＩ','ﾄｳｷｮｳﾄｼﾅﾝﾞﾜｸﾐﾅﾐｵｵｲ X-X-XX','東京都品川区南大井 Ｘ－ＸＸＸ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'柴田貴子','626250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2103','ｶﾀ','ＫＡＴＡＣＨＩ','ﾄｳｷｮｳﾄｼﾅﾝﾞﾜｸﾐﾅﾐｵｵｲ X-X-XX','東京都品川区南大井 Ｘ－ＸＸ－Ｘ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'末次恭一','600000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2201','ｴｿﾞｺｳｷﾞｮ','蝦夷工業','ﾄｳｷｮｳﾄｴﾄﾞｶﾞﾜｸﾋﾗｲ X-X-X','東京都江戸川区平井　Ｘ－Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'長島幸子','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('1001','ﾒｲｼﾞｼｮｳﾃ','明治商店','ﾄｳｷｮｳﾄｱﾀﾞﾁｸｸﾘﾊ?X-XX-X','東京都足立区栗原 Ｘ－ＸＸ－Ｘ','123-XXXX','03-3858-XXX','03-3858-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'川月 一','21000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2202','ﾑﾂｼｮｳｶ','陸奥商会','ﾄｳｷｮｳﾄｱﾀﾞﾁｸｾﾝｼﾞｭｶﾝﾉﾝ X-X','東京都足立区千住観音　Ｘ－Ｘ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'王貞子','474250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2203','ﾃﾞﾜｻﾝｷﾞｮ','出羽産業','ﾄｳｷｮｳﾄｷﾀｸｵｳｼ?X-XX','東京都北区王子　Ｘ－ＸＸ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'黒江真一','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2204','ﾋﾀﾁｺｳｷﾞｮ','常陸工業','ﾄｳｷｮｳﾄｱﾗｶﾜｸﾆｯﾎﾟﾘ1ﾁｮｳﾒ X-X','東京都荒川区日暮里１丁目　Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'鈴木幸','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2205','ｶｽﾞｻｿｳｺﾞｳｻﾝｷﾞｮ','上総総合産業','ﾄｳｷｮｳﾄﾀｲﾄｳｸﾋｶﾞｼｳｴﾉ X-X','東京都台東区東上野　Ｘ－Ｘ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'函館さち','26250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2206','ｱﾜｺｳﾑﾃ','安房工務店','ﾄｳｷｮｳﾄﾀｲﾄｳｸｳｴﾉ X-X','東京都台東区上野　Ｘ－Ｘ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'秋葉恭一','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2207','ｶｲﾃﾞﾝｷｻﾝｷﾞｮｳ','甲斐電気産業','ﾄｳｷｭｳﾄﾀｲﾄｳｸﾆｼｳｴﾉ X-X','東京都台東区西上野　Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'神田正木','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2208','ｼﾅﾉｺｳｼﾞｮ','信濃工場','ﾄｳｷｮｳﾄﾐﾅﾄｸｵﾀﾞｲﾊﾞ1ﾁｮｳﾒ X-X','東京都港区お台場１丁目　Ｘ－Ｘ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'東健太','26250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2209','ｴﾁｺﾞｾｲｿﾞ','越後製造','ﾄｳｷｮｳﾄﾐﾅﾄｸｵﾀﾞｲﾊﾞ2ﾁｮｳﾒ X-X','東京都港区お台場２丁目　Ｘ－Ｘ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'織田有楽','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2210','ｲｽﾞｺｳｷﾞｮ','いず工業','ﾄｳｷｮｳﾄﾐﾅﾄｸｵﾀﾞｲﾊﾞ3ﾁｮｳﾒ X-X','東京都港区お台場３丁目　Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'新橋ゆわこ','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2211','ﾐｶ','ＭＩＫＡＷＡ','ﾄｳｷｮｳﾄｺｳﾄｳｸｶﾒｲﾄﾞ1ﾁｮｳﾒ X-XX','東京都江東区亀戸１丁目　Ｘ－Ｘ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'浜長一','26250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2212','ｴｯﾁｭｳｻﾝｷﾞｮ','越中産業','ﾄｳｷｮｳﾄｺｳﾄｳｸｶﾒｲﾄﾞ2ﾁｮｳﾒ X-XX','東京都江東区亀戸２丁目　Ｘ－Ｘ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'多街章子','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2213','ｴﾁｺﾞﾁﾘﾒﾝﾄﾞ','越後ちりめん堂','ﾄｳｷｮｳﾄｺｳﾄｳｸｶﾒｲﾄﾞ3ﾁｮｳﾒ X-XX','東京都江東区亀戸３丁目　Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'北川祥子','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2214','ﾐﾉｺｳｷﾞｮｳ','美濃工業','ﾄｳｷｮｳﾄｺｳﾄｳｸｶﾒｲﾄﾞ4ﾁｮｳﾒ X-XX','東京都江東区亀戸４丁目　Ｘ－Ｘ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'稲毛強','26250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2215','ｵﾜﾘｾﾞﾈﾗﾘｽﾄ','オワリゼネラリスト','ﾄｳｷｮｳﾄｺｳﾄｳｸｶﾒｲﾄﾞ5ﾁｮｳﾒ X-XX','東京都江東区亀戸５丁目　Ｘ－Ｘ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'田原拓也','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2216','ｼﾏﾄﾝ','志摩問屋','ﾄｳｷｮｳﾄｺｳﾄｳｸｶﾒｲﾄﾞ6ﾁｮｳﾒ X-XX','東京都江東区亀戸６丁目　Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'桑原 保二','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2217','ｷｲﾀﾞｲﾅｺﾞﾝｻﾝｷﾞｮ','紀伊大納言産業','ﾄｳｷｮｳﾄｼﾌﾞﾔｸｼﾌﾞ?X-X-XX','東京都渋谷区渋谷　Ｘ－Ｘ－ＸＸ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'尾田 裕','26250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2218','ｽﾙｶﾞｼｮｳﾃ','するが商店','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾜｾﾀ?ﾁｮｳﾒ X-XX','東京都新宿区早稲田２丁目　Ｘ－ＸＸ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'森野熊','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2219','ﾅﾆﾜｺｳｷﾞｮ','浪速工業','ﾄｳｷｮｳﾄﾄｼﾏｸﾋｶﾞｼｲｹﾌﾞｸﾛ X-X-X','東京都豊島区東池袋　Ｘ－Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'桑保かな','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2220','ｴﾁｾﾞﾝｼｮｳｶｲ','越前商会','ﾄｳｷｮｳﾄﾄｼﾏｸﾐﾅﾐｲｹﾌﾞｸ?X-X-X','東京都豊島区南池袋　Ｘ－Ｘ－Ｘ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'田道道代','26250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2221','ｼﾓｳｻｿｳｺﾞｳｼｮｳｼﾞ','下総総合商事','ﾄｳｷｮｳﾄﾄｼﾏｸｷﾀｲｹﾌﾞｸﾛ X-X-X','東京都豊島区北池袋　Ｘ－Ｘ－Ｘ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'森泉一','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2222','ｲｾｶｲｳﾝ','伊勢海運','ﾄｳｷｮｳﾄﾄｼﾏｸﾆｼｲｹﾌﾞｸﾛ X-X-X','東京都豊島区西池袋　Ｘ－Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'原保','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2223','ﾄｻﾀﾞｲｼｮｳｼﾞ','土佐大商事','ｻｲﾀﾏｹﾝｿｳｶｼﾏﾂﾊﾞ?X-X-X','埼玉県草加市松原　Ｘ－Ｘ－Ｘ','140-XXXX','03-3333-XXX','03-3333-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'桑一原保','1260000');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2224','ｱﾜｺｳｷﾞｮｳ','阿波工業','ｻｲﾀﾏｹﾝﾊﾄｶﾞﾔｼﾊﾄｶﾞ?X-XXX','埼玉県鳩ヶ谷市鳩ヶ谷　Ｘ－ＸＸＸ','140-XXXX','03-1111-XXX','03-1111-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'田裕道一','26250');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2225','ｵｵｴﾄﾞｺｳﾑﾃﾝ','大江戸工務店','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾄｳｷｮｳ X-X-X','東京都千代田区東京　Ｘ－Ｘ－Ｘ','140-XXXX','03-2222-XXX','03-2222-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'森川高志','0');
insert into shiiresaki(shiiresakiCode,shiiresakimeiKana,shiiresakimei,shiiresakiJuushoKana,shiiresakiJuusho,shiiresakiYuubinBangou,shiiresakiDenwaBangou,shiiresakiFAXbangou,shiiresakiTourokubi,shiiresakiTantousya,kaikakekinZandaka) values('2226','ﾀﾞｲﾆﾎﾝｺｳｷﾞｮｳ','大日本工業','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾛｯﾎﾟﾝｷﾞ X-X-X','東京都新宿区六本木　Ｘ－Ｘ－Ｘ','140-XXXX','03-7777-XXX','03-7777-XXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'米国一番','0');

insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10311','小見出し付箋','1500','箱','1200','1001','100','300','372');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10312','インデックス付箋（蛍光）','3500','箱','2800','1101','100','300','326');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10321','伝言メモ','7500','箱','6000','1301','100','300','145');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10322','A4集計用紙','1500','箱','1200','1102','100','300','297');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10333','A2トレーシングペーパ','3000','箱','2400','2101','100','300','339');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10334','カーボン紙','4000','箱','3200','1301','100','300','296');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10341','ノートA罫B5','1000','箱','800','1101','100','300','170');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10342','ノートB罫B5','1000','箱','800','1102','100','300','210');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10343','ノートA罫A4','2000','箱','1600','1401','100','300','696');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10344','ノートB罫A4','2500','箱','2000','2101','100','300','233');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10345','レポート用紙A罫B5','1500','箱','1200','1001','100','300','387');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10346','レポート用紙B罫B5','2200','箱','1760','1101','100','300','261');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10351','入金伝票A','500','箱','400','1101','300','500','478');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10352','入金伝票B','750','箱','600','1101','300','500','504');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10353','出金伝票A','500','箱','400','1102','300','500','636');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10354','出金伝票B','750','箱','600','1201','300','500','468');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10355','振替伝票','500','箱','400','1201','300','500','386');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10361','領収書A','1400','箱','1120','2101','100','300','144');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10362','領収書B','1750','箱','1400','1101','100','300','157');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10363','請求書A','1250','箱','1000','1101','100','300','254');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10364','請求書B','1500','箱','1200','1201','100','300','109');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10365','納品書A','1000','箱','800','1401','100','300','226');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10366','納品書B','1750','箱','1400','2101','100','300','153');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10367','納品書C','1800','箱','1440','1101','100','300','148');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20410','鉛筆','350','ダース','280','2101','300','500','473');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20411','消しゴム付き鉛筆','500','ダース','400','1001','300','500','466');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20412','赤鉛筆A','480','ダース','384','2101','300','500','393');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20413','赤鉛筆B','550','ダース','440','1301','300','500','639');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20414','色鉛筆朱藍 5:5','600','ダース','480','1301','300','500','361');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20415','色鉛筆12色セット','750','箱','600','2101','300','500','669');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20416','色鉛筆24色セット','1200','箱','960','2101','100','300','301');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20417','鉛筆削り','1200','箱','960','1401','100','300','296');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20418','電動鉛筆削り','3500','個','2800','2101','100','300','363');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20419','シャープ芯','1440','ダース','1152','1001','100','300','137');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20420','ボールペン黒','1200','ダース','960','1001','100','300','322');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20421','ボールペン赤','1200','ダース','960','1001','100','300','373');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20422','ボールペン青','1200','ダース','960','1301','100','300','152');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20423','ボールペン（油性）','960','ダース','768','1102','300','500','434');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20424','サインペン太字','1800','ダース','1440','1102','100','300','389');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20425','サインペン中細','2160','ダース','1728','1301','100','300','205');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20426','サインペン細字','2160','ダース','1728','2101','100','300','256');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20427','ホワイトボードマーカ','3000','ダース','2400','1201','100','300','127');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20428','ボードマーカー','1800','箱','1440','1201','100','300','370');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20429','蛍光ペン','1800','ダース','1440','1302','100','300','205');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20430','消しゴム','1000','箱','800','2101','100','300','125');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20431','消しゴム（ダストフリー）','850','箱','680','1302','300','500','753');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20432','電動消しゴム','2400','個','1920','1401','100','300','169');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20433','修正ペン','2800','箱','2240','2101','100','300','159');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20434','字消しペン','2500','箱','2000','2101','100','300','265');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20435','修正液','4500','箱','3600','1102','100','300','129');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20436','修正液（ワープロ用）','5000','箱','4000','1001','100','300','114');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20437','修正テープ','2800','箱','2240','1102','100','300','140');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20438','修正テープ（ワープロ用）','5000','箱','4000','1102','100','300','122');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('20439','交換テープ','800','箱','640','1302','300','500','722');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30510','ラベルライタ','35000','個','28000','1401','50','150','158');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30511','ラベルテープカートリ','10000','箱','8000','2101','50','150','69');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30512','ホッチキス','8000','箱','6400','1101','100','300','250');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30513','厚とじホッチキス','4500','個','3600','1302','100','300','210');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30514','ホッチキス針50mm','600','箱','480','2101','300','500','360');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30515','ダブルクリップ','4500','箱','3600','1201','100','300','181');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30516','特大ゼムクリップ','4000','箱','3200','1201','100','300','347');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30517','ゼムクリップ','2500','箱','2000','2102','100','300','158');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30518','目玉クリップ','750','箱','600','1302','300','500','787');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30519','カッター','500','個','400','2103','300','500','458');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30520','直定規(30cm)','300','個','240','1001','300','500','727');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30521','直定規(50cm)','500','個','400','2103','300','500','303');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30522','ペーパーパンチ','560','個','448','2202','300','500','598');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30523','多用途はさみ','1500','個','1200','1401','100','300','320');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30524','裁断機','10000','個','8000','1101','50','150','85');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30525','カッティングマット','1500','個','1200','2101','100','300','262');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30556','ラベル','300','個','240','2101','300','500','410');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30557','インデックスラベル','300','個','240','1401','300','500','589');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30558','カラーインデックス','250','個','200','1102','300','500','528');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('30559','フィルム付きラベル','380','個','304','1201','300','500','608');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40370','クリアボックス','1200','個','980','1301','100','300','284');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40610','OHP','45000','個','36000','1302','50','150','107');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40611','OHPフィルム','8000','個','6400','2101','100','300','150');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40612','レーザーポインタ','8500','個','6800','1001','100','300','250');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40613','ホワイトボード（壁掛用）','9800','個','7840','2101','100','300','150');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40614','ホワイトボード（キャビネ用）','36500','個','29200','1101','50','150','149');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40615','ホワイトボードマーカ','250','個','200','2101','300','500','620');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40616','ホワイトボード用イレイサー','600','個','480','1001','300','500','451');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40617','電子黒板','120000','個','96000','1302','50','150','86');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40618','電子黒板用感熱紙','5000','箱','4000','2101','100','300','257');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40619','タイムレコーダ','40000','個','32000','1001','50','150','82');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40620','タイムレコーダ用カード','18000','箱','14400','2101','50','150','118');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40621','シュレッダ','10000','個','8000','1101','50','150','80');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40622','掃除機','20000','個','16000','2101','50','150','197');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40623','電気エアーポット','10000','個','8000','1001','50','150','64');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40624','工事用アルバムセット','1800','個','1440','1201','100','300','399');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40625','ポラロイドカメラ','18000','個','14400','1101','50','150','95');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40626','ポケットMD','50000','個','40000','2101','50','150','149');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40627','コーヒーメーカー（10杯用）','15000','個','12000','1001','50','150','67');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40628','コーヒーメーカー（エプレッソ用','20000','個','16000','1302','50','150','136');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40629','オフィスブレンド','50000','個','40000','1101','50','150','165');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40630','紙コップ','10000','箱','8000','2101','50','150','118');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40631','使い捨てカップ','3000','箱','2400','1101','100','300','241');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40632','カップホルダー','20000','箱','16000','1302','50','150','55');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40633','マドラー','12000','箱','9600','1201','50','150','182');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40634','シュガースティック','1000','箱','800','1102','100','300','310');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('10310','ノート型付箋','1500','箱','1200','1001','100','300','297');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40635','クリアファイル（白）','350','箱','280','1301','300','500','676');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40636','クリアファイル（青）','350','箱','280','1301','300','500','485');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40637','クリアファイル（赤）','350','箱','280','1301','300','500','519');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40638','クリアファイル（黄）','350','箱','280','1301','300','500','646');
insert into shouhin(shouhincode,shouhinmei,uriagetanka,tani,shiiretanka,shiiresakicode,zaikosuu,anzenzaikosuu,hacchuutani) values('40639','クリアファイル（茶）','350','箱','280','1301','300','500','507');

insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('101','上野　俊之','111111','1');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('102','日暮　圭一郎','111111','2');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('103','千住　洋次','111111','3');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('201','松戸　香奈','111111','4');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('202','柏　純一','111111','1');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('203','我孫子　かおる','111111','2');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('204','取手　浩二','111111','3');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('301','日暮　祐子','111111','4');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('302','水戸　さやか','11111','2');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('303','茨　気一郎','111111','3');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('401','大宮　庄一','111111','1');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('402','与野　悟','111111','2');
insert into tantousya(tantousyacode,tantousyaname,password,bumoncode) values('403','川口　公','111111','3');

insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('19000','ｵｵﾊｼｼｮｳｶ','大橋商会','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾐｻｷﾁｮ?ﾁｮｳﾒ X-X','東京都千代田区三崎町１丁目　Ｘ－Ｘ','166-XXXX','03-3312-XXXX','03-3312-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','101','0');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('19500','ｽﾐﾖｼｻﾝｷﾞｮｳ','住吉産業','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾖﾂﾔ7ﾁｮｳﾒ X-XX','東京都新宿区四谷７丁目　Ｘ－ＸＸ','162-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2100000','101','2081140');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('18500','ｵｼｱｹﾞｻｰﾋﾞｽ','押上サービス','ﾄｳｷｮｳﾄｼﾅｶﾞﾜｸﾋｶﾞｼｺﾞﾀﾝﾀﾞ2ﾁｮｳﾒ X-X','東京都品川区東五反田２丁目　Ｘ－Ｘ','169-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2600000','201','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('11100','ｶﾝﾀﾞﾂｳｼﾝｷｻﾝｷﾞｮ','神田通信機産業','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸｶﾝﾀﾞｱﾜｼﾞﾁｮｳ X-X-X','東京都千代田区神田淡路町　Ｘ－Ｘ－Ｘ','101-XXXX','03-3264-XXXX','03-3264-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'80000000','202','346500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('11000','ﾄｳｷｮｳｻｰﾋﾞｽ','東京サービス','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾋﾄﾂﾊﾞ?ﾁｮｳﾒ X-XX','東京都千代田区一ツ橋２丁目　Ｘ－ＸＸ','100-XXXX','03-3264-XXXX','03-3264-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'4000000','103','3181960');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('11200','ｱｷﾊﾊﾞﾗｺｳｷﾞｮｳ','秋葉原工業','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾋｶﾞｼｶﾝﾀ?ﾁｮｳﾒ XX-XXX','東京都千代田区東神田３丁目　ＸＸ－ＸＸＸ','101-XXXX','03-3264-XXXX','03-3264-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'4000000','203','262500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('11300','ｵｶﾁﾏﾁｾｲｻｸｼ','御徒町製作所','ﾄｳｷｮｳﾄﾌﾞﾝｷｮｳｸﾕｼﾏ2ﾁｮｳﾒ X-X','東京都文京区湯島２丁目　Ｘ－Ｘ','113-XXXX','03-3812-XXXX','03-3812-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'4400000','301','0');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('12000','ｵｵﾂｶﾃﾞﾝｷﾊﾝﾊﾞ','大塚電気販売','ﾄｳｷｮｳﾄﾄｼﾏｸﾐﾅﾐｵｵﾂ?ﾁｮｳﾒ XXX','東京都豊島区南大塚２丁目　ＸＸＸ','170-XXXX','03-3981-XXXX','03-3981-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'6000000','101','168000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('12100','ｲｹﾌﾞｸﾛｼｮｳｼ','池袋商事','ﾄｳｷｮｳﾄﾄｼﾏｸｲｹﾌﾞｸﾛ3ﾁｮｳﾒ XX-X','東京都豊島区池袋３丁目　ＸＸ－Ｘ','171-XXXX','03-3981-XXXX','03-3981-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'5000000','101','525000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('12200','ﾒｼﾞﾛｼｮｳﾃ','目白商店','ﾄｳｷｮｳﾄﾄｼﾏｸﾒｼﾞﾛ1ﾁｮｳﾒ X-XX-XXX','東京都豊島区目白１丁目　Ｘ－ＸＸ－ＸＸＸ','171-XXXX','03-3981-XXXX','03-3981-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','203','1836712');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('12400','ｼﾝｵｵﾂｶﾄﾞ','新大塚堂','ﾄｳｷｮｳﾄﾄｼﾏｸｵｵﾂｶ4ﾁｮｳﾒ XX-X','東京都豊島区大塚４丁目　ＸＸ－Ｘ','171-XXXX','03-3981-XXXX','03-3981-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'3000000','202','2936810');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('12600','ﾎﾎｷﾞｺｸｻｲﾃﾞﾝｷ','代々木国際電気','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾖﾖｷ?ﾁｮｳﾒ X-XX','東京都新宿区代々木３丁目　Ｘ－ＸＸ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'3500000','102','2774100');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('12700','ﾊﾗｼﾞｭｸﾃﾞﾝｼ','原宿電子','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸｼﾞﾝｸﾞｳﾏ?ﾁｮｳﾒ X-X','東京都新宿区神宮前１丁目　Ｘ－Ｘ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2000000','302','1312500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('13000','ｴﾋﾞｽｼｮｳｼ','えびす商事','ﾄｳｷｮｳﾄｼﾌﾞﾔｸｴﾋﾞｽﾐﾅﾐ1ﾁｮｳﾒ XX-XX','東京都渋谷区恵比寿南１丁目　ＸＸ－ＸＸ','160-XXXX','03-3463-XXXX','03-3463-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'90000000','302','52500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('13200','ｺﾞﾀﾝﾀﾞｼﾞﾑｷﾊﾝﾊﾞ','五反田事務機販売','ﾄｳｷｮｳﾄｼﾅｶﾞﾜｸﾋｶﾞｼｺﾀﾝﾀ?ﾁｮｳﾒ X-X','東京都品川区東五反田５丁目　Ｘ－Ｘ','140-XXXX','03-3777-XXXX','03-3777-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'10000000','101','4131750');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('14000','ｽｲﾄﾞｳﾊﾞｼﾎﾝﾎﾟ','水道橋本舗','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾐｻｷﾁｮ?ﾁｮｳﾒ X-X','東京都千代田区三崎町３丁目　Ｘ－Ｘ','101-XXXX','03-3264-XXXX','03-3264-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1900000','102','85260');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('14300','ﾖﾂﾔﾐﾂｹﾄﾞ','四谷見附堂','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾖﾂﾔ2ﾁｮｳﾒ X-XX','東京都新宿区四谷２丁目　Ｘ－ＸＸ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1000000','201','74340');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('14600','ｵｵｸﾎﾞｼｮｳｶｲ','大久保商会','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸｵｵｸﾎﾞ1ﾁｮｳﾒ XX-XXX','東京都新宿区大久保１丁目　ＸＸ－ＸＸＸ','169-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1000000','201','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('15000','ｱｻｶﾞﾔｼﾞﾄﾞｳｼｬ','阿佐ヶ谷自動車','ﾄｳｷｮｳﾄｽｷﾞﾅﾐｸｱｻｶﾞﾔｷ?X-XX','東京都杉並区阿佐ヶ谷北　Ｘ－ＸＸ','166-XXXX','03-3312-XXXX','03-3312-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1000000','101','0');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('15100','ｶｸﾞﾗｻﾞｶｼｮｳﾃﾝ','神楽坂商店','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸｶｸﾞﾗｻﾞｶ6ﾁｮｳﾒ X-X','東京都新宿区神楽坂６丁目　Ｘ－Ｘ','162-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1000000','101','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('15500','ｵｵﾓﾘｻｯ','大森サッシ','ﾄｳｷｮｳﾄｼﾅｶﾞﾜｸﾐﾅﾐｵｵｲ6ﾁｮｳﾒ X-X','東京都品川区南大井６丁目　Ｘ－Ｘ','140-XXXX','03-3777-XXXX','03-3777-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1000000','301','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('15600','ﾎﾝｺﾞｳｺｳﾓﾃﾝ','本郷工務店','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾋﾄﾂﾊﾞ?2ﾁｮｳﾒ X-XX','東京都千代田区一ツ橋１２丁目　Ｘ－ＸＸ','171-XXXX','03-3981-XXXX','03-3981-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'7000000','202','262500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('15700','ｼﾝﾃﾞﾝｼｮｳｶｲ','新田商会','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸｶﾝﾀﾞｱﾜｼﾞﾁｮｳｷﾀ X-XX','東京都千代田区神田淡路町北　Ｘ－Ｘ－Ｘ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'5000000','102','2774100');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('15800','ﾐﾉﾘﾄﾞｳ','みのり堂','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾆｼｶﾝﾀ?ﾁｮｳﾒ　XX-XXX','東京都千代田区西神田３丁目　ＸＸ－ＸＸＸ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1500000','302','1312500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('15900','ﾔﾊｼﾗｷｷ','八柱機器','ﾄｳｷｮｳﾄﾌﾞﾝｷｮｳｸﾕｼﾏ8ﾁｮｳﾒ X-X','東京都文京区湯島８丁目　Ｘ－Ｘ','160-XXXX','03-3463-XXXX','03-3463-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'90000000','302','3892050');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16000','ﾄｷﾜｿｳｺﾞｳｼｮｳｶ','常盤総合商会','ﾄｳｷｮｳﾄﾄｼﾏｸｵｵﾂｶ2ﾁｮｳﾒ XXX','東京都豊島区大塚２丁目　ＸＸＸ','140-XXXX','03-3777-XXXX','03-3777-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'10000000','101','4131750');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16100','ｺﾞｺｳｾｲｻｸｼｮ','御幸製作所','ﾄｳｷｮｳﾄﾄｼﾏｸﾋｶﾞｼｲｹﾌﾞｸﾛ3ﾁｮｳﾒ XX-X','東京都豊島区東池袋３丁目　ＸＸ－Ｘ','101-XXXX','03-3264-XXXX','03-3264-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'9000000','102','85260');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16200','ﾑﾂﾐｻﾝｷﾞｮ','睦美産業','ﾄｳｷｮｳﾄﾄｼﾏｸｼﾝﾒｼﾞﾛ1ﾁｮｳﾒ X-XX-XXX','東京都豊島区新目白１丁目　Ｘ－ＸＸ－Ｘ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'3000000','201','74340');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16300','ﾅﾅｺｳﾀﾞｲｻﾝｷﾞｮ','七光台産業','ﾄｳｷｮｳﾄﾄｼﾏｸｼﾝｵｵﾂｶ4ﾁｮｳﾒ XX-X','東京都豊島区新大塚４丁目　ＸＸ－Ｘ','169-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'3000000','201','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16400','ｺｳﾄｳﾌﾞﾝｸﾞﾃ','江東文具店','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾖﾖｷﾞｳｴﾊ?ﾁｮｳﾒ X-XX','東京都新宿区代々木上原３丁目　Ｘ－ＸＸ','166-XXXX','03-3312-XXXX','03-3312-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','101','0');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16500','ｷｸｶﾜｻﾝｷﾞｮｳ','菊川産業','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸｼﾝｼﾞﾝｸﾞｳﾏ?ﾁｮｳﾒ X-X','東京都新宿区新神宮前１丁目　Ｘ－Ｘ','162-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','101','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16600','ｱﾂﾞﾏｷｷﾊﾝﾊﾞ','吾妻機器販売','ﾄｳｷｮｳﾄｼﾌﾞﾔｸｴﾋﾞ?ﾁｮｳﾒ XX-XX','東京都渋谷区恵比寿１丁目　ＸＸ－ＸＸ','140-XXXX','03-3777-XXXX','03-3777-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','301','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16700','ﾏﾂ','松屋','ﾄｳｷｮｳﾄｼﾅｶﾞﾜｸｷﾀｺﾞﾀﾝﾀﾞ5ﾁｮｳﾒ X-X','東京都品川区北五反田５丁目　Ｘ－Ｘ','171-XXXX','03-3981-XXXX','03-3981-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'7000000','202','262500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16800','ｺﾄﾌﾞｷｺｳﾑﾃﾝ','寿工務店','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸｼﾝﾐｻｷﾁｮ?ﾁｮｳﾒ X-X','東京都千代田区新三崎町３丁目　Ｘ－Ｘ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'3500000','102','2774100');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('16900','ﾋｶﾞｼｵｵｼﾏｼｮｳﾃ','東大島商店','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾖﾂﾔﾐﾂ?ﾁｮｳﾒ X-XX','東京都新宿区四谷見附２丁目　Ｘ－ＸＸ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'1500000','302','1312500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17000','ｽﾐﾖｼｻﾝｷﾞｮｳ','住吉産業','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸｵｵｸﾎﾞ3ﾁｮｳﾒ XX-XXX','東京都新宿区大久保３丁目　ＸＸ－ＸＸＸ','160-XXXX','03-3463-XXXX','03-3463-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'90000000','302','52500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17100','ﾓﾘｼﾀｼｮｳｶ','森下商会','ﾄｳｷｮｳﾄｽｷﾞﾅﾐｸｱｻｶﾞ?X-XX','東京都杉並区阿佐ヶ谷　Ｘ－ＸＸ','140-XXXX','03-3777-XXXX','03-3777-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'10000000','101','4131750');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17200','ｷﾉｼﾀｶﾞﾜｼｮｳﾃﾝ','木下川商店','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸｶｸﾞﾗｻﾞｶﾀﾞ?X-X','東京都新宿区神楽坂台　Ｘ－Ｘ','101-XXXX','03-3264-XXXX','03-3264-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2900000','102','85260');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17300','ｽｲｼﾞﾝｺｳｷﾞｮ','水神工業','ﾄｳｷｮｳﾄｼﾅｶﾞﾜｸﾐﾅﾐｵｵｲ1ﾁｮｳﾒ X-X','東京都品川区南大井１丁目　Ｘ－Ｘ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2000000','201','74340');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17400','ﾅｶｲﾎﾞﾘｻﾝｷﾞｮｳ','中居堀産業','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾋﾄﾂﾊﾞｼｷ?ﾁｮｳﾒ X-XX','東京都千代田区一ツ橋北２丁目　Ｘ－ＸＸ','169-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','201','1022780');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17500','ｽﾐﾀﾞﾀﾞｲﾘﾃﾝ','墨田代理店','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸｶﾝﾀﾞｻﾙｶﾞｸﾁｮ?X-X-X','東京都千代田区神田猿楽町　Ｘ－Ｘ－Ｘ','166-XXXX','03-3312-XXXX','03-3312-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2600000','101','0');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17600','ｼﾞｭｯｹﾝﾄﾞ','十間堂','ﾄｳｷｮｳﾄﾁﾖﾀﾞｸｶﾝﾀ?ﾁｮｳﾒ XX-XXX','東京都千代田区神田３丁目　ＸＸ－ＸＸＸ','162-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2600000','101','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17700','ﾔﾋﾛｶｶﾞ','八広化学','ﾄｳｷｮｳﾄﾌﾞﾝｷｮｳｸﾕｼﾏﾃﾝｼﾞ?ﾁｮｳﾒ X-X','東京都文京区湯島天神２丁目　Ｘ－Ｘ','140-XXXX','03-3777-XXXX','03-3777-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','301','84000');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17800','ﾌﾞﾝｶﾄﾞ','文化堂','ﾄｳｷｮｳﾄﾄｼﾏｸｼﾝｵｵﾂｶ2ﾁｮｳﾒ XXX','東京都豊島区新大塚２丁目　ＸＸＸ','171-XXXX','03-3981-XXXX','03-3981-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','202','262500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('17900','ﾅﾘﾋﾗｿｳｺﾞｳｼｮｳﾃﾝ','業平総合商店','ﾄｳｷｮｳﾄﾄｼﾏｸｷﾀｲｹﾌﾞｸﾛ3ﾁｮｳﾒ XX-X','東京都豊島区北池袋３丁目　ＸＸ－Ｘ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2900000','102','2774100');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('18000','ｺﾄﾄｲｼｮｳﾃ','言問商店','ﾄｳｷｮｳﾄﾄｼﾏｸﾒｼﾞﾛﾀﾞ?ﾁｮｳﾒ X-XX-XXX','東京都豊島区目白台１丁目　Ｘ－ＸＸ－Ｘ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2600000','302','1312500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('18100','ﾏﾂﾔﾋｶﾞｼﾄｳｷｮｳｼﾃ','松屋東東京支店','ﾄｳｷｮｳﾄﾄｼﾏｸｵｵﾂｶｷﾀｶｾ?ﾁｮｳﾒ XX-X','東京都豊島区大塚北川４丁目　ＸＸ－Ｘ','160-XXXX','03-3463-XXXX','03-3463-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'90000000','302','52500');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('18200','ｽﾐﾖｼｻﾝｷﾞｮｳｺｳｷﾞｮｳ','住吉産業工業','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸﾖﾖｷﾞｺｳｴ?ﾁｮｳﾒ X-XX','東京都新宿区代々木公園３丁目　Ｘ－ＸＸ','140-XXXX','03-3777-XXXX','03-3777-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'10000000','101','4131750');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('18300','ﾎﾝｼﾞｮﾄﾞｳ','本所堂','ﾄｳｷｮｳﾄｼﾝｼﾞｭｸｸｼﾞﾝｸﾞｳﾐﾅﾐ1ﾁｮｳﾒ X-X','東京都新宿区神宮南１丁目　Ｘ－Ｘ','101-XXXX','03-3264-XXXX','03-3264-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2500000','102','85260');
insert into kokyaku(kokyakuCode,kokyakumeiKana,kokyakumei,kokyakuJuushoKana,kokyakuJuusho,kokyakuYuubinBangou,kokyakuDenwaBangou,kokyakuFAXbangou,kokyakuTourokubi,shinyouGendogaku,eigyouTantouCode,urikakekinZandaka) values('18400','ﾑｺｳｼﾞﾏｻﾝﾁｮｳﾒｼｮｳｶ','向島三丁目商会','ﾄｳｷｮｳﾄｼﾌﾞﾔｸｴﾋﾞｽﾀﾞｲ1ﾁｮｳﾒ XX-XX','東京都渋谷区恵比寿台１丁目　ＸＸ－ＸＸ','160-XXXX','03-3209-XXXX','03-3209-XXXX',STR_TO_DATE('21,5,2013','%d,%m,%Y'),'2600000','201','74340');


insert into uriageData(juchuuCode,juchuuHiduke,kokyakuCode,tantousyaCode) values('12345',20200420,'18500','102');
insert into uriageData(juchuuCode,juchuuHiduke,kokyakuCode,tantousyaCode) values('12572',20200422,'18500','102');
insert into uriageData(juchuuCode,juchuuHiduke,kokyakuCode,tantousyaCode) values('99992',20200421,'18500','102');
insert into uriageData(juchuuCode,juchuuHiduke,kokyakuCode,tantousyaCode) values('22222',20200420,'11100','102');
insert into uriageData(juchuuCode,juchuuHiduke,kokyakuCode,tantousyaCode) values('33333',20200421,'11100','102');

insert into uriagemeisaiData(juchuuCode,shouhinCode,uriageSuuryou) values('12345','10341','300');
insert into uriagemeisaiData(juchuuCode,shouhinCode,uriageSuuryou) values('12572','10345','400');            
insert into uriagemeisaiData(juchuuCode,shouhinCode,uriageSuuryou) values('99992','10355','500');
insert into uriagemeisaiData(juchuuCode,shouhinCode,uriageSuuryou) values('22222','20412','600');
insert into uriagemeisaiData(juchuuCode,shouhinCode,uriageSuuryou) values('33333','20415','700');


