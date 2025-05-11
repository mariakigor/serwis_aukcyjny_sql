--USE Serwis_Aukcyjny
--GO

-- Usuwanie tabel
DROP TABLE IF EXISTS Oferty;
DROP TABLE IF EXISTS Licytacje;
DROP TABLE IF EXISTS PrzedmiotyOpcjeDostawy;
DROP TABLE IF EXISTS OpcjeDostawy;
DROP TABLE IF EXISTS Przedmioty;
DROP TABLE IF EXISTS Uzytkownicy;


-- Tworzenie tabel
CREATE TABLE Uzytkownicy 
(
    u_login VARCHAR(40) CONSTRAINT pk_uzytk_login PRIMARY KEY,
    imie_i_nazwisko VARCHAR(50) NOT NULL,
    adres_zamieszkania VARCHAR(100) NOT NULL,
    adres_email VARCHAR(50) NOT NULL,
    numer_konta VARCHAR(50),
    adres_dostawy VARCHAR(100),
    telefon VARCHAR(20)
);

CREATE TABLE Przedmioty 
(
	numer INTEGER CONSTRAINT pk_przedmiot PRIMARY KEY,
	login_uzytkownika VARCHAR(40) NOT NULL,
	nazwa VARCHAR(40) NOT NULL,
	kategoria VARCHAR(20) NOT NULL,
	cena_wyjsciowa INTEGER NOT NULL,
	opis VARCHAR(100),
	cena_zakupu INTEGER

	CONSTRAINT fk_przedmiot_uzytk FOREIGN KEY (login_uzytkownika) REFERENCES Uzytkownicy(u_login)
);

CREATE TABLE OpcjeDostawy 
(
	id_dostawy INTEGER CONSTRAINT pk_dostawa PRIMARY KEY,
	nazwa VARCHAR(40) NOT NULL,
	firma VARCHAR(20) NOT NULL,
	cena DECIMAl(10,2) NOT NULL
);

CREATE TABLE PrzedmiotyOpcjeDostawy 
(
	numer_przedmiotu INTEGER NOT NULL,
	dostawa_id INTEGER NOT NULL,

	CONSTRAINT fk_przedmiot FOREIGN KEY (numer_przedmiotu) REFERENCES Przedmioty(numer),
	CONSTRAINT fk_opcje_dost FOREIGN KEY (dostawa_id) REFERENCES OpcjeDostawy(id_dostawy),
	CONSTRAINT pk_przedmiot_dostawa PRIMARY KEY (numer_przedmiotu, dostawa_id)
);

CREATE TABLE Licytacje 
(
	id_licytacji INTEGER CONSTRAINT pk_id_licytacji PRIMARY KEY,
	przedmiot_numer INTEGER NOT NULL,
	data_rozpoczecia DATE NOT NULL,
	data_zakonczenia DATE,
	status_licytacji VARCHAR(30) NOT NULL,
	login_zwyciezcy VARCHAR(40)

	CONSTRAINT fk_przedmiot_nr FOREIGN KEY (przedmiot_numer) REFERENCES Przedmioty(numer),
	CONSTRAINT fk_uzytk_login FOREIGN KEY (login_zwyciezcy) REFERENCES Uzytkownicy(u_login)
);

CREATE TABLE Oferty 
(
	licytacja_id INTEGER NOT NULL,
	login_skladajacego VARCHAR(40) NOT NULL,
	data_i_godz_rozp DATETIME NOT NULL,
	kwota INTEGER NOT NULL

	CONSTRAINT fk_licytacja_id FOREIGN KEY (licytacja_id) REFERENCES Licytacje(id_licytacji),
	CONSTRAINT fk_login_uzytk FOREIGN KEY (login_skladajacego) REFERENCES Uzytkownicy(u_login),
	CONSTRAINT pk_oferty PRIMARY KEY (licytacja_id, data_i_godz_rozp)
);


