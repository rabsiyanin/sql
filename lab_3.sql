/*Лабораторная работа №3, Игнатов Георгий*/
/*Задание первое*/

CREATE TABLE ВОДИТЕЛЬ (
  ИДЕНТИФИКАТОР INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  ФАМИЛИЯ VARCHAR(50) NOT NULL,
  АВТОПРЕДПРИЯТИЕ VARCHAR(50) NOT NULL,
  "ЛЬГОТА,%" NUMERIC(3,0)
);


CREATE TABLE "ЦЕНТР ОБСЛУЖИВАНИЯ" (
  ИДЕНТИФИКАТОР INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  НАЗВАНИЕ VARCHAR(50) NOT NULL UNIQUE,
  ВЛАДЕЛЕЦ VARCHAR(50) NOT NULL,
  "КОМИССИОННЫЕ,%" NUMERIC(3,0)
);

CREATE TABLE ПРЕЙСКУРАНТ (
  ИДЕНТИФИКАТОР INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  ТОВАР VARCHAR(50) NOT NULL,
  "ЦЕНА, РУБ" NUMERIC(7,2),
  "У КОГО ЗАКУПАЕТСЯ" VARCHAR(50) NOT NULL,
  "МАКС. КОЛ-ВО" NUMERIC(9,0)
);

CREATE TABLE ЗАКАЗ (
  "НОМЕР ВЕДОМОСТИ" INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  ДАТА VARCHAR(50) NOT NULL,
  ВОДИТЕЛЬ INT NOT NULL,
  "ЦЕНТР ОБСЛ." INT NOT NULL,
  "ТОВАР ПО ПРЕЙСКУРАНТУ" INT NOT NULL,
  "КОЛ-ВО" NUMERIC(9,0) NOT NULL,
  "ИТОГО, РУБ" NUMERIC(9,2) NOT NULL
);
ALTER SEQUENCE "ЗАКАЗ_НОМЕР ВЕДОМОСТИ_seq" RESTART WITH 12201;

/* Задание второе */

INSERT INTO ВОДИТЕЛЬ (ФАМИЛИЯ,АВТОПРЕДПРИЯТИЕ,"ЛЬГОТА,%")
VALUES
('Горбунов','АТП 1',5),
('Попов','МП "ФорТУНА"',0),
('Денисов','АО "Автотранс"',10),
('Сергеев','АО "Автотранс"',10),
('Левкин','АТП 1',5);

INSERT INTO "ЦЕНТР ОБСЛУЖИВАНИЯ" (НАЗВАНИЕ,ВЛАДЕЛЕЦ,"КОМИССИОННЫЕ,%")
VALUES
('Окружная дорога1', 'АТП1', 3),
('Окружная дорога2', 'АТП1', 3),
('123КМ','АО "Автотранс"',2),
('АЗС12', 'АО "ФорТУНА"',4),
('АЗС7','АТП1',3),
('У поворота', 'АО ФорТУНА' ,4);

INSERT INTO ПРЕЙСКУРАНТ(ТОВАР,"ЦЕНА, РУБ","У КОГО ЗАКУПАЕТСЯ","МАКС. КОЛ-ВО")
VALUES
('Бензин АИ-72', 9000, 'АТП1', 10000),
('Бензин АИ-96', 10000, 'АТП1', 12000), 
('Масло моторное МТ23-12', 7000, 'АО "ФорТУНА"', 7000), 
('Масло моторное УММ-23Т', 18500, 'АО "Автотранс"', 5300), 
('Свеча зажигания', 22000, 'АО "Автотранс"', 200), 
('Прокладка', 6000, 'АТП1', 500), 
('Жидкость смывная', 12000, 'АО "ФорТУНА"', 100);

INSERT INTO ЗАКАЗ(ДАТА, ВОДИТЕЛЬ, "ЦЕНТР ОБСЛ.", "ТОВАР ПО ПРЕЙСКУРАНТУ", "КОЛ-ВО", "ИТОГО, РУБ")
VALUES
('Январь',   2, 4, 7, 4, 48000),('Январь',   3, 5, 7, 4, 48000),
('Январь',   3, 5, 7, 6, 72000),('Февраль',  3, 3, 4, 2, 37000),
('Февраль',  4, 2, 1, 40, 360000),('Февраль',  4, 1, 1, 40, 360000),
('Март',     3, 1, 1, 20, 180000),('Апрель',   2, 4, 3, 10, 70000),
('Апрель',   3, 3, 6, 4, 24000),('Май',      1, 2, 6, 2, 12000),
('Май',      3, 6, 3, 2, 14000),('Июнь',     5, 4, 7, 10, 120000),
('Июль',     3, 4, 4, 10, 185000),('Июль',     5, 4, 2, 6, 60000),
('Август',   2, 6, 5, 4, 88000),('Сентябрь', 1, 4, 5, 6, 132000),
('Сентябрь', 3, 1, 7, 40, 360000);

