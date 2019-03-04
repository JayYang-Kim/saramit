package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.companies.CompaniesDTO;
import com.util.DBConn;

public class MemberDAO {
	private Connection conn;
	
	public MemberDAO() {
		conn = DBConn.getConnection();
	}
	
	public UserDTO readUser(String email){
		UserDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select levelCode, memberPwd, userName "
					+ "from member m1 join member_user m2 "
					+ "on m1.memberEmail=m2.userEmail where memberEmail=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserDTO();
				dto.setUserEmail(email);
				dto.setLevelCode(rs.getInt(1));
				dto.setUserPwd(rs.getString(2));
				dto.setUserName(rs.getString(3));
				dto.setStatusCode(rs.getInt(4));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					if(!rs.isClosed()) {
						rs.close();
					}
				}catch(Exception e) {
				}
			}
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch(Exception e) {
				}
			}
		}
		return dto;
	}

	public CompaniesDTO readCompany(String email) {
		// TODO Auto-generated method stub
		CompaniesDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select levelCode, memberPwd, companyName, statuscode from member m1 join company c on m1.memberEmail = c.companyEmail where memberEmail=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new CompaniesDTO();
				dto.setCompanyEmail(email);
				dto.setLevelCode(rs.getInt(1));
				dto.setCompanyPwd(rs.getString(2));
				dto.setCompanyName(rs.getString(3));
				dto.setStatusCode(rs.getInt(4));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					if(!rs.isClosed()) {
						rs.close();
					}
				}catch(Exception e) {
				}
			}
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch(Exception e) {
				}
			}
		}
		return dto;
	}
}
