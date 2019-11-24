import pymongo

client = pymongo.MongoClient("database", 27017)
db = client.test
db.my_collection.insert_one({"x": 10}).inserted_id
print(db.my_collection.find_one())