/* Задание третье */

SELECT * FROM ВОДИТЕЛЬ ORDER BY ИДЕНТИФИКАТОР;
UPDATE "ЦЕНТР ОБСЛУЖИВАНИЯ" SET ВЛАДЕЛЕЦ = 'АО "ФорТУНА"' WHERE ВЛАДЕЛЕЦ = 'АО ФорТУНА';
SELECT * FROM "ЦЕНТР ОБСЛУЖИВАНИЯ" ORDER BY ИДЕНТИФИКАТОР;
SELECT * FROM ПРЕЙСКУРАНТ;
SELECT * FROM ЗАКАЗ;

/* Задание четвёртое */

/*а)*/   SELECT DISTINCT  ИДЕНТИФИКАТОР,  ФАМИЛИЯ FROM ВОДИТЕЛЬ ORDER BY ИДЕНТИФИКАТОР;
/*b)*/   SELECT DISTINCT  АВТОПРЕДПРИЯТИЕ FROM ВОДИТЕЛЬ;
/*с)*/   SELECT DISTINCT  ВЛАДЕЛЕЦ FROM "ЦЕНТР ОБСЛУЖИВАНИЯ";

/* Задание пятое */

/*a)*/ SELECT   НАЗВАНИЕ, ВЛАДЕЛЕЦ FROM "ЦЕНТР ОБСЛУЖИВАНИЯ" WHERE ("КОМИССИОННЫЕ,%" < 4);  
/*b)*/ SELECT   НАЗВАНИЕ, ВЛАДЕЛЕЦ, "КОМИССИОННЫЕ,%" FROM "ЦЕНТР ОБСЛУЖИВАНИЯ" WHERE НАЗВАНИЕ LIKE '%АЗС%';  
/*c)*/ SELECT   ФАМИЛИЯ, АВТОПРЕДПРИЯТИЕ FROM ВОДИТЕЛЬ WHERE ("ЛЬГОТА,%" = 0); 


/* Задание шестое */

/*a)*/
SELECT "НОМЕР ВЕДОМОСТИ",  ДАТА,  ( SELECT  ВОДИТЕЛЬ.ФАМИЛИЯ  FROM ВОДИТЕЛЬ  
  WHERE (ВОДИТЕЛЬ.ИДЕНТИФИКАТОР=ЗАКАЗ.ВОДИТЕЛЬ) ) AS "ФАМИЛИЯ ВОДИТЕЛЯ",  "ЦЕНТР ОБСЛ.",
"ТОВАР ПО ПРЕЙСКУРАНТУ", "ИТОГО, РУБ" FROM ЗАКАЗ ORDER BY "ФАМИЛИЯ ВОДИТЕЛЯ" ASC, "ИТОГО, РУБ" ASC;

/*b)*/
SELECT ( SELECT ВОДИТЕЛЬ.ФАМИЛИЯ FROM ВОДИТЕЛЬ WHERE (ВОДИТЕЛЬ.ИДЕНТИФИКАТОР=ЗАКАЗ.ВОДИТЕЛЬ)) 
AS "ФАМИЛИЯ ВОДИТЕЛЯ", "ЦЕНТР ОБСЛ.","ТОВАР ПО ПРЕЙСКУРАНТУ","КОЛ-ВО"FROM ЗАКАЗ; 



/* Задание седьмое */
/*a)*/
SELECT 
НАЗВАНИЕ
    FROM "ЦЕНТР ОБСЛУЖИВАНИЯ"
    WHERE ИДЕНТИФИКАТОР = ANY (
      SELECT DISTINCT
      "ЦЕНТР ОБСЛ."
    FROM ЗАКАЗ JOIN 
        ВОДИТЕЛЬ ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР JOIN 
          "ЦЕНТР ОБСЛУЖИВАНИЯ" 
          ON "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ = ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ
    WHERE ("ИТОГО, РУБ" / "КОЛ-ВО" BETWEEN 8000 AND 10000)
    );

/*b)*/  
    SELECT DISTINCT
      "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ
    FROM ЗАКАЗ 
      JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
      FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
      FULL JOIN ВОДИТЕЛЬ 
        ON ВОДИТЕЛЬ.ИДЕНТИФИКАТОР = ЗАКАЗ.ВОДИТЕЛЬ
    WHERE (ДАТА != 'Январь' AND ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ= 'АО "Автотранс"' 
      AND ПРЕЙСКУРАНТ.ТОВАР LIKE '%Бензин%');

