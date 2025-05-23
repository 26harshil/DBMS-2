PART:- A

1. Find employees whose name start with E.
db.Employee.find({'ENAME' : /^E/})
2. Find employees whose name ends with n.
db.Employee.find({'ENAME' : /n$/})
3. Find employees whose name starts with S or M in your collection.
db.Employee.find({'ENAME' : /^[SM]/})
4. Find employees where city starts with A to M in your collection.
db.Employee.find({'CITY' : /^[A-M]/})
5. Find employees where city name ends in ‘ney’.
db.Employee.find({'CITY' : /ney$/})
6. Display employee info whose name contains n. (Both uppercase(N) and lowercase(n))
db.Employee.find({'ENAME' : /n/i})
7. Display employee info whose name starts with E and having 5 characters.
db.Employee.find({'ENAME' : /^E.{4}/})
8. Display employee whose name start with S and ends in a.
db.Employee.find({'ENAME' : /^S.*a$/})
9. Display EID, ENAME, CITY and SALARY whose name starts with ‘Phi’.
db.Employee.find({'ENAME' : /^Phi/} , {_id:0, 'EID' : 1 , 'ENAME' : 1 , 'CITY' : 1 , 'SALARY' : 1})
10. Display ENAME, JOININGDATE and CITY whose city contains ‘dne’ as	 in city name.
db.Employee.find({'CITY' : /dne/} , {_id:0, 'ENAME' : 1 , 'JOININGDATE' : 1 , 'CITY' : 1})
11. Display ENAME, JOININGDATE and CITY who does not belongs to city London or Sydney.
db.Employee.find({'CITY' : {$nin:['London','Sydney']}} , {_id:0, 'ENAME' : 1 , 'JOININGDATE' : 1 , 'CITY' : 1})
12. Find employees whose names start with 'J'.
db.Employee.find({'ENAME' : /^J/})
13. Find employees whose names end with 'y'.
db.Employee.find({'ENAME' : /y$/})
14. Find employees whose names contain the letter 'a'.
db.Employee.find({'ENAME' : /a/})
15. Find employees whose names contain either 'a' or 'e'.
db.Employee.find({'ENAME' : /[a , e]/})
16. Find employees whose names start with 'J' and end with 'n'.
db.Employee.find({'ENAME' : /^J.*n/})
17. Find employees whose CITY starts with 'New'.
db.Employee.find({'CITY' : /^New/})
18. Find employees whose CITY does not start with 'L'
db.Employee.find({'CITY' : /^[^L]/})
19. Find employees whose CITY contains the word 'York'.
db.Employee.find({'CITY' : /York/})
20. Find employees whose names have two consecutive vowels (a, e, i, o, u).
db.Employee.find({'ENAME' : /[a , e, i , o, u]{2}/})
21. Find employees whose names have three or more letters.
db.Employee.find({'ENAME' : /^.{3,}$/})
22. Find employees whose names have exactly 4 letters.
db.Employee.find({'ENAME' : /^.{4}$/})
23. Find employees whose names start with either 'S' or 'M'.
db.Employee.find({'ENAME' : /^[SM]/})
24. Find employees whose names contain 'il' anywhere.
db.Employee.find({'ENAME' : /il/})
25. Find employees whose names do not contain 'a'.
db.Employee.find({'ENAME' : {$not : /a/}})
26. Find employees whose names contain any digit.
db.Employee.find({'ENAME' : /\d/})
27. Find employees whose names contain exactly one vowel.
db.Employee.find({'ENAME' :/^[^aeiou]*[aeiou][^aeiou]*$/i})
28. Find employees whose names start with any uppercase letter followed by any lowercase letter.
db.Employee.find({'ENAME' :/^[A-Z][a-z]/})

PART : B

1. Display documents where sname start with K.
db.Student.find({'SNAME' : /^K/})
2. Display documents where sname starts with Z or D.
db.Student.find({'SNAME' : /^[ZD]/})
3. Display documents where city starts with A to R.
db.Student.find({'CITY' : /^[A-R]/})
4. Display students’ info whose name start with P and ends with i.
db.Student.find({'SNAME' : /^P.*i$/})
5. Display students’ info whose department name starts with ‘C’.
db.Student.find({'DEPARTMENT' : /^C/})
6. Display name, sem, fees, and department whose city contains ‘med’ as three letters somewhere in city
name.
db.Student.find({'CITY' : /med/} , {_id : 0 , 'SNAME' : 1 , 'FEES' : 1 , 'DEPARTMENT' : 1 , 'SEM' : 1})
7. Display name, sem, fees, and department who does not belongs to city Rajkot or Baroda.
db.Student.find({'CITY' : {$nin : ['Rajkot' , 'Baroda']}} , {_id : 0 , 'SNAME' : 1 , 'FEES' : 1 , 'DEPARTMENT' : 1 , 'SEM' : 1})
8. Find students whose names start with 'K' and are followed by any character.

9. Find students whose names end with 'a'.
10. Find students whose names contain 'ri'. (case-insensitive)
