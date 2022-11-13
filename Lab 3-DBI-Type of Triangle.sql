SELECT  CASE
        WHEN A+B<=C OR A+C<=B OR B+C<=A THEN 'Not A Triangle'
        WHEN A = B AND B = C then 'Equilateral'
        WHEN A = B OR B = C OR A = C then 'Isosceles'
        ELSE 'Scalene'
        END
FROM    TRIANGLES;
