package com.pass;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class Pass_boardDAO {
	private Connection conn = DBConn.getConnection();
	
	//게시글 추가
	public int insertBoard(Pass_BoardDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("INSERT INTO pass_resume(num, userEmail, title, companyName, field, content, gubun) ");
			sb.append(" VALUES (pass_resume_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getUserEmail());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getCompanyName());
			pstmt.setString(4, dto.getField());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getGubun());
			
			result=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					
				}
		}
		
		return result;
	}
	
	//데이터개수
	public int dataCount() {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM pass_resume";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.toString());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {	
				}
			}
		}
		return result;
	}
	
	//검색했을때 데이터 개수
	public int dataCount(String searchKey, String searchValue) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		
		try {
			if(searchKey.equals("companyName")) {
				sql="SELECT NVL(COUNT(*), 0) FROM pass_resume WHERE INSTR(companyName, ?) >= 1 ";
			}else if(searchKey.equals("field")) {
				sql="SELECT NVL(COUNT(*), 0) FROM pass_resume WHERE INSTR(field, ?) >= 1 ";
			}
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
				result=rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.toString());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return result;
	}
	
	
	//게시물 리스트
	public List<Pass_BoardDTO> listBoard(int start, int end){
		List<Pass_BoardDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, p.userEmail, title, companyName, field, content, gubun, created, hitCount");
			sb.append("        FROM pass_resume p");
			sb.append("        JOIN member_user m ON p.userEmail=m.useremail");
			sb.append("        ORDER BY created DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				Pass_BoardDTO dto = new Pass_BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setTitle(rs.getString("title"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setField(rs.getString("field"));
				dto.setContent(rs.getString("content"));
				dto.setGubun(rs.getString("gubun"));
				dto.setCreated(rs.getDate("created").toString());
				dto.setHitCount(rs.getInt("hitCount"));
				
				list.add(dto);
			}
		
		} catch (Exception e) {
			System.out.println(e.toString());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					
				}
			}
		}
		return list;
	}
	
	//검색했을때 리스트
	public List<Pass_BoardDTO> listBoard(int start, int end, String searchKey, String searchValue) {
		List<Pass_BoardDTO> list=new ArrayList<Pass_BoardDTO>();
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb= new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, p.userEmail, title, companyName, field, content, gubun, created, hitCount");
			sb.append("        FROM pass_resume p");
			sb.append("        JOIN member_user m ON p.userEmail=m.useremail");
			if(searchKey.equals("companyName")) {
				sb.append("		WHERE INSTR(companyName, ? ) >= 1");
			} else if(searchKey.equals("field")) {
				sb.append("		WHERE INSTR(field, ? ) >= 1");
			}
			sb.append("        ORDER BY created DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");
			
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				Pass_BoardDTO dto = new Pass_BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setTitle(rs.getString("title"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setField(rs.getString("field"));
				dto.setContent(rs.getString("content"));
				dto.setGubun(rs.getString("gubun"));
				dto.setCreated(rs.getDate("created").toString());
				dto.setHitCount(rs.getInt("hitCount"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return list;
	}
	
	public int updateHitCount(int num) {
		int result=0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql= "UPDATE pass_resume SET hitCount=hitCount+1 WHERE num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return result;
	}
	
	public Pass_BoardDTO readBoard(int num) {
		Pass_BoardDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT num, p.userEmail, title, companyName, field, content, gubun, created, hitCount");
			sb.append("    FROM pass_resume p");
			sb.append("    JOIN member_user m ON p.userEmail=m.useremail");
			sb.append("    WHERE num=?");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new Pass_BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setTitle(rs.getString("title"));
				dto.setCompanyName(rs.getString("companyName"));
				dto.setField(rs.getString("field"));
				dto.setContent(rs.getString("content"));
				dto.setGubun(rs.getString("gubun"));
				dto.setCreated(rs.getDate("created").toString());
				dto.setHitCount(rs.getInt("hitCount"));
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return dto;
	}
	
	
}
