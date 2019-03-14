package com.resume;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.util.DBConn;

public class ListDAO {
	private Connection conn; 
	
	public ListDAO(){
		conn=DBConn.getConnection();
}

public List<ResumeDTO> listResume(String resumeCode){ 
	List<ResumeDTO>
	list=new ArrayList<ResumeDTO>(); 
	PreparedStatement pstmt=null;
	ResultSet rs=null; 
	StringBuffer sb=new StringBuffer();

	try { 
	sb.append("SELECT * FROM(");
	sb.append(" SELECT ROWNUM num, tb.* from(");
	sb.append(" SELECT resumeCode, title, created");
	sb.append(" FROM resume");
	sb.append(" ORDER BY created DESC)");		
	sb.append(" )tb WHERE rnum >=1");
	
	pstmt=conn.prepareStatement(sb.toString());
	rs=pstmt.executeQuery();
	
	while(rs.next()) {
	ResumeDTO dto=new ResumeDTO();
	dto.setResumeCode(rs.getInt("resumeCode"));
	dto.setTitle(rs.getString("title"));
	dto.setCreated(rs.getString("created"));
	list.add(dto);
	}
	} catch (Exception e) { 
		e.printStackTrace();
	} finally {
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
	return list;
	}
}