-- Wstawianie wartoœci
INSERT INTO Uzytkownicy(u_login, imie_i_nazwisko, adres_zamieszkania, adres_email, numer_konta, adres_dostawy, telefon) VALUES
('jan22', 'Jan Kowalski', '60-124 Poznañ, ul. Têczowa', 'jan.kowalski@gmail.com', 'PL49102028922276300500000000', '60-124 Poznañ, ul. Têczowa', '333543991'),
('anna88', 'Anna Nowak', '00-001 Warszawa, ul. Marsza³kowska 1', 'anna.nowak@wp.pl', NULL, NULL, NULL),
('maclog', 'Maciej Karkunski', '30-001 Kraków, ul. Kwiatowa 10', 'logicznie@o2.pl', 'PL66102028922276300800000000', '30-001 Kraków, ul. Kwiatowa 10', '666777888'),
('kwiatewka1', 'Ewa Kwiatkowska', '40-001 Katowice, ul. Leœna 5', 'ewa.kwiatkowska@gmail.com', 'PL12102025581111110500000000', '40-001 Katowice, ul. Leœna 5', '725667899'),
('katala123', 'Katarzyna Maczka', '62-173 Poznañ, ul. G³ówna 12', 'kasia123@gmail.com', 'PL14581025581111009200001133', '62-111 Poznañ, ul. Poboczna 19', NULL),
('marko12', 'Marek Lewandowski', '50-001 Wroc³aw, ul. Zielona 7', 'marek.lewandowski@interia.pl', NULL, NULL, '611234567');

INSERT INTO Przedmioty(numer, nazwa, kategoria, cena_wyjsciowa, opis, cena_zakupu, login_uzytkownika) VALUES
(1, 'Laptop', 'Elektronika', 2500, 'Nowy laptop Jasia  16GB RAM', NULL, 'maclog'),
(2, 'Rower', 'Sport', 1220, 'U¿ywany rower, jeŸdzi, skrêca', 2000, 'jan22'),
(3, 'Smartphone', 'Elektronika', 1500, 'Nowy smartphone Samsung', NULL, 'anna88'),
(4, 'Gitara', 'Muzyka', 800, 'Akustyczna gitara Yamaha', 1000, 'katala123'),
(5, 'Monitor', 'Elektronika', 700, 'Monitor Dell 24 cale', NULL, 'jan22'),
(6, 'Kosiarka', 'Ogród', 1250, 'Nowa kosiarka', 1300, 'marko12'),
(7, 'Podrêczniki klasa 1', 'Szko³a', 150, 'U¿ywane podrêczniki do klasy 1', NULL, 'kwiatewka1');


INSERT INTO OpcjeDostawy(id_dostawy, nazwa, firma, cena) VALUES
(1, 'Kurier', 'DHL', 22.99),
(2, 'Paczkomat', 'InPost', 12.99),
(3, 'Odbiór osobisty', 'Brak', 0.00),
(4, 'Poczta Polska', 'Poczta Polska', 15.50);


INSERT INTO PrzedmiotyOpcjeDostawy(numer_przedmiotu, dostawa_id) VALUES
(1, 2),
(2, 2),
(3, 1),
(3, 2),
(3, 4),
(4, 3),
(5, 1),
(5, 4),
(6, 3),
(6, 4),
(7, 1),
(7, 2);

INSERT INTO Licytacje(id_licytacji, data_rozpoczecia, data_zakonczenia, status_licytacji, przedmiot_numer, login_zwyciezcy) VALUES
(1, '2023-05-01', '2023-05-10', 'zakonczona kupnem', 1, 'marko12'),
(2, '2023-05-05', '2023-05-15', 'zakoñczona bez kupna', 2, NULL),
(3, '2023-06-01', '2023-06-10', 'zakonczona kupnem', 3, 'anna88'),
(4, '2023-06-05', '2023-06-15', 'zakonczona bez kupna', 4, NULL),
(41, '2023-06-20', '2023-07-20', 'zakonczona bez kupna', 4, NULL),
(5, '2023-07-01', NULL, 'w trakcie', 5, NULL),
(6, '2023-10-05', '2023-12-10', 'zakonczona kupnem', 6, 'kwiatewka1'),
(7, '2024-02-15', NULL, 'w trakcie', 7, NULL);


INSERT INTO Oferty(licytacja_id, data_i_godz_rozp, kwota, login_skladajacego) VALUES
(1, '2023-05-02 11:30:00', 2600, 'marko12'),
(1, '2023-05-06 13:00:00', 2570, 'kwiatewka1'),
(3, '2023-06-02 09:00:00', 1550, 'jan22'),
(3, '2023-06-07 12:00:00', 1600, 'marko12'),
(5, '2023-07-02 15:00:00', 750, 'anna88'),
(5, '2023-07-02 16:30:00', 780, 'maclog'),
(6, '2023-10-22 15:00:00', 1400, 'katala123'),
(6, '2023-12-05 19:00:00', 1600, 'kwiatewka1'),
(7, '2024-02-19 08:17:00', 170, 'anna88');

