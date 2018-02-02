package com.map;


import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.connection.Connection;


public class DBCollection 
{

@SuppressWarnings("hiding")
public <DBCollection, DB, DBCursor> Connection getConnection() throws IllegalAccessException, ClassNotFoundException, InstantiationException 
		{
	//Connection con=null;
	@SuppressWarnings("resource")
	MongoClient mongoClient = new MongoClient("localhost", 27017);
MongoDatabase database = mongoClient.getDatabase("Retailer");
	MongoCollection<org.bson.Document> collection =  database.getCollection("latlngcol");
	System.out.println("mongo connecrtion got sucess" +collection);
		 return (Connection) collection;
		}

}



