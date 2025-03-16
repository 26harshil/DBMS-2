// 1. Create a new database named “Darshan”.
use Darshan
// Switched to db Darshan

// 2. Create another new database named “DIET”.
use DIET
// Switched to db DIET

// 3. List all databases.
show databases
// Output:
// admin    80.00 KiB
// config  108.00 KiB

// 4. Check the current database.
db
// Output: DIET

// 5. Drop “DIET” database.
db.dropDatabase('DIET')
// Output:
// { ok: 1, dropped: 'DIET' }

// 6. Create a collection named “Student” in the “Darshan” database.
use Darshan
db.createCollection('Student')
// Output:
// { ok: 1 }

// 7. Create a collection named “Department” in the “Darshan” database.
db.createCollection('Department')
// Output:
// { ok: 1 }

// 8. List all collections in the “Darshan” database.
show collections
// Output:
// Department
// Student

// 9. Insert a single document using insertOne into “Department” collection. (Dname:’CE’, HOD:’Patel’)
db.Department.insertOne({ Dname: 'CE', HOD: 'Patel' })
// Output:
// { acknowledged: true, insertedId: ObjectId('67646c8b17f1b10436a6b7b8') }

// 10. Insert two documents using insertMany into “Department” collection. (Dname:’IT’ and Dname:’ICT’)
db.Department.insertMany([
  { Dname: 'IT', HOD: 'Smith' },
  { Dname: 'ICT', HOD: 'Jones' }
])
// Output:
// { acknowledged: true, insertedIds: { '0': ObjectId('67646d5917f1b10436a6b7b9'), '1': ObjectId('67646d5917f1b10436a6b7ba') } }

// 11. Drop a collection named “Department” from the “Darshan” database.
db.Department.drop()
// Output:
// true

// 12. Insert a single document using insertOne into “Student” collection. (Fields are Name, City, Branch, Semester, Age)
db.Student.insertOne({
  Name: "John", City: "PBR", Branch: "CSE", Semester: "2", Age: 20
})
// Output:
// { acknowledged: true, insertedId: ObjectId('67646e3817f1b10436a6b7bb') }

// 13. Insert three documents using insertMany into “Student” collection. (Fields are Name, City, Branch, Semester, Age)
db.Student.insertMany([
  { Name: "Amit", City: "Delhi", Branch: "CSE", Semester: "3", Age: 21 },
  { Name: "Ravi", City: "Mumbai", Branch: "IT", Semester: "2", Age: 22 },
  { Name: "Priya", City: "Chennai", Branch: "ECE", Semester: "1", Age: 20 }
])
// Output:
// { acknowledged: true, insertedIds: { '0': ObjectId('67646e9217f1b10436a6b7bc'), '1': ObjectId('67646e9217f1b10436a6b7bd'), '2': ObjectId('67646e9217f1b10436a6b7be') } }

// 14. Check whether “Student” collection exists or not.
db.getCollectionNames().includes("Student")
// Output:
// true

// 15. Check the stats of “Student” collection.
db.Student.stats()
// Output:
// Stats details as per the MongoDB `stats()` method

// 16. Drop the “Student” collection.
db.Student.drop()
// Output:
// true

// 17. Create a collection named “Deposit”.
db.createCollection("Deposit")
// Output:
// { ok: 1 }

// 18. Insert following data into “Deposit” collection.
db.Deposit.insertMany([
  { ACTNO: 102, CNAME: 'SUNIL', BNAME: 'AJNI', AMOUNT: 5000.00, CITY: 'SURAT' },
  { ACTNO: 103, CNAME: 'MEHUL', BNAME: 'KAROLBAGH', AMOUNT: 3500.00, CITY: 'BARODA' },
  { ACTNO: 104, CNAME: 'MADHURI', BNAME: 'CHANDI', AMOUNT: 1200.00, CITY: 'AHMEDABAD' },
  { ACTNO: 105, CNAME: 'PRMOD', BNAME: 'M.G. ROAD', AMOUNT: 3000.00, CITY: 'SURAT' },
  { ACTNO: 106, CNAME: 'SANDIP', BNAME: 'ANDHERI', AMOUNT: 2000.00, CITY: 'RAJKOT' },
  { ACTNO: 107, CNAME: 'SHIVANI', BNAME: 'VIRAR', AMOUNT: 1000.00, CITY: 'SURAT' },
  { ACTNO: 108, CNAME: 'KRANTI', BNAME: 'NEHRU PLACE', AMOUNT: 5000.00, CITY: 'RAJKOT' }
])
// Output:
// { acknowledged: true, insertedIds: { '0': ObjectId('67646fcc17f1b10436a6b7bf'), '1': ObjectId('67646fcc17f1b10436a6b7c0'), '2': ObjectId('67646fcc17f1b10436a6b7c1'), '3': ObjectId('67646fcc17f1b10436a6b7c2'), '4': ObjectId('67646fcc17f1b10436a6b7c3'), '5': ObjectId('67646fcc17f1b10436a6b7c4'), '6': ObjectId('67646fcc17f1b10436a6b7c5') } }

// 19. Display all the documents of “Deposit” collection.
db.Deposit.find()
// Output:
// { _id: ObjectId('67646fcc17f1b10436a6b7bf'), ACTNO: 102, CNAME: 'SUNIL', BNAME: 'AJNI', AMOUNT: 5000, CITY: 'SURAT' }
// { _id: ObjectId('67646fcc17f1b10436a6b7c0'), ACTNO: 103, CNAME: 'MEHUL', BNAME: 'KAROLBAGH', AMOUNT: 3500, CITY: 'BARODA' }
// { _id: ObjectId('67646fcc17f1b10436a6b7c1'), ACTNO: 104, CNAME: 'MADHURI', BNAME: 'CHANDI', AMOUNT: 1200, CITY: 'AHMEDABAD' }
// { _id: ObjectId('67646fcc17f1b10436a6b7c2'), ACTNO: 105, CNAME: 'PRMOD', BNAME: 'M.G. ROAD', AMOUNT: 3000, CITY: 'SURAT' }
// { _id: ObjectId('67646fcc17f1b10436a6b7c3'), ACTNO: 106, CNAME: 'SANDIP', BNAME: 'ANDHERI', AMOUNT: 2000, CITY: 'RAJKOT' }
// { _id: ObjectId('67646fcc17f1b10436a6b7c4'), ACTNO: 107, CNAME: 'SHIVANI', BNAME: 'VIRAR', AMOUNT: 1000, CITY: 'SURAT' }
// { _id: ObjectId('67646fcc17f1b10436a6b7c5'), ACTNO: 108, CNAME: 'KRANTI', BNAME: 'NEHRU PLACE', AMOUNT: 5000, CITY: 'RAJKOT' }

// 20. Drop the “Deposit” collection.
db.Deposit.drop()
// Output:
// true
