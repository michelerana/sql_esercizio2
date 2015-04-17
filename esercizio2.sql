create database esercizio2;

use esercizio2;

create table Prodotto (
    id_prodotto int not null auto_increment,
    nome varchar(50) not null,
    categoria varchar(50) not null,
    prezzo float not null,
    primary key(id_prodotto)
);

create table Negozio (
    id_negozio int not null auto_increment,
    nome varchar(50) not null,
    primary key(id_negozio)
);

create table Vendita (
    prodotto int not null,
    negozio int not null,
    data date not null,
    quantita int not null,
    primary key(prodotto, negozio, data),
    foreign key(prodotto) references Prodotto(id_prodotto),
    foreign key(negozio) references Negozio(id_negozio)
);

insert into Prodotto(nome, categoria, prezzo) values
("maglione","abbigliamento",22.44),
("scarpe","abbigliamento",50.40),
("cinta","abbigliamento",10.44),
("decoder","elettronica",100.00),
("stampante","elettronica",80.55),
("monitor","elettronica",200.10);

insert into Negozio(nome) values
("Gigastore"), ("Fitness Boutique");

insert into Vendita values
(1,1,'2008-01-01',1),
(1,2,'2008-01-01',2),
(2,1,'2008-01-01',5),
(2,2,'2008-02-05',1),
(2,2,'2008-02-04',10),
(3,1,'2008-02-06',5),
(3,2,'2008-03-06',1),
(3,1,'2008-04-10',10),
(4,2,'2008-10-04',20),
(4,2,'2008-11-10',50),
(4,2,'2008-12-11',1);

# QUERY1
SELECT nome, prezzo
FROM Prodotto
WHERE(categoria = "abbigliamento");

#QUERY2
SELECT Prodotto.nome, Negozio.nome
FROM Prodotto INNER JOIN (Vendita INNER JOIN Negozio ON negozio = id_negozio) ON id_prodotto = prodotto
GROUP BY Prodotto.nome;

#QUERY3
SELECT Negozio.nome, ROUND(SUM(Vendita.quantita * prezzo),2) AS Guadagno
FROM Prodotto INNER JOIN (Vendita INNER JOIN Negozio ON negozio = id_negozio) ON id_prodotto = prodotto
GROUP BY Negozio.nome;

#QUERY4
SELECT DISTINCT nome
FROM Prodotto LEFT OUTER JOIN Vendita ON id_prodotto = prodotto
WHERE prodotto IS NULL;

# QUERY5
SELECT nome
FROM Prodotto INNER JOIN Vendita ON id_prodotto = prodotto
WHERE(MONTH(data) = 02 AND YEAR(data) = 2008)
HAVING MAX(quantita);
