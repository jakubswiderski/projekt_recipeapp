# noinspection SqlInsertValuesForFile

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
	kod_przywracania varchar(32),
	data_dodania datetime,
	data_modyfikacji datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `kategoria`;
create table `kategoria` (
	nazwa varchar(25) primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `poziom_trudnosci`;
create table poziom_trudnosci (
poziom varchar(20) not null primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `opinie`;
create table if not exists `opinie` (
	id_opinii int primary key auto_increment,
	id_przepisu int not null,
	id_autora int not null,
	id_oceny int not null,
	komentarz text,
	data_opinii datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `oceny`;
create table if not exists `oceny` (
	ocena int primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

drop table if exists `przepisy`;
create table `przepisy` (
	id int primary key auto_increment,
	nazwa varchar(40) not null,
	autor int,
	przepis text not null,
	skladniki text not null,
	czas_przygotowania int not null,
	poziom_trudnosci varchar(20) not null,
	ile_porcji int not null,
	ile_kalorii int not null,
	kategoria varchar(25) not null,
	czy_aktywne bit not null DEFAULT 0,
	data_dodania datetime,
	data_modyfikacji datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

CREATE INDEX i_naz_prze ON przepisy (nazwa);
CREATE INDEX i_kat_prze ON przepisy (kategoria); 
	
alter table uzytkownicy add constraint typ_fkey foreign key (typ) references typ_uzytkownika (nazwa) on delete cascade on update cascade;
alter table przepisy add constraint kategoria_fkey foreign key (kategoria) references kategoria (nazwa) on delete cascade on update cascade;
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

insert into kategoria values 
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
	
insert into uzytkownicy (nick, email, haslo, typ, klucz_dostepu, kod_przywracania, data_dodania, data_modyfikacji) values 
		("admin", "admin@admin.pl", "admin1@", "Administrator", "Aktywny", "67df854fsa54f54asf40e70xsad4ds05", now(), now()),
	("piotrek23", "piotreek88@wp.pl", "piotr123", "Standardowy", "Aktywny", "67df854fsa58f54asf40d70xsax4ds05", now(), now()),
	("aniax", "kolorowa13@o2.pl", "robak@!123", "Standardowy", "Aktywny", "97df854fsa54f54asf40d79x2ax4ds68", now(), now()),
	("jerry", "jerydery@gmail.com", "ciastko2", "Standardowy", "Aktywny", "o26d51c540xas5d8a4f412zx48432gd6", now(), now()),
	("witek17", "witoldnowak@o2.pl", "witek123", "Standardowy", "Aktywny", "8o87sfa56fg54a6fas6ci541asf135a6", now(), now()),
	("matrix", "matrix2@gmail.com", "qwerty1", "Standardowy", "Aktywny", "54g51sdga8sf984asf732ff98749ft541", now(), now()),
	("monika", "monika1997@gmail.com", "tomaszek", "Standardowy", "Aktywny", "g6804egsdf321as86f654a984f165ae5", now(), now()),
	("jakubS", "jcobswiderski@wp.pl", "q1", "Moderator", "Aktywny", "m32fa2s541121f5q3fs1351fawf8q41g", now(), now());
	
insert into przepisy (nazwa, autor, przepis, skladniki, czas_przygotowania, poziom_trudnosci, ile_porcji, ile_kalorii, kategoria, czy_aktywne, data_dodania, data_modyfikacji) values
	("Pizza Capricciosa", 2, "Przygotować ciasto wg ulubionej receptury\nWyrośnięte ciasto wyłożyć w blaszce, uformować brzegi. Posmarować sosem pomidorowym. \nNagrzać piekarnik do  250C.\nPieczarki pokroić w plasterki, szynkę w paseczki.\nMozzarellę potrzeć na tarce lub pokroić w plasterki. Ewentualnie można mozzarellę zastąpić żółtym serem.\nNa pizzy ułożyć kolejno: szynkę, ser i pieczarki.\nWstawić pizzę do piekarnika i piec ok. 7-10 minut.\nPizzę lekko ostudzić, najlepiej na kratce. Podawać z ulubionymi sosami.", "Mąka pszenna tortowa 3 szklanki (po 250ml)\nDrożdże 40g\nSól 1 łyżeczka\nBazylia 1-2 łyżeczki\nOregano 1-2 łyżeczki\nWoda 1 szklanka (250 ml ; temp 40-50C)\nOliwa z oliwek 3 łyżeczki\nPomidory w puszce 1 puszka\nPieczarki kilka sztuk\nSzynka kilka plasterków \nMozzarella 300g", 60, "Średni", 4, 450, "Pizza", 1, now(), now()),
	
	("Szarlotka", 5, "Przygotować ciasto kruche: Z mąki, cukru, cukru waniliowego, masła (pokrojonego na małe kawałki), jajka i proszku do pieczenia zagnieść jednolite ciasto ręką lub robotem kuchennym.\n\nZ ciasta uformować kulę, lekko ją spłaszczyć i owinąć w folię spożywczą. Wstawić do lodówki na czas przygotowania musu jabłkowego.\n\nPrzygotować mus jabłkowy: Jabłka umyć, obrać, usunąć gniazda nasienne i pokroić w niedużą kostkę lub zetrzeć na tarte. Wymieszać z 2 łyżkami cukru i przesmażyć, aż powstanie mus. (Gdyby mus był mocno wodnisty smażyć, aż nadmiar soku wyparuje). Wmieszać cynamon i pozostawić do ostygnięcia.\n\nFormę kwadratową o wymiarach ok. 24x 24 cm wyłożyć papierem do pieczenia. (Można najpierw delikatnie posmarować w kilku miejscach formę masłem lub margaryną. Wtedy wyłożenie formy papierem pójdzie sprawniej, bo przyklei się on do tłuszczu).\n\nPołowę ciasta wykleić na dnie formy. Wyłożyć mus jabłkowy. Z pozostałego ciasta odrywać kawałki i układać je na musie jabłkowym. (Można również ciasto rozwałkować).\n\n", "Ciasto kruche:\n2 szklanki mąki pszennej (300 g)\n3 łyżki cukru\n2 łyżeczki cukru waniliowego\n250 g masła, zimnego\n2 płaskie łyżeczki proszku do pieczenia\n1 jajko (rozmiar M)\n\nMus jabłkowy:\nok. 1,5 kg jabłek (polecam Szarą Renetę)\n1 łyżeczka cynamonu\n2 łyżki cukru", 240, "Średni", 12, 1200, "Ciasta", 1, now(), now()),

	("Duszona karkówka w sosie własnym z cebulą", 2, "Mięso opłucz i pokrój na kotlety grubości 2 cm.\nKażdy rozbij lekko tłuczkiem, posyp pieprzem i oprósz mąką. \nW następnej kolejności obsmaż je z obu stron na złoty kolor na rozgrzanym oleju.\nCebule pokrój w piórka i przesmaż w garnku na rozgrzanym oleju, dodaj majeranek, liść laurowy oraz ziele.\nGdy cebula nabierze złotego koloru, wsyp pozostałą mąkę i przesmaż razem. Następnie dodaj 1 l wrzącej wody.\nWłóż mięso, Esencję do duszonych mięs Knorr i duś na małym ogniu do momentu, gdy karkówka będzie miękka. Podawaj z ziemniakami lub kaszą.", "600g karkówki wieprzowej\nEsencja do duszonych mięs Knorr\nwoda\nmajeranek\ncebula\nmąka\nziele angielskie\nolej do smażenia", 60, "Łatwy", 4, 1400, "Dania główne", 1, now(), now()),

	("Pieczony kurczak z ziemniakami", 3, "Stwórz błyskawiczną marynatę, mieszając przyprawę Knorr z olejem, papryką i oregano. Natrzyj nią kurczaka z zewnątrz i od środka. Jeśli lubisz potrawy pikantne do marynaty dodaj również trochę ostrej papryki. \nZiemniaki obierz i przekrój na cztery części. \nKurczaka i ziemniaki umieść w brytfance, piecz 60 minut w 190 °C.", "kurczak (ok. 1,5 kg)1 szt \nPrzyprawa do złotego kurczaka Knorr (4 łyżki) \nziemniaki 800g \nPapryka słodka z Hiszpanii Knorr 1 łyżeczka \nOregano z Turcji Knorr 1 łyżeczka \nolej2 łyżki", 60, "Łatwy", 4, 1100, "Dania główne", 1, now(), now()),

    ("Kremowa zupa z kurek", 1, "Ugotuj bulion z porcji rosołowej, przypraw oraz warzyw. Następnie odcedź go. \nObierz ziemniaki, pokrój je w kostkę i dodaj do odcedzonego bulionu. \nUmyj kurki, po czym dodaj je do wywaru wraz z kostkami rosołowymi Knorr oraz majerankiem. Gotuj całość do momentu, gdy ziemniaki będą miękkie. \nDolej do zupy piwo oraz śmietanę i mocno ją podgrzej. Podawaj porcje zupy, na talerzach, udekorowaną siekanym szczypiorkiem.", "porcja rosołowa 500 g \nRosół z kury Knorr 2 szt. \nświeże kurki 200 g \nśredniej wielkości ziemniaki 4 szt. \npietruszka 1 szt. \ncebula 1 szt. \nciemne piwo 100 ml \nMajeranek z krajów śródziemnomorskich Knorr 1 łyżka \nZiele angielskie z Meksyku Knorr 4 ziarna \nPieprz czarny z Wietnamu ziarnisty Knorr 5 ziaren \nśmietana 22% pół szklanki \npęczek szczypioru 1 szt. \nseler 05 szt.", 60, "Łatwy", 4, 600, "Zupy", 1, now(), now()),

    ("Placki ziemniaczane", 3, "Obierz ziemniaki, zetrzyj na tarce. Odsącz masę przez sito. Zetrzyj cebulę na tarce.  \nDodaj do ziemniaków cebulę, jajka, gałkę muszkatołową oraz mini kostkę Knorr. \nWymieszaj wszystko dobrze, dodaj mąkę, aby nadać masie odpowiednią konsystencję. \nRozgrzej na patelni olej, nakładaj masę łyżką. Smaż placki z obu stron na złoty brąz i od razu podawaj.", "ziemniaki 1 kg \ncebula 1 szt. \njajka 2 szt. \nPrzyprawa w Mini kostkach Czosnek Knorr \nGałka muszkatołowa z Indonezji Knorr 1 szczypta \nsól 1 szczypta \nmąka", 30, "Średni", 8, 1000, "Placki", 1, now(), now()),
	 
	 ("Pierogi z jabłkami i cynamonem", 2, "Mąkę wymieszaj z jajkiem, solą oraz oliwę. \nNastępnie dodaj szklankę wody i wyrób aż ciasto będzie gładkie. \nJabłka wyczyść, obierz i pokrój w kostkę, a następnie przełóż do garnka i posyp cynamonem, cukrem waniliowym i cukrem oraz dolej odrobinę wody. Gotuj na wolnym ogniu często mieszając przez około 10-15 minut aż jabłka będą miękkie a sok wyparuje. \nCiasto wałkuj i wytnij kółka. Nakładaj farsz na każdego pieroga i dobrze sklej.\nWrzucaj do wrzącej, lekko osolonej wody i czekaj aż pierogi wypłyną. Pierogi można podać polane roztopionym masłem i posypane cukrem.", "jabłka 1 kg \nmąka 500 g \nciepła woda 1 szkalnka \njajko 1 sztk. \ncynamon 2 łyżeczki \ncukier waniliowy 1 opak. \ncukier 0,5 szkalnaki \nsól \noliwa 3 łyżki", 45, "Łatwy", 6, 600, "Pierogi", 1, now(), now()),
	 
	 ("Grzybowa po męsku", 1,  "Umyj i namocz grzyby, następnie gotuj je przez 40 minut. \nDrobno pokrój warzywa i podsmaż je na oleju. Zalej 2 szklankami wody i gotuj przez 25 minut. \nPołącz ze sobą oba wywary, następnie przecedź. \nPokrój grzyby i dodaj do wywaru wraz z kostkami Rosołu wołowego Knorr. \nDodaj szklankę mleka i dopraw pieprzem. Zupę podawaj z makaronem.", "suszone grzyby 30 gramów \nrosół wołowy Knorr 2 szt. \ncebule 2 szt. \nmarchewki 2 szt. \nmały seler 1 szt. \nwoda 2 szk. \nmleko 1 szklanka \npieprz do smaku 1 szczypta \nolej 2 łyżki \nmakaron wstążki 1 opakowanie", 60, "Łatwy", 4, 700, "Zupy", 1, now(), now()),
	 
	 ("Oponki z cukrem", 2, "Drożdże rozpuść w letnim mleku. W misce wymieszaj mąkę, sól, cukier. Dodaj żółtko, wodę i rozpuszczone w mleku drożdże. Wymieszaj. Kasię schłodź w zamrażarce. \nCiasto przełóż na podsypany mąką stół i dobrze zagnieć. Powinno być zwarte i odchodzić od stołu i rąk. Ciasto odstaw w ciepłe miejsce do wyrośnięcia na około 60 minut. Powinno podwoić objętość. \nWyrośnięte ciasto jeszcze raz zagnieć i rozwałkuj na placek grubości 1 cm. Na połowie ciasta ułóż cienkie plastry schłodzonej Kasi i przykryj drugą połową ciasta. Brzegi sklej dociskając ciasto palcami. \nCiasto rozwałkuj na duży prostokąt, a następnie złóż w kopertę. Czynność składania i rozwałkowywania powtórz kilka razy. Ostatecznie ciasto powinno mieć grubość ok. 1 cm. \nZ ciasta wytnij metalową obręczą kółka o średnicy około 6 cm, a następnie wytnij w nich mniejszą obręczą dziurki. Odstaw, aby podwoiły objętość. \nW garnku rozgrzej olej. Wrzucaj pączki i smaż na małym ogniu obracając w czasie pieczenia. Osącz na papierowym ręczniku. \nCukier puder utrzyj z sokiem z cytryny na gładki lukier i posmaruj nim wierzch pączków.", "ciasto \nmąka pszenna 500 gramów \nKostka do pieczenia Kasia 150 gramów \nwoda 0.5 szklanek \nmleko 0.5 szklanek \nżółtko 1 sztuka \ndrożdże 20 gramów \nsól 1 szczypta \ncukier 50 gramów \nolej do smażenia 1 litr  \nlukier \ncukier puder 250 gramów \nsok z cytryny 5 łyżek", 40, "Trudny", 2, 1200, "Ciastka", 1, now(), now()),
	 
	 ("Leczo", 1, "Wszystkie warzywa pokrój w grubą kostkę. Przesmaż je na 4 łyżkach oleju. \nNa oddzielnej patelni przesmaż pokrojoną w kostkę kiełbasę i boczek. Po zarumienieniu się mięs dodaj warzywa i zalej je niewielką ilością wody. \nDopraw do smaku papryką ostrą. \nDodaj pokrojone pomidory i Knorr Chłopski garnek, kiedy warzywa zmiękną. \nGotuj przez 15 minut do zredukowania pomidorów.", "boczek 400 gramów \nkiełbasa 400 gramów \npapryka czerwona 2 sztuki \nseler naciowy 1 pęczek \nNaturalnie smaczne Chłopski Garnek Knorr 1 opakowanie \nPapryka ostra z Hiszpanii Knorr 1 szczypta \nkrojone pomidory w puszce 800 gramów \nbakłażan 1 sztuka \ncebula 1 sztuka \nwoda 200 mililitrów \nolej 4 łyżki", 30, "Łatwy", 6, 800, "Dania główne", 1, now(), now()),
	 
	  
	 
	 ("Placki z ziemników", 3, "Rozgrzej piekarnik do 180°C. Ugotuj ziemniaki (około 20 minut). Odcedź starannie i utłucz. Odstaw do ostygnięcia. \nPosiekaj drobno cebulę. Roztop masło na niewielkiej patelni i smaż cebulę 10 minut, aż będzie miękka. \nDodaj do ziemniaków: cebulę, śmietanę, żółtka, przyprawy w mini kostkach Knorr. Wymieszaj dokładnie. \nPrzesiej mąkę do garnka z ziemniakami i wymieszaj. Przypraw sporą ilością pieprzu i solą, jeśli uznasz, że jest to konieczne. \nUformuj z masy ziemniaczanej kulki (około 16). Spłaszcz by powstały niewielkie placuszki o średnicy około 6 centymetrów. \nUłóż na lekko natłuszczonej blasze do pieczenia i posmaruj roztrzepanym jajkiem. Posyp bułką tartą. Piecz 30 minut, aż się przyrumienią.", "ziemniaki 450 gramów \nżółtka 3 sztuki \ncebula 1 sztuka \njajko 1 sztuka \nPrzyprawa w Mini kostkach Pietruszka Knorr \nmąka 25 gramów \nbułka tarta 25 gramów \nPrzyprawa w Mini kostkach Czosnek Knorr \nkwaśna śmietana 3 łyżki \nświeżo mielony czarny pieprz 1 szczypta \nmasło 2 łyżki", 60, "Średni", 4, 900, "Placki", 1, now(), now()),
	 
	 ("Zapiekanka ziemniaczana z kiełbasą", 2, "Fix Knorr wymieszaj z bulionem i zagotuj. Następnie odstaw do ostygnięcia. \nKiełbasę pokrój w kostę i usmaż, aż będzie rumiana. \nZiemniaki pokrój w cienkie plastry i wymieszaj z sosem oraz roztrzepanym jajkiem. \nDo masy ziemniaczanej dodaj kiełbasę i wymieszaj. \nForemkę do pieczenia wysmaruj margaryną. Wylej do niej przygotowaną masę. Wyrównaj wierzch. \nPosyp całość startym serem i zapiekaj w piekarniku rozgrzanym do 160 °C przez 40 minut. Pod koniec pieczenia możesz zwiększyć temperaturę do 180 °C, by zapiekanka się przypiekła.", "ziemniaki 5 sztuk \nFix Spaghetti Carbonara Knorr 1 opakowanie \nbulion 300 mililitrów \nkiełbasa zwyczajna 1 sztuka \njajko 1 sztuka \nser żółty 80 gramów \ntłuszcz do wysmarowania formy", 60, "Łatwy", 6, 1400, "Zapiekanki", 1, now(), now()),
	 
	 ("Tort makowy z budyniem", 2, "Kasię rozpuść w rondelku. Żółtka oddziel od białek. Białka ubij na sztywną pianę z cukrem. Mąkę wymieszaj z proszkiem do pieczenia i makiem. Do ubitych białek dodaj, mieszając mikserem na wolnych obrotach, po jednym żółtku, a następnie po łyżce mąki wymieszanej z proszkiem do pieczenia i makiem. Na koniec wlej rozpuszczoną Kasię i delikatnie wymieszaj łyżką. \nDno tortownicy o średnicy 26 cm. wyłóż papierem do pieczenia. Boków nie smaruj. Do formy włóżciasto i piecz w 170 st.C około 30 minut. Upieczone i wystudzone ciasto przekrój na 3 krążki. \nZ jednej pomarańczy zetrzyj skórkę. Połowę mleka zagotuj razem ze skórką pomarańczową, w reszcie mleka rozprowadź proszek budyniowy. Rozprowadzony proszek wlej do gotującego mleka i gotuj ciągle mieszając, aż powstanie gęsty budyń. Wystudź. \nMiękką Kasię ubij mikserem. Ciągle ubijając dodawaj po łyżce wystudzony budyń. \nJeden krążek ciasta ułóż w tortownicy i posmaruj 1/3 przygotowanego kremu. Przykryj drugim krążkiem ciasta i znów posmaruj częścią kremu. Tak samo postąp z trzecim krążkiem i resztą kremu. Tort odstaw do lodówki. \nPłatki migdałowe upraż na suchej patelni. Pomarańcze i grejpfruty wyfiletuj. Schłodzony tort posyp płatkami migdałowymi i udekoruj cząstkami cytrusów.", "ciasto: \nKostka do pieczenia Kasia 50 gramów \ncukier 160 gramów \njajko 5 sztuk \nmąka 110 gramów \nsuchy mak. 150 gramów \nproszek do pieczenia 1 łyżeczka \nkrem:\nKostka do pieczenia Kasia 1 opakowanie \nbudyń śmietankowy z cukrem 3 opakowania \nmleko 1 litr \nwierzch: \npłatki migdałowe - 75 gramów \npomarańcza 2 sztuki \nczerwony grejpfrut 2 sztuki", 45, "Łatwy", 4, 900, "Ciasta", 1, now(), now()),
	
	("Jogurt naturalny z musem z owoców", 2, "Owoce umyć. Truskawki i borówki zmiksować na gładką masę. \nDo przeźroczystej szklanki wkroić banana, a następnie wlać połowę opakowania jogurtu. Posypać jogurt płatkami owsianymi. Potem wlać masę owocową. Na wierzch dodać resztę jogurtu. Całość posypać nasionami chia. W ramach dekoracji można ułożyć świeże listki mięty.", "jogurt naturalny 0% 600 g \ntruskawki 400 g \nborówki 300 g \nbanan 280 g \nnasiona chia 4 łyżeczki \npłatki owsiane 4 łyżki", 15, "Łatwy", 1, 150, "Desery", 1, now(), now()),
	
	("Placki dyniowe", 1, "Wszystkie składniki wymieszaj ze sobą w misce. Dopraw Delikatem i wyrób na gładką masę. \nNa patelni rozgrzej Ramę, nakładaj masę łyżką i smaż powstałe placki na złoty kolor. Smażąc na ramie nadasz specyficznego maślanego aromatu i jednocześnie zachowasz czystość, bo Rama nie pryska podczas smażenia. \nUsmażone placki odsącz z nadmiaru tłuszczu na papierowym ręczniku. Podawaj z łyżką kwaśnej śmietany lub gęstego jogurtu. Możesz udekorować ulubionymi ziołami.", "upieczona dynia 400 g \nRama Smaż jak szef kuchni, wariant maślany smak 100 ml \nDelikat przyprawa uniwersalna Knorr 0,5 łyżeczek \nmąka pszenna 100 g \ncebula 1 szt\nstarty imbir 10 g \nząbek czosnku 1 szt. \njajko 1 szt. \ncurry madras 1 łyżka", 15, "Łatwy", 4, 500, "Placki", 1, now(), now()),

	("Krupnik domowy", 2, "Kaszę dokładnie wypłucz, następnie zalej wodą, dodaj kostkę Knorr i gotuj powoli, aż lekko zmięknie. \nZiemniaki i marchew pokrój w kostkę, a pora w plastry. \nW drugim garnku gotuj warzywa wraz z liściem laurowym i zielem angielskim. \nGdy ziemniaki będą półmiękkie, dodaj do zupy kaszę wraz z płynem, w którym się gotowała. \nDo całości dodaj drugą kostkę oraz wodę, jeśli uznasz to za konieczne. Gotuj zupę jeszcze około 20 minut. Ziemniaki i kasza powinny być zupełniemiękkie. Gotową zupę podawaj posypaną posiekaną natką pietruszki.", "kasza jęczmienna 0.6 szklanek \nRosół z kury Knorr 2 sztuki \nmarchewka 1 sztuka \npor mały 1 sztuka \nziemniaki 200 gramów \nnatka pietruszki 0.5 pęczków \nLiść laurowy z Turcji Knorr 2 sztuki \nZiele angielskie z Meksyku Knorr 3 sztuki", 60, "Łatwy", 4, 400, "Zupy", 1, now(), now()),
	
	("Klasyczna zapiekanka ziemniaczana", 1, "Rozgrzej piekarnik do 200 ° C. Zetrzyj ser na tarce. \nZiemniaki obierz i pokrój w cienkie plastry, czosnek zetrzyj na tarc. Foremkę wyłóż pergaminem lub natłuść. \nKnorr Naturalnie smaczne wymieszaj z mlekiem, czosnkiem i ziemniakami. Ziemniaki przełóż do foremki, posyp z wierzchu serem. Całość przykryj folią aluminiową, wstaw n 30 minut do piekarnika , po tym czasie usuń folię. Zapiekankę piecz jeszcze 10-15 minut, aż ziemniaki będą zupełnie miękkie, a wierzchnia warstwa zrobi się rumiana.", "ziemniaki 600 g \nNaturalnie smaczne Zapiekanka makaronowa z szynką Knorr 1 opak. \nmleko 300 ml \ntwardy ser np. Ementaler 50 g \nząbek czosnku 1 szt.", 15, "Łatwy", 5, 600, "Zapiekanki", 1, now(), now()),
	
	("Ciasto King Kong", 3, "Foremkę o wymiarach 20x20 cm wyłóż papierem do pieczenia, a następnie warstwą herbatników. \nMleko podgrzej i rozpuść w nim cukier i cukier wanilinowy. Wystudź. Orzeszki posiekaj i upraż na suchej patelni. \nMiękką Kasię utrzyj na puszystą masę. Ciągle ucierając wlewaj cienkim strumieniem mleko z cukrem i wsyp partiami mleko w proszku. \nNa herbatniki w formie wyłóż krem i przykryj kolejną warstwą herbatników. \nNa herbatnikach rozsmaruj masę kajmakową i ponownie przykryj herbatnikami. \nŚmietankę podgrzej w rondelku, dodaj połamaną czekoladę i mieszaj, aż masa będzie gładka. Dodaj orzeszki. Gotową masę rozprowadź na herbatnikach. Całość odstaw na godzinę do lodówki.", "herbatniki typu Petit Beurre 42 szt. \ngotowa masa krówkowa 1 słoik \nkrem: \nKostka do pieczenia Kasia 1 opak. \nmleko 150 ml \ncukier 150 g \ncukier wanilinowy 1 łyżeczka\nmleko w proszku 300 g \nwierzch: \nmleczna czekolada 100 g \nśmietanka 30% 50 ml \norzeszki ziemne niesolone 100 g \ndraże orzechowe do dekoracji", 40, "Łatwy", 5, 1200, "Ciasta", 1, now(), now()),

	("Ciasto mleczna kanapka", 3, "Białka oddzielić od żółtek i ubić z cukrem na sztywną pianę. Ciągle ubijając, dodać do piany żółtka. \nNastępnie dodać sok z cytryny, olej i dalej ubijać. Mąkę wymieszać z kakao, proszkiem do pieczenia, przesiać i delikatnie połączyć z masą jajeczną. \nCiasto wylać na dno wyłożonej papierem do pieczenia formy o wymiarach 20 x 20 cm. Piec w temp. 180 stopni przez około 30 minut. Wyjąć z formy i odwrócić do góry dnem. \nMleko zagotować z cukrem i wystudzić. Miękką Kasię utrzeć na krem. Ciągle ucierając, wlewać cienkim strumieniem mleko z cukrem. Następnie dodawać małymi porcjami mleko w proszku i serek. Cały czas ucierać. \nUpieczone i wystudzone ciasto przeciąć na dwa placki i przełożyć kremem. Lekko docisnąć. \nCzekoladę, mleko i Kasię roztopić w kąpieli wodnej. Otrzymaną masą polać wierzch ciasta i odstawić do zastygnięcia.", "ciasto: \njajka 3 szt. \ncukier 100 g \nsok z cytryny 1 łyżeczka \nolej 2 łyżki \nmąka pszenna 50 g \nkakao 15 g \nproszek do pieczenia 0,5 łyżeczek \nkrem: \nKostka do pieczenia Kasia 125 g \nmleko 0,25 szklanek \ncukier 0,25 szklanek\nmleko w proszku 120 g \nserek śmietankowy (np. Bieluch) 100 g \ndodatkowo: \nczekolada mleczna 100 g \nmleko 2 łyżki \nKostka do pieczenia Kasia 0,1 opak.", 30, "Łatwy", 5, 1200, "Ciasta", 1, now(), now()),

	("Gulasz z kiełbasek", 2, "Kiełbasę pokrój w plasterki, a boczek w kostkę. Całość usmaż na dużej patelni bez dodatku tłuszczu. \nCałą włoszczyznę dokładnie umyj, obierz i pokrój w kostkę. Cebulę i czosnek posiekaj. \nDodaj wszystkie warzywa do kiełbasy i boczku. Całość smaż około 10 minut, mieszając od czasu do czasu. \nZalej gulasz 500 ml wody i dodaj Knorr Naturalnie Smaczne - Gulasz. Dokładnie wymieszaj. \nNa koniec dodaj koncentrat pomidorowy oraz odcedzoną fasolkę. Duś jeszcze około 15 minut. Udekoruj natką pietruszki. Taki gulasz podawaj z kromką chleba lub bułką.", "cienkie kiełbask i8 szt. \nnaturalnie smaczne Gulasz Knorr 1 opak. \nwoda 500 ml \nboczek wędzony 8 plastrów \nwłoszczyzna 1 pęczek \ncebula 1 szt. \nząbki czosnku 2 szt. \nkoncentrat pomidorowy 1 opak. \nfasola biała konserwowa 1 opak. \nnatka pietruszki do dekoracji", 60, "Banalny", 4, 800, "Dania główne", 1, now(), now()),



	("Holiszki", 1, "Zagotuj wodę w dużym garnku, włóż kapustę. Gotuj na małym ogniu 5 minut. Zostaw do ostygnięcia w wodzie. Oddziel liście, skrój twarde włókna. Zamiast blanszować, możesz główkę kapusty włożyć do zamrażarki na 2-3 dni. Po odmrożeniu liście łatwo się rozdzielą i będą miękkie. \nWszystkie składniki farszu starannie wymieszaj. Dodaj Esencję do duszonych mięs Knorr. Na każdy liść nałóż łyżkę farszu, następnie go zwiń. \nSos pomidorowy Knorr przygotuj według przepisu na opakowaniu, zagotuj i zalej gołąbki. \nGołąbki ułóż w żaroodpornym naczyniu. Piecz pod przykryciem w nagrzanym do 150°C piekarniku. Następnie zdejmij pokrywkę i zapiekaj potrawę jeszcze przez pół godziny. \nPo zapieczeniu potrawy i zdjęciu pokrywki, dodaj do sosu 2 - 3 łyżki miodu i sok z 1 cytryny. Zapiekaj jeszcze przez pół godziny. Gołąbki maja wówczas odmienny, słodko-kwaśny smak.", "duża główka kapusty 1 szt. \nEsencja do duszonych mięs Knorr 1 szt. \nSos pomidorowy Knorr \nsok z 1 cytryny \nmiód 3 łyżki \nfarsz: \nmielona wołowina 750 g \nryż 4 łyżki \nśrednia cebula 1 szt. \nrozgniecione ząbki czosnku 2 szt. \nPieprz czarny z Wietnamu mielony Knorr 1 szczypta \nsól 1 szczypta \njajka 2 szt. \nzimna woda 3 łyżki", 90, "Średni", 6, 1100, "Dania główne", 1, now(), now()),

	("Bigos domowy", 3, "Kapustę białą poszatkuj, a kiszoną przetnij 2 razy, żeby ją rozdrobnić. \nCebulę obierz i pokrój w kostkę, podsmaż w garnku i dodaj kapusty. Podlej winem, dodaj liść laurowy i ziele angielskie. \nBoczek, szynkę i kiełbasę pokrój w kostkę. Podsmaż na patelni, lekko posypując przyprawą Delikat Knorr. \nMięso dodaj do kapusty. Duś 60 min. Dopraw do smaku przyprawą Delikat Knorr. Czynność z duszeniem można powtarzać przez 3 dni dla lepszego smaku. Podawaj w misce odgrzane porcje.", "kapusta kiszona 300 g \nkapusta biała 300 g \nDelikat przyprawa uniwersalna Knorr \nkiełbasa zwyczajna 150 g \nszynka wieprzowa 200 g \nboczek wędzony 200 g \ncebula biała 1 szt. \nZiele angielskie z Meksyku Knorr 2 szt. \nLiść laurowy z Turcji Knorr 3 szt. \nPieprz czarny z Wietnamu ziarnisty Knorr 3 szt. \nmargaryna do smażenia \nwoda 100 ml", 90, "Łatwy", 4, 1200, "Dania główne", 1, now(), now()),

	("Krokiety z szynki", 1, "Na głębokiej patelni stop masło, oprósz mąką i zasmaż na złoty kolor. \nWlej mleko, wymieszaj, ciągle gotując, aż sos zgęstnieje. \nWsyp parmezan i dokładnie wymieszaj, aż sos zgęstnieje i zrobi się gładki. \nWstaw na 4 godziny do lodówki. Następnie dodaj pokrojoną w niedużą kostkę szynkę. \nZ przygotowanej masy formuj 12 krokiecików. Panieruj najpierw w 1 rozmąconym jajku, następnie w Fixie Knorr. \nW garnku rozgrzej olej, smaż krokieciki na złoty kolor i odsącz z tłuszczu na ręczniku papierowym. Podawaj gorące z sosem meksykańskim Knorr wymieszanym z majonezem i ketchupem.", "suszona szynka serrano5 dag \nFix Nuggetsy z sosem meksykańskim Knorr 1 opak. \nparmezan tarty 60 g \njajko 1 szt. \nmasło 6 łyżek \nmąka 8 łyżek \nmleko 1 szklanka \nolej do smażeni a0,5 l \nMajonez Hellmanns Babuni 2 łyżki \nKetchup Hellmanns Łagodny 2 łyżki", 30, "Łatwy", 8, 700, "Dania główne", 1, now(), now()),

	("Murzynek", 3, "Kasię, mleko, kakao i cukier włóż do rondelka, gotuj aż cukier się rozpuści i masa stanie się gładka i lśniąca. Z powstałej masy odlej 2/3 szklanki, a resztę wlej do miski. \nMąkę wymieszaj z proszkiem do pieczenia i wsyp do masy kakaowej. Wymieszaj mieszadłami miksera. \nŻółtka oddziel od białek. Dodawaj do ciasta po jednym żółtku ciągle mieszając. \nBiałka ubij mikserem na sztywną pianę. Przełóż do ciasta i wymieszaj delikatnie łyżką. \nCiasto przełóż do podłużnej formy, wyłożonej papierem do pieczenia o wymiarach ok.10 x 30 cm. Piecz 50 minut w 180 st.C \nUpieczone ciasto wyjmij z formy. Gdy lekko przestygnie posmaruj pozostałą masą kakaową i odstaw do zastygnięcia.", "Kostka do pieczenia Kasia 1 opak. \nmleko 0,5 szklanek \ncukier 1,5 szklanka \njajka 4 szt. \nkakao 4 łyżki \nmąka pszenna 340 g \nproszek do pieczenia 10 g", 60, "Bardzo trudny", 4, 500, "Ciasta", 1, now(), now()),
	
	("Tradycyjne kotlety de volaille", 4, "Piersi z kurczaka zaczynając od środka rozetnij delikatnie nożem, tak aby mięso można było rozłożyć na zewnątrz – uważaj przy tym aby mięsa odciąć od reszty kotleta. Rozciętą pierś rozbij dokładnie na cienki plasterek. Mięso delikatnie oprósz solą i pieprzem. \nMasło pomieszaj z posiekanym koperkiem, w ręku uformuj je w podłużny kawałek. Połóż z brzegu kotleta. Mięso zroluj dokładnie przykrywając cały tłuszcz. Zrób to dokładnie inaczej masło wypłynie ze środka. \nUformowane kotlety w podłużny walec zwężający się na końcach, oprósz mąką i panieruj w roztrzepanym jajku, a następnie obtocz w tartej bułce. Końcówki kotleta dobrze jest panierować podwójnie zapobiega to wyciekaniu masła ze środka. \nNa patelni rozgrzej Ramę, poczekaj aż z powierzchni tłuszczu znikną bąbelki, będzie to oznaczać,że osiągnął on odpowiednią temperaturę. Kotlety smaż z każdej strony na złoty kolor. Po usmażeniu trzymaj je jeszcze na patelni pod przykryciem około 5 minut lub dopiecz w piekarniku – tak aby były na pewno upieczone w środku.", "Pierś z kurczaka 4 szt. \nrama smaż jak szef kuchni 200 ml \nmasło 200g \nkoperek 1 pęczek \njajka 2 szt. \nbułka tarta 100 g \nmąka pszenna 100 g \n sól 1 szczypta \npieprz 1 szczypta", 30, "Łatwy", 4, 1100, "Dania główne", 1, now(), now()),
	
	("Zupa rybna", 5, "Warzywa umyć. Marchewkę, pietruszkę i selera obrać i zetrzeć na tarce o większych oczkach. Pora pokroić wzdłuż na 4 części, następnie w poprzek na plasterki. Cebulę pokroić w kosteczkę. \nW szerszym garnku na łyżce oliwy i łyżce masła zeszklić cebulę. Następnie dodać pora i smażyć dalej co chwilę mieszając przez ok. 2 minuty. \nDodać marchewkę, pietruszkę i selera. Warzywa doprawić solą i pieprzem i smażyć przez około 3 minuty. Dodać przyprawy i wymieszać. \nWlać gorący bulion i zagotować. Dodać przecier pomidorowy oraz pomidory (świeżego pomidora należy sparzyć, obrać ze skórki, pokroić w kosteczkę usuwając szypułki). \nZupę po zagotowaniu przykryć, zmniejszyć ogień i gotować przez ok. 10 minut do miękkości warzyw. \nRybę opłukać, odciąć skórę i wyjąć ości. Pokroić w kostkę, doprawić solą i włożyć w mleko. Następnie obtoczyć w mące i krótko obsmażyć na patelni z łyżką rozgrzanego masła i łyżką oliwy. \nPodsmażoną rybę włożyć do garnka z zupą i gotować przez ok. 2 - 3 minuty. Dodać posiekaną bazylię lub natkę pietruszki. Podawać z pieczywem.", "500 g świeżych filetów ryby np.sandacz, miruna, dorsz \n1,5 litra bulionu jarzynowego \n1/2 cebuli \n1 marchewka \n1 mała pietruszka \n1/4 korzenia selera \n1 mały por \n1 świeży pomidor \nsól i świeżo zmielony pieprz \n2 listki laurowe \n4 ziela angielskie \n1 łyżeczka suszonego oregano \n1 łyżka oliwy \n1 łyżka masła \n2 łyżki mąki pszennej \n1 łyżka posiekanej bazylii", 60, "Średni", 1, 500, "Zupy", 1, now(), now()),
	
	("Sałatka jarzynowa", 6, "Ziemniaki, marchewkę i pietruszkę umyć (nie obierać), włożyć do garnka, zalać wodą, posolić i gotować pod przykryciem do miękkości, przez ok. 40 minut. \nOdcedzić, ostudzić, obrać ze skórek i pokroić w kosteczkę, włożyć do dużej miski. \nJajka ugotować na twardo (ok. 5 - 6 minut licząc od zagotowania się wody), pokroić w kosteczkę, dodać do miski z jarzynami. \nOgórki, cebulę oraz jabłko obrać i pokroić w kosteczkę, dodać do miski. Wsypać dobrze odsączony i osuszony groszek. \nCałość doprawić solą (około 1/2 łyżeczki) oraz zmielonym czarnym pieprzem (około 1/2 łyżeczki). Wymieszać z majonezem (kilka łyżek zostawić do dekoracji) oraz musztardą. \nPrzełożyć do salaterki i pokryć odłożonym majonezem, udekorować wedle uznania.", "3 ziemniaki \n2 marchewki \n1 pietruszka \n4 jajka \n3 ogórki kiszone \n1/4 cebuli \n1/2 jabłka \n1 mała puszka zielonego groszku \nok. 1 szklanka majonezu \n1 łyżeczka musztardy", 60, "Łatwy", 4, 400, "Sałatki", 1, now(), now()),
	
	("Ryż z owocami morza", 7, "Ryż ugotuj w wodzie tak, aby był sypki. Następnie odcedź. \nNa oliwie podsmaż posiekany czosnek i mieszankę owoców morza. \nNastępnie dodaj curry i ryż. Całość smaż jeszcze kilka minut. \nFix Knorr wymieszaj ze szklanką wody. \nWlej sos na patelnię. Dodaj pomidory pokrojone w kostkę (bez pestek) i sok z cytryny. Całość smaż, aż większość płynu wyparuje. \nPodawaj ze świeżą kolendrą.", "mieszanka owoców morza 400 g \n ryż basmati 300 g \nfix Smażony ryż po chińsku Knorr 1 opak. \npomidory 2 szt. \nząbki czosnku 2 szt. \nwoda 1 szklanka \ncytryna 1 szt. \ncurry knorr 1 łyżka \nkolendra 0,5 pęczków \noliwa 50 ml", 40, "Trudny", 4, 300, "Wege", 1, now(), now()),
	
	("Sałatka gyros", 5, "Mięso pokrój w paski i oprósz Fixem Knorr. Usmaż na patelni i odstaw do ostygnięcia. Przygotuj sos, mieszając Ketchup Hellmann’s Pikantny z Majonezem Babuni Hellmann's i sosem czosnkowym z opakowania Fix Knorr. \nKapustę pokrój w paski, pomidory, cebulę i ogórki w kostkę, a kukurydzę odcedź. \nSkładniki układaj warstwowo w misce. Zacznij od kapusty, potem dodawaj kolejno pozostałe warzywa i mięso. Warstwy przekładaj co jakiś czas sosem.", "pierś z kurczaka 300 g \nFix Kebab z sosem czosnkowym Knorr 1 opak. \nkapusta pekińska 300 g \npomidory 2 szt. \nczerwona cebula \n2 szt. \nkukurydza z puszki 1 opak. \nogórki konserwowe 4 szt. \nMajonez Hellmann's Babuni 100g \nKetchup Hellmann's Extra Hot \nolej do smażenia 5 łyżek", 50, "Banalny", 4, 400, "Sałatki", 1, now(), now()),
	
	("Piernik", 4, "Piekarnik nagrzać do 180 stopni C. Pokrojone masło włożyć do rondelka, dodać kakao, przyprawę piernikową, miód. Mieszając rozpuścić składniki na gładką masę. Odstawić z ognia, dodać mleko i wymieszać, następnie dodać jajka i rozmieszać rózgą. \nDo czystej miski wsypać mąkę, dodać cukier, sodę i proszek do pieczenia, wymiesza. Wlać masę z rondelka i zmiksować na małych obrotach miksera (dokładnie, ale tylko do połączenia się składników w jednolite ciasto). \nMasę wlać do formy o wymiarach ok. 20 x 30 cm wyłożonej papierem do pieczenia i wstawić do piekarnika na 25 - 30 minut (do suchego patyczka). \nWyjąć ciasto z piekarnika i ostudzić, następnie przekroić poziomo na 2 blaty. Dolny posmarować powidłami, przykryć drugim, wierzch posmarować polewą: w garnuszku roztapiać na małym ogniu ciągle mieszając połamaną na kosteczki czekoladę i pokrojone masło. Udekorować orzechami lub suszonymi śliwkami. Przechowywać w pojemniku na ciasto.", "100 g masła \n2 łyżki kakao \n2 łyżki przyprawy piernikowej \n2 łyżki miodu \n250 ml mleka \n3 jajka \n200 g mąki \n200 g cukru \n1 i 1/3 łyżeczki sody oczyszczonej \n3/4 łyżeczki proszku do pieczenia", 60, "Średni", 10, 1400, "Desery", 1, now(), now());
	


insert into opinie (id_przepisu, id_autora, id_oceny, komentarz, data_opinii) values
	(1, 2, 4, "Bardzo smaczne", now()),
	(2, 3, 3, "moglo by byc lepsze", now()),
	(3, 4, 2, "nie smakowało mi", now()),
	(4, 5, 1, "obrzydliwe", now()),
	(5, 1, 4, "Bardzo dobry przepis ale nie przepis nie jest jasny ;/" , now()),
	(6, 2, 4, "Smaczne ale jadłem lepsze", now()),
	(7, 3, 5, "Najlepsze co w życiu jadłem tak", now()),
	(8, 4, 5, "Bardzo dobre", now()),
	(9, 5, 2, "Szału nie ma, **** nie urywa", now()),
	(10, 6, 5, "Bardzo dobre gorąco wszytstkim polecam! :D", now()),
	(11, 4, 4, "Fajne ale moglo by być lezpsze.", now()),
	(12, 7, 5, "Zrobiłem swojemu wynkowi i bardzo mu smakowało. Gorąco polecam i pozdrawiam.", now()),
	(13, 3, 4, "Mi smakowało ale Mariuszowi już nie", now()),
	(14, 8, 5, "Patryk mówił ze bardzo dobre ale ja mu do konca nie wieże XD", now()),
	(15, 2, 5, "Nie mam już pomysłów ale daje 5 bo fajna stronka", now()),
	(16, 5, 4, "Jakiś fajny długi komentarz na 4, ale jest juz 8 godzina i nie mam już wg pomysłu wiec pisze byle co", now()),
	(17, 2, 4, "Mariusz nie potrafi zrobić bazy hahaha", now()),
	(18, 3, 4, "Cały czas mu błędy wywala", now()),
	(19, 5, 5, "OOOO Pychotka", now()),
	(20, 4, 5, "Tak wpadłem na pomysł nagle", now()),
	(21, 4, 4, "Nie no to wcześniej napisałem", now()),
	(22, 7, 5, "O mariuszowi działają relacje", now()),
	(23, 8, 4, "hahahahah chce usuwać baze jak ją dopiero dodał", now()),
	(24, 8, 5, "Zrobiłam już kilka razy . Pychotka ...powiedział małżonek :)", now()),
	(25, 5, 4, "Tak naprawde nie robiłem ale to fajny pomysł na komentarz", now()),
	(26, 5, 5, "Patryk jest fajny, lubie go", now()),
	(27, 1, 4, "Mariusza trochę też", now()),
	(28, 3, 4, "Jutro nowe zdjecie na ig Mariusza", now()),
	(29, 5, 5, "Photoemperor na ig polecam zaobserwować bo ładne zdjęca", now()),
	(30, 2, 4, "Żart XD", now()),
	(1, 7, 5, "Koniec :D", now());
	
DELIMITER $$
CREATE TRIGGER data_dod_uz
BEFORE INSERT ON uzytkownicy
FOR EACH ROW 
SET NEW.data_dodania = now(),
NEW.data_modyfikacji = now();

$$

DELIMITER $$
CREATE TRIGGER data_dod_prze
BEFORE INSERT ON przepisy
FOR EACH ROW 
SET NEW.data_dodania = now(),
NEW.data_modyfikacji = now();
$$

DELIMITER $$
CREATE TRIGGER data_dod_op
BEFORE INSERT ON opinie
FOR EACH ROW 
SET NEW.data_opinii = now();
$$

DELIMITER $$
CREATE TRIGGER mody_uz
BEFORE UPDATE ON uzytkownicy
FOR EACH ROW BEGIN
SET NEW.data_modyfikacji = now();
END;
$$

DELIMITER $$
CREATE TRIGGER mody_przey
BEFORE UPDATE ON przepisy
FOR EACH ROW BEGIN
SET NEW.data_modyfikacji = now();
END;
$$

	


	
	
	
	


	
	
	
	 

	 


 




