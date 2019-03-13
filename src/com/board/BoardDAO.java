package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
				dto.setDepth(0);
				dto.setParent(0);
			} else if(mode.equalsIgnoreCase("reply")) {
				updateOrderNo(dto.getGroupNum(), dto.getOrderNum());
				
				dto.setDepth(dto.getDepth() + 1);
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
			pstmt.setInt(6, dto.getDepth());
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
	
	public void insertReply(FeedBack_ReplyDTO dto) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "INSERT INTO feedback_reply(replyNum, boardNum, email, content, answer) "
					+ "VALUES(feedback_reply_seq.NEXTVAL, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getAnswer());
			
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
	
	public int updateOrderNo(int groupNum, int orderNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "UPDATE feedback SET orderNo = orderNo + 1 WHERE groupNum = ? AND orderNo > ?";
			
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
					+ "FROM member_user mu " 
					+ "JOIN feedback fb " 
					+ "ON mu.userEmail = fb.userEmail " 
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
				dto.setDepth(rs.getInt("depth"));
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
	
	public int dataCountReply(int boardNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM feedback_reply WHERE boardNum = ? AND answer = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNum);
			
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
		
		return result;
	}
	
	public int dataCount(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			if(searchKey.equals("created")) {
        		searchValue = searchValue.replaceAll("-", "");
        		sql="SELECT NVL(COUNT(*), 0) FROM feedback fb JOIN member_user mu ON fb.userEmail = mu.userEmail WHERE TO_CHAR(created, 'YYYYMMDD') = ? ";
        	} else if(searchKey.equals("userName")) {
        		sql="SELECT NVL(COUNT(*), 0) FROM feedback fb JOIN member_user mu ON fb.userEmail = mu.userEmail WHERE INSTR(userName, ?) = 1 ";
        	} else {
        		sql="SELECT NVL(COUNT(*), 0) FROM feedback fb JOIN member_user mu ON fb.userEmail = mu.userEmail WHERE INSTR(" + searchKey + ", ?) >= 1 ";
        	}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			
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
				dto.setDepth(rs.getInt("depth"));
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
	
	public List<BoardDTO> listBoard(int start, int end, String searchKey, String searchValue) {
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
			if(searchKey.equals("created")) {
				searchValue = searchValue.replaceAll("-", "");
				sb.append("           WHERE TO_CHAR(created, 'YYYYMMDD') = ? ");
			} else if(searchKey.equals("userName")) {
				sb.append("           WHERE INSTR(userName, ?) = 1 ");
			} else {
				sb.append("           WHERE INSTR(" + searchKey + ", ?) >= 1 ");
			}
			sb.append("        ORDER BY groupNum DESC, orderNo ASC");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
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
	
	public List<FeedBack_ReplyDTO> listReply(int boardNum, int start, int end) {
		List<FeedBack_ReplyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {	
			sb.append("SELECT * FROM (");
			sb.append("		SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("				SELECT replyNum, boardNum, email, mu.userName, content, created");
			sb.append("				FROM feedback_reply fr");
			sb.append("				JOIN member_user mu");
			sb.append("				ON fr.email = mu.userEmail");
			sb.append("				WHERE fr.boardNum = ?  AND fr.answer = 0");
			sb.append("				ORDER BY fr.replyNum DESC");
			sb.append("		) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FeedBack_ReplyDTO dto = new FeedBack_ReplyDTO();
				
				dto.setReplyNum(rs.getInt("replyNum"));
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setEmail(rs.getString("email"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getDate("created").toString());
				
				list.add(dto);
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
		return list;
	}
	
	public BoardDTO preReadBoard(int groupNum, int orderNo, String searchKey, String searchValue) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			if(searchValue != null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT boardNum, subject  ");
    			sb.append("               FROM feedback fb");
    			sb.append("               JOIN member_user mu ON fb.userEmail = mu.userEmail");
    			if(searchKey.equals("created")) {
    				searchValue = searchValue.replaceAll("-", "");
    				sb.append("           WHERE (TO_CHAR(created, 'YYYYMMDD') = ? ) AND ");
    			} else if(searchKey.equals("userName")) {
    				sb.append("           WHERE (INSTR(userName, ?) = 1 ) AND ");
    			} else {
    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) AND ");
            	}
                sb.append("     (( groupNum = ? AND orderNo < ?) ");
                sb.append("         OR (groupNum > ? )) ");
                sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, groupNum);
                pstmt.setInt(3, orderNo);
                pstmt.setInt(4, groupNum);
			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("     SELECT boardNum, subject FROM feedback fb JOIN member_user mu ON fb.userEmail = mu.userEmail ");                
                sb.append("  WHERE (groupNum = ? AND orderNo < ?) ");
                sb.append("         OR (groupNum > ? ) ");
                sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, groupNum);
                pstmt.setInt(2, orderNo);
                pstmt.setInt(3, groupNum);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setSubject(rs.getString("subject"));
			}
		} catch (Exception e) {
			
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
	
	public BoardDTO nextReadBoard(int groupNum, int orderNo, String searchKey, String searchValue) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			if(searchValue != null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT boardNum, subject  ");
    			sb.append("               FROM feedback fb");
    			sb.append("               JOIN member_user mu ON fb.userEmail = mu.userEmail");
    			if(searchKey.equals("created")) {
    				searchValue = searchValue.replaceAll("-", "");
    				sb.append("           WHERE (TO_CHAR(created, 'YYYYMMDD') = ? ) AND ");
    			} else if(searchKey.equals("userName")) {
    				sb.append("           WHERE (INSTR(userName, ?) = 1 ) AND ");
    			} else {
    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) AND ");
            	}
                sb.append("     (( groupNum = ? AND orderNo > ?) ");
                sb.append("         OR (groupNum < ? )) ");
                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, groupNum);
                pstmt.setInt(3, orderNo);
                pstmt.setInt(4, groupNum);
			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("     SELECT boardNum, subject FROM feedback fb JOIN member_user mu ON fb.userEmail = mu.userEmail ");                
                sb.append("  WHERE (groupNum = ? AND orderNo > ?) ");
                sb.append("         OR (groupNum < ? ) ");
                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, groupNum);
                pstmt.setInt(2, orderNo);
                pstmt.setInt(3, groupNum);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setSubject(rs.getString("subject"));
			}
		} catch (Exception e) {
			
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
	
	public void updateHitCount(int boardNum) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "UPDATE feedback SET hitCount = hitCount + 1 WHERE boardNum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNum);
			
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
	
	public void updateBoard(BoardDTO dto, String userEmail) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "UPDATE feedback SET subject = ?, content = ? WHERE boardNum = ? AND userEmail = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getBoardNum());
			pstmt.setString(4, userEmail);
			
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
	
	public void deleteBoard(int boardNum) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "DELETE FROM feedback WHERE boardNum IN (SELECT boardNum FROM feedback START WITH  boardNum = ? CONNECT BY PRIOR boardNum = parent)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNum);
			
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
	
	public void deleteBoardReply(int boardNum) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "DELETE FROM feedback_reply WHERE boardNum = ? AND answer = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNum);
			
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
	
	public void deleteReply(int boardNum, int replyNum) {
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			sql = "DELETE FROM feedback_reply WHERE boardNum = ? AND replyNum = ? AND answer = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, replyNum);
			
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
}
