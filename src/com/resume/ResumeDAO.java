package com.resume;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ResumeDAO {
	private Connection conn;
	
	public ResumeDAO() {
		conn = DBConn.getConnection();
	}
	
	//마이페이지용 이력서 읽어오기
	public List<ResumeDTO> readResume(String userEmail) {
		List<ResumeDTO> list=new ArrayList<ResumeDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			/*sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT r.resumeCode,title,userEmail,name,addr,gender,birth,created,");
			sb.append("                licenseCode,licenseName,license_publisher,license_date,");
			sb.append("                awardsCode,awardsName,awards_publisher,awards_date,");
			sb.append("                careerCode,gubun,copName,joinDate,resignDate,task,position,");
			sb.append("                educationCode,schoolName,region,major,entrance,graduate,graduate_status");
			sb.append("        FROM resume r ");
			sb.append("        JOIN license l ON r.resumecode = l.resumecode");
			sb.append("        JOIN awards a ON r.resumecode = a.resumecode");
			sb.append("        JOIN career c ON r.resumecode = c.resumecode");
			sb.append("        JOIN education e ON r.resumecode = e.resumecode");
			sb.append("        ORDER BY created DESC");
			sb.append("    )tb WHERE ROWNUM <= 5");
			sb.append(") WHERE rnum >=1 AND userEmail=?");*/
			
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT resumeCode,title,userEmail,name,addr,gender,birth,created");
			sb.append("        FROM resume");
			sb.append("        ORDER BY created DESC");
			sb.append("    )tb WHERE ROWNUM <= 5");
			sb.append(") WHERE rnum >=1 AND userEmail=?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, userEmail);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ResumeDTO dto = new ResumeDTO();
				dto.setResumeCode(rs.getInt("resumeCode"));
				dto.setTitle(rs.getString("title"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr"));
				dto.setGender(rs.getString("gender"));
				dto.setBirth(rs.getDate("birth").toString());
				dto.setCreated(rs.getDate("created").toString());
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (Exception e2) {
					
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
		
		
		return list;
	}
	
	
	
	
	

}
