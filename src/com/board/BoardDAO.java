package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class BoardDAO {
	private Connection conn;
	
	public BoardDAO() {
		conn = DBConn.getConnection();
	}
	
	public void insertBoard(BoardDTO dto, String mode) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int seq;
		
		try {
			sql = "SELECT feedbackNum_seq.NEXTVAL FROM dual";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			seq = 0;
			if(rs.next()) {
				seq = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
			rs = null;
			pstmt = null;
			
			dto.setBoardNum(seq);
			
			if(mode.equalsIgnoreCase("created")) {
				dto.setGroupNum(seq);
				dto.setOrderNum(0);
				dto.setDept(0);
				dto.setParent(0);
			} else if(mode.equalsIgnoreCase("reply")) {
				updateOrderNo(dto.getGroupNum(), dto.getOrderNum());
				
				dto.setDept(dto.getDept() + 1);
				dto.setOrderNum(dto.getOrderNum() + 1);
			}
			
			sql = "INSERT INTO feedback(boardNum, userEmail, subject, content, groupNum, depth, orderNo, parent) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setString(2, dto.getUserEmail());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getGroupNum());
			pstmt.setInt(6, dto.getDept());
			pstmt.setInt(7, dto.getOrderNum());
			pstmt.setInt(8, dto.getParent());
			
			pstmt.executeUpdate();
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
	}
	
	public int updateOrderNo(int groupNum, int orderNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "UPDATE board SET order = orderNo + 1 WHERE groupNum ? AND orderNo > ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, groupNum);
			pstmt.setInt(2, orderNo);
			
			result = pstmt.executeUpdate();
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
		
		return result;
	}
	
	public BoardDTO readBoard(int boardNum) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT boardNum, mu.userEmail, mu.userName, subject, content, groupNum, depth, orderNo, parent, created, hitCount " 
					+ "FROM member_user mu\n" 
					+ "JOIN feedback fb\n" 
					+ "ON mu.userEmail = fb.userEmail\n" 
					+ "WHERE boardNum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDept(rs.getInt("depth"));
				dto.setOrderNum(rs.getInt("orderNo"));
				dto.setParent(rs.getInt("parent"));
				dto.setCreated(rs.getDate("created").toString());
				dto.setHitCount(rs.getInt("hitCount"));
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
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
				
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM feedback";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					
				}
			}
		}
			
		
		return result;
	}
	
	public List<BoardDTO> listBoard(int start, int end) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT boardNum, b.userEmail, userName, subject, groupNum, orderNo, depth, hitCount, created");
			sb.append("        FROM feedback b");
			sb.append("        JOIN member_user mu"); 
			sb.append("        ON b.userEmail = mu.userEmail");
			sb.append("        ORDER BY groupNum DESC, orderNo ASC");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDept(rs.getInt("depth"));
				dto.setOrderNum(rs.getInt("orderNo"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getDate("created").toString());
				
				list.add(dto);
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
		
		return list;
	}
}
