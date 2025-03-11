Part – A
1. Create an index on the company field in the stocks collection.
--> db.Stock.createIndex({ company: 1 })
2. Create a compound index on the sector and sales fields in the stocks collection.
--> db.Stock.createIndex({ sector: 1, sales: -1 })
3. List all the indexes created on the stocks collection.
--> db.Stock.getIndexes()
4. Drop an existing index on the company field from the stocks collection.
--> db.Stock.dropIndex("company_1")
5. Use a cursor to retrieve and iterate over documents in the stocks collection, displaying each document.
--> const cursor = db.Stock.find();
 cursor.forEach(doc => printjson(doc));
6. Limit the number of documents returned by a cursor to the first 3 documents in the stocks collection.
--> const cursor = db.Stock.find().limit(3);
 cursor.forEach(doc => printjson(doc));
7. Sort the documents returned by a cursor in descending order based on the sales field.
--> const cursor = db.Stock.find().sort({ sales: -1 });
 cursor.forEach(doc => printjson(doc));
8. Skip the first 2 documents in the result set and return the next documents using the cursor.
--> const cursor = db.Stock.find().skip(2);
 cursor.forEach(doc => printjson(doc));
9. Convert the cursor to an array and return all documents from the stocks collection.
--> const allDocsArray = db.Stock.find().toArray();
 printjson(allDocsArray);
10. Create a collection named "Companies" with schema validation to ensure that each document must
contains a company field (string) and a sector field (string).
	db.createCollection("Compines",
{
  validator:{
  		$jsonSchema :{
        bsonType: "object",
 				required:["companyname","sector"],
				properties:{
					companyname:{
   				bsonType:"string",
          },
					sector:{
						bsonType:"string"
            },
       }
				  
		}
  }
 }
);

--part-b
Create a collection named "Scripts" with validation for fields like eps, pe, and roe to ensure that they are
numbers and required/compulsory fields.
--> db.createCollection("Scripts", {
	db.createCollection("Scripts",
{
  validator:{
  		$jsonSchema :{
        bsonType: "object",
 				required:["eps","roi","pe"],
				properties:{
					eps:{
   				    bsonType:"int",
          },
					roi:{
						  bsonType:"int"
            },
           pe:{
				    	bsonType:"int"
            }
       }		  
		}
   }
 }
);
2. Create a collection named "Products" where each product has an embedded document for manufacturer
details and a multivalued field for categories that stores an array of category names the product belongs to.
• manufacturer details: The manufacturer will be an embedded document with fields like name,
country, and establishedYear.
• categories: The categories will be an array field that holds multiple values. (i.e. Electronics, Mobile,
Smart Devices).
--> db.createCollection("Products", {
   db.createCollection("Products", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["manufacturedetails", "categories"], // Required fields in the document
      properties: {
        manufacturedetails: {
          bsonType: "array",
          description: "The manufacturer will be an embedded document with fields like name, country, and establishYear.",
          items: {
            bsonType: "object",
            required: ["name", "country", "establishYear"], // Required fields inside each object in the array
            properties: {
              name: {
                bsonType: "string"
              },
              country: {
                bsonType: "string"
              },
              establishYear: {
                bsonType: "int"
              }
            }
          }
        },
        categories: {
          bsonType: "array",
          items: {
            bsonType: "string" // Each item in the categories array must be a string
          }
        }
      }
    }
  }
});
