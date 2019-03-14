package com.resume;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBConn;

public class DeleteDAO {
	private Connection conn;
	
	public DeleteDAO() {
		conn=DBConn.getConnection();
	}
	public int deleteResume(int resumeCode){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		int count=0;
		sql="DELETE FROM resume WHERE resumeCode=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,resumeCode);
			count=pstmt.executeUpdate();
			
			 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch(Exception e2) {
					
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch(Exception e2) {
					
				}
			}
		}
		return count;
		}
	
}
