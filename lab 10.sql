// 1. Insert multiple documents into the "Student" collection
db.Student.insertMany([
  { "_id": 1, "name": "John", "age": 30, "city": "New York", "isActive": true },
  { "_id": 2, "name": "Jane", "age": 25, "city": "Los Angeles", "isActive": false },
  { "_id": 3, "name": "Tom", "age": 35, "city": "Chicago", "isActive": true },
  { "_id": 4, "name": "Lucy", "age": 28, "city": "San Francisco", "isActive": true },
  { "_id": 5, "name": "David", "age": 40, "city": "Miami", "isActive": false },
  { "_id": 6, "name": "Eva", "age": 23, "city": "Boston", "isActive": true },
  { "_id": 7, "name": "Nick", "age": 38, "city": "Seattle", "isActive": false },
  { "_id": 8, "name": "Sophia", "age": 27, "city": "New York", "isActive": true },
  { "_id": 9, "name": "Liam", "age": 32, "city": "Los Angeles", "isActive": false },
  { "_id": 10, "name": "Olivia", "age": 29, "city": "San Diego", "isActive": true }
]);

// 2. Find all documents in the "Student" collection
db.Student.find();

// 3. Find students whose "isActive" field is true
db.Student.find({ "isActive": true });

// 4. Find students who are older than 30
db.Student.find({ "age": { $gt: 30 } });

// 5. Find students who live in "New York" and are older than 25
db.Student.find({ "city": "New York", "age": { $gt: 25 } });

// 6. Update the age of the student with _id = 1 to 31
db.Student.updateOne({ "_id": 1 }, { $set: { "age": 31 } });

// 7. Update the "isActive" status of the student with _id = 2 to true
db.Student.updateOne({ "_id": 2 }, { $set: { "isActive": true } });

// 8. Increment the age of all students by 1 year
db.Student.updateMany({}, { $inc: { "age": 1 } });

// 9. Delete the student with _id = 10
db.Student.deleteOne({ "_id": 10 });

// 10. Delete all students who are not active (isActive = false)
db.Student.deleteMany({ "isActive": false });

// 11. Update all students aged less than 30 to set their city to "San Diego"
db.Student.updateMany({"age": {$lt: 30}}, {$set: {"city": "San Diego"}});

// 12. Rename the "age" field to "years" for all students
db.Student.updateMany({}, {$rename: {"age": "years"}});

// 13. Set the "isActive" field to "false" for the student named "Nick"
db.Student.updateMany({"name": "Nick"}, {$set: {"isActive": false}});

// 14. Set the "isActive" field to "true" for the student named "Nick"
db.Student.updateMany({"name": "Nick"}, {$set: {"isActive": true}});

// 15. Add a new field "Country" with the value "USA" for all students
db.Student.updateMany({}, {$set: {"Country": "USA"}});

// 16. Update the "city" field for the student named "David" to "Orlando"
db.Student.updateMany({"name": "David"}, {$set: {"city": "Orlando"}});

// 17. Attempt to multiply the "age" field by 2 (incorrect usage; results in NaN)
db.Student.updateMany({}, {$set: {"age": "age" * 2}});

// 18. Correct the multiplication to use $mul for the "years" field
db.Student.updateMany({}, {$mul: {"years": 2}});

// 19. Unset (remove) the "city" field for the student named "Tom"
db.Student.updateMany({"name": "Tom"}, {$unset: {city: ""}});

// 20. Add a new field "premiumUser" for students older than 30 years
db.Student.updateMany({"years": {$gt: 30}}, {$set: {premiumUser: true}});

// 21. Unset the "age" field for all documents
db.Student.updateMany({}, {$unset: {age: ""}});

// 22. View the updated documents
db.Student.find();

// 23. Update "premiumUser" to true for all students over 30 years old
db.Student.updateMany({"years": {$gt: 30}}, {$set: {premiumUser: true}});

// 24. Set "isActive" to true for Jane
db.Student.updateMany({"name": "Jane"}, {$set: {"isActive": true}});

// 25. Set "isActive" to false for Lucy
db.Student.updateMany({"name": "Lucy"}, {$set: {"isActive": false}});

// 26. Delete Nick
db.Student.deleteOne({"name": "Nick"});

// 27. Delete inactive students
db.Student.deleteMany({"isActive": false});

// 28. Delete students older than 35
db.Student.deleteMany({"years": {$gt: 35}});

// 29. Delete students younger than 25
db.Student.deleteMany({"years": {$lt: 25}});

// 30. Delete students named Olivia
db.Student.deleteMany({"name": "Olivia"});

// 31. Delete one student who is active
db.Student.deleteOne({"isActive": true});

// 32. Delete student from Los Angeles
db.Student.deleteOne({"city": 'Los Angeles'});

// 33. Attempt to delete students with missing city
db.Student.deleteOne({"city": {$exists: false}});

// 34. Renaming "city" to "location" in all documents
db.Student.updateMany({}, {$rename: {"city": "location"}});

// 35. Renaming "name" to "FullName" for John
db.Student.updateMany({"name": "John"}, {$rename: {"name": "FullName"}});

// 36. Renaming "isActive" to "status" in all documents
db.Student.updateMany({}, {$rename: {"isActive": "status"}});

// 37. Renaming "age" to "yearsOld" for students in "San Francisco"
db.Student.updateMany({"city": "San Francisco"}, {$rename: {"age": "yearsOld"}});