/*с)*/
    SELECT 
      ПРЕЙСКУРАНТ.ТОВАР
    FROM ЗАКАЗ 
      JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
      JOIN ВОДИТЕЛЬ
        ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
      JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
    WHERE (ВОДИТЕЛЬ.ФАМИЛИЯ = 'Денисов' AND ЗАКАЗ."ЦЕНТР ОБСЛ." != ANY (
      SELECT
        "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
      FROM 
        "ЦЕНТР ОБСЛУЖИВАНИЯ" FULL JOIN
        ВОДИТЕЛЬ ON "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ = ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ
      WHERE 
        ВОДИТЕЛЬ.ФАМИЛИЯ = 'Денисов'
      ) 
    );

/*d)*/
  SELECT
      "НОМЕР ВЕДОМОСТИ", 
      ДАТА,
      "ЦЕНТР ОБСЛУЖИВАНИЯ".НАЗВАНИЕ AS "НАЗВАНИЕ ЦЕНТРА",
      "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ AS "ВЛАДЕЛЕЦ ЦЕНТРА",
      ПРЕЙСКУРАНТ."У КОГО ЗАКУПАЕТСЯ"
    FROM ЗАКАЗ
      FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
      FULL JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
      FULL JOIN ВОДИТЕЛЬ
        ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
    WHERE (ПРЕЙСКУРАНТ."У КОГО ЗАКУПАЕТСЯ" != "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ);


/*Задание восьмое*/

UPDATE ЗАКАЗ SET "ИТОГО, РУБ" = "ИТОГО, РУБ" * (100-(
  SELECT     ВОДИТЕЛЬ."ЛЬГОТА,%"   FROM ВОДИТЕЛЬ  
   WHERE ИДЕНТИФИКАТОР = ЗАКАЗ.ВОДИТЕЛЬ))/100;

/*Задание девятое*/

ALTER TABLE ЗАКАЗ
ADD КОМИССИОННЫЕ INTEGER NOT NULL DEFAULT(0);
UPDATE ЗАКАЗ SET КОМИССИОННЫЕ = "ИТОГО, РУБ" / 100 * (
SELECT DISTINCT "КОМИССИОННЫЕ,%" FROM "ЦЕНТР ОБСЛУЖИВАНИЯ" 
WHERE "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР = "ЦЕНТР ОБСЛ.");


/*Задание десятое*/

/*а)*/
  SELECT DISTINCT
      ФАМИЛИЯ
    FROM ЗАКАЗ FULL JOIN ВОДИТЕЛЬ
        ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
    WHERE "ЦЕНТР ОБСЛ." NOT IN (
      SELECT 
        ИДЕНТИФИКАТОР
      FROM "ЦЕНТР ОБСЛУЖИВАНИЯ"
      WHERE ("КОМИССИОННЫЕ,%">2)
      );

/*b)*/
SELECT ФАМИЛИЯ
FROM ЗАКАЗ
FULL JOIN ПРЕЙСКУРАНТ
ON ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР = ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ"
FULL JOIN ВОДИТЕЛЬ
ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ"
ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
WHERE "ТОВАР ПО ПРЕЙСКУРАНТУ" = (
SELECT 
ИДЕНТИФИКАТОР
FROM "ПРЕЙСКУРАНТ"
WHERE ТОВАР LIKE '%УММ-23Т%') AND 
"ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ != ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ
GROUP BY ФАМИЛИЯ
HAVING COUNT("ТОВАР ПО ПРЕЙСКУРАНТУ" = 4) > 1;


  /*с)*/
   SELECT 
    НАЗВАНИЕ 
  FROM "ЦЕНТР ОБСЛУЖИВАНИЯ"
  WHERE ИДЕНТИФИКАТОР IN (
    SELECT DISTINCT
    "ЦЕНТР ОБСЛ."
  FROM ЗАКАЗ JOIN 
      ВОДИТЕЛЬ ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР JOIN 
        "ЦЕНТР ОБСЛУЖИВАНИЯ" ON "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ = ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ
  WHERE ("ИТОГО, РУБ" / "КОЛ-ВО" BETWEEN 8000 AND 10000)
  );

  SELECT 
      ПРЕЙСКУРАНТ.ТОВАР
    FROM ЗАКАЗ 
      JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
      JOIN ВОДИТЕЛЬ
        ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
      JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
    WHERE (ВОДИТЕЛЬ.ФАМИЛИЯ = 'Денисов' AND ЗАКАЗ."ЦЕНТР ОБСЛ." NOT IN (
      SELECT
        "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
      FROM 
        "ЦЕНТР ОБСЛУЖИВАНИЯ" FULL JOIN
        ВОДИТЕЛЬ ON "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ = ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ
      WHERE 
        ВОДИТЕЛЬ.ФАМИЛИЯ = 'Денисов'
      ) 
    );

/*Задание одиннадцатое*/

/*a)*/
  SELECT
      ФАМИЛИЯ
    FROM ЗАКАЗ 
        JOIN ВОДИТЕЛЬ
          ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
    WHERE ("ТОВАР ПО ПРЕЙСКУРАНТУ" = ANY (
      SELECT
        "ТОВАР ПО ПРЕЙСКУРАНТУ"
      FROM ЗАКАЗ
      WHERE (ДАТА = 'Май' AND "КОЛ-ВО" = ANY (
        SELECT DISTINCT
          "КОЛ-ВО"
        FROM ЗАКАЗ
        WHERE ДАТА = 'Май' AND "КОЛ-ВО" >= ALL 
        (SELECT "КОЛ-ВО" FROM ЗАКАЗ WHERE ДАТА = 'Май')
        ))
    ));

/*b*/
  SELECT DISTINCT
	  ФАМИЛИЯ, 
	  АВТОПРЕДПРИЯТИЕ, 
	  MAX("ИТОГО, РУБ") OVER (PARTITION BY 
	  	ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ)
  FROM ЗАКАЗ 
	  JOIN ВОДИТЕЛЬ 
	  ON ЗАКАЗ.ВОДИТЕЛЬ=ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
  WHERE ВОДИТЕЛЬ.ИДЕНТИФИКАТОР>=ANY(
	  SELECT DISTINCT ИДЕНТИФИКАТОР FROM ВОДИТЕЛЬ)
  ORDER BY АВТОПРЕДПРИЯТИЕ;

/*c)*/
  SELECT 
      ФАМИЛИЯ
    FROM ЗАКАЗ 
      JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
      JOIN ВОДИТЕЛЬ 
        ON ВОДИТЕЛЬ.ИДЕНТИФИКАТОР = ЗАКАЗ.ВОДИТЕЛЬ
    WHERE "ЛЬГОТА,%"<=ALL(SELECT "ЛЬГОТА,%" FROM ВОДИТЕЛЬ) 
    AND "ЦЕНТР ОБСЛ." IN 
      (
        SELECT 
          "ЦЕНТР ОБСЛ."
        FROM ЗАКАЗ
          JOIN ПРЕЙСКУРАНТ ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = 
          ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
        WHERE ДАТА = 'Январь' AND "ЦЕНА, РУБ" = (
          SELECT DISTINCT
  "ЦЕНА, РУБ"
          FROM ПРЕЙСКУРАНТ 
          WHERE "ЦЕНА, РУБ">= ALL(
            SELECT
            "ЦЕНА, РУБ"
            FROM ПРЕЙСКУРАНТ) 
          )
      );

/*d)*/
 SELECT DISTINCT
      "ЦЕНТР ОБСЛУЖИВАНИЯ".ВЛАДЕЛЕЦ
    FROM ЗАКАЗ 
      JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
      FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
      FULL JOIN ВОДИТЕЛЬ 
        ON ВОДИТЕЛЬ.ИДЕНТИФИКАТОР = ЗАКАЗ.ВОДИТЕЛЬ
    WHERE (ДАТА = ANY (SELECT ДАТА FROM ЗАКАЗ WHERE ДАТА != 'Январь') 
      AND ВОДИТЕЛЬ.АВТОПРЕДПРИЯТИЕ= 'АО "Автотранс"' 
      AND ПРЕЙСКУРАНТ.ТОВАР LIKE '%Бензин%');




/*Задание двенадцатое */

SELECT  АВТОПРЕДПРИЯТИЕ FROM ВОДИТЕЛЬ UNION
SELECT  "У КОГО ЗАКУПАЕТСЯ" FROM ПРЕЙСКУРАНТ;



/*Задание тринадцатое */

/*c)*/
  SELECT
      ФАМИЛИЯ
    FROM ЗАКАЗ
      JOIN ВОДИТЕЛЬ
        ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
      FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
      JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
    WHERE "У КОГО ЗАКУПАЕТСЯ" = АВТОПРЕДПРИЯТИЕ AND ("ЦЕНТР ОБСЛУЖИВАНИЯ".НАЗВАНИЕ NOT IN
      ( 
      SELECT
        НАЗВАНИЕ
      FROM ЗАКАЗ
        FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
          ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
      WHERE ДАТА LIKE 'Ноябрь' OR ДАТА LIKE 'Декабрь'
      ) OR NOT EXISTS 
      (
        SELECT ДАТА
        FROM ЗАКАЗ
        WHERE ДАТА LIKE 'Ноябрь' OR ДАТА LIKE 'Декабрь'
      ));


/*Задание четырнадцатое */

/*a)*/
  SELECT
      ФАМИЛИЯ
    FROM ЗАКАЗ 
      JOIN ПРЕЙСКУРАНТ
        ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
      JOIN ВОДИТЕЛЬ
        ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
      FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
    WHERE ("ТОВАР ПО ПРЕЙСКУРАНТУ" IN (
        SELECT
          ИДЕНТИФИКАТОР
        FROM ПРЕЙСКУРАНТ
        WHERE "ЦЕНА, РУБ" = (
          SELECT
            max("ЦЕНА, РУБ")
          FROM ПРЕЙСКУРАНТ
          )
      ) AND ВЛАДЕЛЕЦ != АВТОПРЕДПРИЯТИЕ);


/*b)*/
    SELECT COUNT(ФАМИЛИЯ) FROM ЗАКАЗ JOIN ВОДИТЕЛЬ
    ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
    WHERE "ЛЬГОТА,%"=(SELECT min("ЛЬГОТА,%") FROM 
      ВОДИТЕЛЬ);

/*c)*/
  SELECT
      "ТОВАР"
    FROM ПРЕЙСКУРАНТ
    WHERE ИДЕНТИФИКАТОР IN (
      SELECT
      "ТОВАР ПО ПРЕЙСКУРАНТУ"
    FROM ЗАКАЗ 
      JOIN ВОДИТЕЛЬ
        ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
      FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР
    WHERE АВТОПРЕДПРИЯТИЕ LIKE 'АТП1'
    GROUP BY "ТОВАР ПО ПРЕЙСКУРАНТУ"
    HAVING COUNT("ТОВАР ПО ПРЕЙСКУРАНТУ") > 3);

  /*d)*/
  SELECT AVG("ИТОГО, РУБ") FROM ЗАКАЗ JOIN ПРЕЙСКУРАНТ
  ON ЗАКАЗ."ТОВАР ПО ПРЕЙСКУРАНТУ" = ПРЕЙСКУРАНТ.ИДЕНТИФИКАТОР
  WHERE ТОВАР LIKE 'Свеча зажигания' OR "ЦЕНА, РУБ" < 8000;

/*Задание пятнадцатое */

/*a)*/
  SELECT НАЗВАНИЕ, sum("ИТОГО, РУБ") FROM ЗАКАЗ FULL JOIN "ЦЕНТР ОБСЛУЖИВАНИЯ" 
        ON ЗАКАЗ."ЦЕНТР ОБСЛ." = "ЦЕНТР ОБСЛУЖИВАНИЯ".ИДЕНТИФИКАТОР    
    GROUP BY НАЗВАНИЕ HAVING sum("ИТОГО, РУБ") > 200000;

/*b)*/
    SELECT "ТОВАР ПО ПРЕЙСКУРАНТУ" FROM ЗАКАЗ 
      JOIN ВОДИТЕЛЬ ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
    WHERE АВТОПРЕДПРИЯТИЕ LIKE 'АО "ФорТУНА"' AND "ТОВАР ПО ПРЕЙСКУРАНТУ" IN(
    SELECT "ТОВАР ПО ПРЕЙСКУРАНТУ" FROM ЗАКАЗ 
    GROUP BY "ТОВАР ПО ПРЕЙСКУРАНТУ" HAVING sum("ИТОГО, РУБ") <= 300000);

/*c)*/
  SELECT "ЦЕНТР ОБСЛ.",SUM("ИТОГО, РУБ") FROM ЗАКАЗ GROUP BY "ЦЕНТР ОБСЛ.";
  SELECT "ДАТА",SUM("ИТОГО, РУБ") FROM ЗАКАЗ GROUP BY "ДАТА";

/*d)*/
  SELECT ФАМИЛИЯ FROM ЗАКАЗ JOIN ВОДИТЕЛЬ
  ON ЗАКАЗ.ВОДИТЕЛЬ = ВОДИТЕЛЬ.ИДЕНТИФИКАТОР
  WHERE ДАТА IN ('Март','Апрель','Май')
  GROUP BY ФАМИЛИЯ    HAVING SUM("ИТОГО, РУБ") > 1000000;
