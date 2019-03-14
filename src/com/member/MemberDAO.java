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
	
	public void insertUser(UserDTO dto) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "INSERT INTO member(memberEmail, statusCode, levelCode, memberPwd) VALUES(?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserEmail());
			pstmt.setInt(2, dto.getStatusCode());
			pstmt.setInt(3, dto.getLevelCode());
			pstmt.setString(4, dto.getUserPwd());
			
			pstmt.executeUpdate();
			
			sql = null;
			
			pstmt.close();
			
			sql = "INSERT INTO member_user(userEmail, userName, postCode, address, detailAddress, extraAddress, birth, gender) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserEmail());
			pstmt.setString(2, dto.getUserName());
			pstmt.setString(3, dto.getPostCode());
			pstmt.setString(4, dto.getAddress());
			pstmt.setString(5, dto.getDetailAddress());
			pstmt.setString(6, dto.getExtraAddress());
			pstmt.setString(7, dto.getBirth());
			pstmt.setString(8, dto.getGender());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
	}
	
	public void insertCompany(CompaniesDTO dto) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "INSERT INTO member(memberEmail, statusCode, levelCode, memberPwd) VALUES(?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCompanyEmail());
			pstmt.setInt(2, dto.getStatusCode());
			pstmt.setInt(3, dto.getLevelCode());
			pstmt.setString(4, dto.getCompanyPwd());
			
			pstmt.executeUpdate();
			
			sql = null;
			
			pstmt.close();
			
			sql = "INSERT INTO company(companyEmail, businessLicenseNum, companyName, owner, establishmentDate, employees, sales, postCode, location, detailLocation, extraLocation, salary, introduction, homepage, saveFilename) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCompanyEmail());
			pstmt.setString(2, dto.getBusinessLicenseNum());
			pstmt.setString(3, dto.getCompanyName());
			pstmt.setString(4, dto.getOwner());
			pstmt.setString(5, dto.getEstablishmentDate());
			pstmt.setInt(6, dto.getEmployees());
			pstmt.setInt(7, dto.getSale());
			pstmt.setString(8, dto.getPostCode());
			pstmt.setString(9, dto.getLocation());
			pstmt.setString(10, dto.getDetailLocation());
			pstmt.setString(11, dto.getExtraLocation());
			pstmt.setInt(12, dto.getSalary());
			pstmt.setString(13, dto.getIntroduction());
			pstmt.setString(14, dto.getHomepage());
			pstmt.setString(15, dto.getSavefilename());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
	}
	
	public UserDTO readUser(String email){
		UserDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select levelCode, memberPwd, userName, statusCode, postCode, address, detailAddress, extraAddress, birth, gender "
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
				dto.setPostCode(rs.getString(5));
				dto.setAddress(rs.getString(6));
				dto.setDetailAddress(rs.getString(7));
				dto.setExtraAddress(rs.getString(8));
				dto.setBirth(rs.getDate(9).toString());
				dto.setGender(rs.getString(10));
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
		CompaniesDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select levelCode, memberPwd, companyName, statusCode, businessLicenseNum, companyName, owner, establishmentdate, employees, sales, postCode, location, detailLocation, extraLocation, salary, introduction, homepage, saveFileName "
					+ "from member m1 join company c "
					+ "on m1.memberEmail = c.companyEmail where memberEmail=?";
			System.out.println(email);
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
				dto.setBusinessLicenseNum(rs.getString(5));
				dto.setCompanyName(rs.getString(6));
				dto.setOwner(rs.getString(7));
				dto.setEstablishmentDate(rs.getDate(8).toString());
				dto.setEmployees(rs.getInt(9));
				dto.setSale(rs.getInt(10));
				dto.setPostCode(rs.getString(11));
				dto.setLocation(rs.getString(12));
				dto.setDetailLocation(rs.getString(13));
				dto.setExtraLocation(rs.getString(14));
				dto.setSalary(rs.getInt(15));
				dto.setIntroduction(rs.getString(16));
				dto.setHomepage(rs.getString(17));
				dto.setSavefilename(rs.getString(18));
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
	
	public UserDTO readUpd_user(String email) {
		UserDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("SELECT memberEmail, memberPwd, levelcode, userName, address, birth, gender");
			sb.append("	FROM member m");
			sb.append("	JOIN member_user mu");
			sb.append("		ON m.memberEmail = mu.userEmail");
			sb.append("	WHERE m.memberEmail = ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserDTO();
				dto.setUserEmail(rs.getString("memberEmail"));
				dto.setUserPwd(rs.getString("memberPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setAddress(rs.getString("address"));
				dto.setBirth(rs.getDate("birth").toString());
				dto.setGender(rs.getString("gender"));
				dto.setLevelCode(rs.getInt("levelCode"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
					
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
		
		return dto;
	}
	
	public void updateUserInfo(UserDTO dto) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "UPDATE member SET memberPwd = ? WHERE memberEmail = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserPwd());
			pstmt.setString(2, dto.getUserEmail());
			
			pstmt.executeUpdate();
			
			sql = null;
			
			pstmt.close();
			
			sql = "UPDATE member_user SET userName = ?, postCode = ?, address = ?, detailAddress = ?, extraAddress = ?, birth = ? WHERE userEmail = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserName());
			pstmt.setString(2, dto.getPostCode());
			pstmt.setString(3, dto.getAddress());
			pstmt.setString(4, dto.getDetailAddress());
			pstmt.setString(5, dto.getExtraAddress());
			pstmt.setString(6, dto.getBirth());
			pstmt.setString(7, dto.getUserEmail());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}	
	}
	
	public void updateCompanyInfo(CompaniesDTO dto) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "UPDATE member SET memberPwd = ? WHERE memberEmail = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCompanyPwd());
			pstmt.setString(2, dto.getCompanyEmail());
			
			pstmt.executeUpdate();
			
			sql = null;
			
			pstmt.close();
			
			sql = "UPDATE company SET "
					+ "businesslicensenum = ?, "
					+ "companyname = ?, "
					+ "owner = ?, "
					+ "employees = ?, "
					+ "sales = ?, "
					+ "postCode = ?, "
					+ "location = ?, "
					+ "detailLocation = ?, "
					+ "extraLocation = ?, "
					+ "salary = ?, "
					+ "homepage = ?, "
					+ "savefilename = ?, "
					+ "introduction = ? "
					+ "WHERE companyEmail = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getBusinessLicenseNum());
			pstmt.setString(2, dto.getCompanyName());
			pstmt.setString(3, dto.getOwner());
			pstmt.setInt(4, dto.getEmployees());
			pstmt.setInt(5, dto.getSale());
			pstmt.setString(6, dto.getPostCode());
			pstmt.setString(7, dto.getLocation());
			pstmt.setString(8, dto.getDetailLocation());
			pstmt.setString(9, dto.getExtraLocation());
			pstmt.setInt(10, dto.getSalary());
			pstmt.setString(11, dto.getHomepage());
			pstmt.setString(12, dto.getSavefilename());
			pstmt.setString(13, dto.getIntroduction());
			pstmt.setString(14, dto.getCompanyEmail());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}	
	}
	
	public void withdrawMember(String memberEmail, int levelCode) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql="UPDATE member SET statuscode=2 WHERE memberEmail=? AND levelCode=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memberEmail);
			pstmt.setInt(2, levelCode);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
		
	}
}
