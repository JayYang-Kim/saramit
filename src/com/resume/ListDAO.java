package com.resume;

import java.sql.Connection;

import com.util.DBConn;

public class ListDAO {
	private Connection conn;
	
	public ListDAO() {
		conn = DBConn.getConnection();
	}
	
}
