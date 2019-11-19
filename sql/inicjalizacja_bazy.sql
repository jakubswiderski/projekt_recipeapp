create database if not exists `recipeapp`;
use recipeapp;

drop table if exists `typ_uzytkownika`;
create table `typ_uzytkownika` (
	nazwa varchar(15) primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `uzytkownicy`;
create table `uzytkownicy` (
	id int primary key auto_increment,
	nick varchar(30) not null,
	email varchar(35) not null,
	haslo varchar(20) not null,
	typ varchar(15) not null,
	klucz_dostepu varchar(32),
	kod_przywracania varchar(32)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `kategorie`;
create table `kategorie` (
	nazwa varchar(25) primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `poziom_trudnosci`;
create table poziom_trudnosci (
	poziom varchar(20) not null primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `opinie`;
create table if not exists `opinie` (
	id_opinii int primary key,
	id_przepisu int not null,
	id_autora int not null,
	id_oceny int not null,
	komentarz text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `oceny`;
create table if not exists `oceny` (
	ocena int primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `przepisy`;
create table `przepisy` (
	id int primary key auto_increment,
	nazwa varchar(50) not null,
	autor int,
	przepis text not null,
	skladniki text not null,
	czas_przygotowania int not null,
	poziom_trudnosci varchar(20) not null,
	ile_porcji int not null,
	ile_kalorii int not null,
	kategoria varchar(25) not null,
	czy_aktywne bit not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

alter table uzytkownicy add constraint typ_fkey foreign key (typ) references typ_uzytkownika (nazwa) on delete cascade on update cascade;
alter table przepisy add constraint kategoria_fkey foreign key (kategoria) references kategorie (nazwa) on delete cascade on update cascade;
alter table przepisy add constraint autor_fkey foreign key (autor) references uzytkownicy (id) on delete cascade on update cascade;
alter table przepisy add constraint poziom_fkey foreign key (poziom_trudnosci) references poziom_trudnosci (poziom) on delete cascade on update cascade;
alter table opinie add constraint id_przepis_fkey foreign key (id_przepisu) references przepisy (id) on delete cascade on update cascade;
alter table opinie add constraint id_autor_fkey foreign key (id_autora) references uzytkownicy (id) on delete cascade on update cascade;
alter table opinie add constraint id_ocena_fkey foreign key (id_oceny) references oceny (ocena) on delete cascade on update cascade;

insert into poziom_trudnosci values 
	("Banalny"),
	("Łatwy"),
	("Średni"),
	("Trudny"),
	("Bardzo trudny");

insert into oceny values 
	(1),
	(2),
	(3),
	(4),
	(5);

insert into kategorie values 
	("Ciasta"),
	("Ciastka"),
	("Dania główne"),
	("Desery"),
	("Grill"),
	("Kanapki"),
	("Kluski"),
	("Makarony"),
	("Naleśniki"),
	("Alkohole"),
	("Koktajle"),
	("Pieczywo"),
	("Pierogi"),
	("Pizza"),
	("Placki"),
	("Przekąski"),
	("Przetwory"),
	("Przystawki"),
	("Sałatki"),
	("Sosy"),
	("Śniadania"),
	("Wege"),
	("Zapiekanki"),
	("Zupy");

insert into typ_uzytkownika values 
	("Standardowy"),
	("Moderator"),
	("Administrator");
	
insert into uzytkownicy (nick, email, haslo, typ, klucz_dostepu, kod_przywracania) values 
	("admin", "admin@admin.pl", "admin1@", "Administrator", "Aktywny", "67df854fsa54f54asf40e70xsad4ds05"),
	("piotrek23", "piotreek88@wp.pl", "piotr123", "Standardowy", "Aktywny", "67df854fsa58f54asf40d70xsax4ds05"),
	("aniax", "kolorowa13@o2.pl", "robak@!123", "Standardowy", "Aktywny", "97df854fsa54f54asf40d79x2ax4ds68"),
	("jerry", "jerydery@gmail.com", "ciastko2", "Standardowy", "Aktywny", "o26d51c540xas5d8a4f412zx48432gd6"),
	("witek17", "witoldnowak@o2.pl", "witek123", "Standardowy", "Aktywny", "8o87sfa56fg54a6fas6ci541asf135a6"),
	("matrix", "matrix2@gmail.com", "qwerty1", "Standardowy", "Aktywny", "54g51sdga8sf984asf732ff98749ft541"),
	("monika", "monika1997@gmail.com", "tomaszek", "Standardowy", "Aktywny", "g6804egsdf321as86f654a984f165ae5"),
	("jakubS", "jcobswiderski@wp.pl", "q1", "Moderator", "Aktywny", "m32fa2s541121f5q3fs1351fawf8q41g");
	
insert into przepisy (nazwa, autor, przepis, skladniki, czas_przygotowania, poziom_trudnosci, ile_porcji, ile_kalorii, kategoria, czy_aktywne) values
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 490, "Dania główne", 1), 
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 70, "Łatwy", 4, 490, "Zupy", 1),
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 490, "Dania główne", 1), 
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 70, "Łatwy", 4, 490, "Zupy", 1),
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 490, "Dania główne", 1), 
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 70, "Łatwy", 4, 490, "Zupy", 1),
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 490, "Dania główne", 1), 
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 70, "Łatwy", 4, 490, "Zupy", 1),
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 490, "Dania główne", 1), 
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 70, "Łatwy", 4, 490, "Zupy", 1),
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 490, "Dania główne", 1), 
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 70, "Łatwy", 4, 490, "Zupy", 1),
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 490, "Dania główne", 1), 
	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką.\nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 70, "Łatwy", 4, 490, "Zupy", 1);


	