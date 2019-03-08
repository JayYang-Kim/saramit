package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.util.DBConn;

public class FreeBoardDAO {
	private Connection conn;
	
	public FreeBoardDAO() {
		conn = DBConn.getConnection();
	}
	
	public void insertBoard(FreeBoardDTO dto, String name) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			sql = "insert into board(boardnum,useremail,subject,content,name) values(board_seq.nextval,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserEmail());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, name);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
	}

	public int dataCount(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try{
			if(searchKey.equals("") && searchKey.equals("")) {
				sql = "select nvl(count(*),0) from board";
				pstmt = conn.prepareStatement(sql);
			}else {
				if(searchKey.equals("name")) {
					sql="select nvl(count(*),0) from board where name=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, searchValue);
				}else if(searchKey.equals("all")) {
					sql="select nvl(count(*),0) from board where instr(subject,?)>=1 or instr(content,?)>=1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, searchValue);
					pstmt.setString(2, searchValue);
				}else {
					sql="select nvl(count(*),0) from board where instr("+searchKey+",?)>=1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, searchValue);
				}
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
			if(rs != null) { 
				try { 
					if(!rs.isClosed()){ 
						rs.close(); 
					}
				}catch (Exception e) { 
					// TODO: handle exception 
				} 
			}
		}
		return result;
	}

	public ArrayList<FreeBoardDTO> listBoard(int start, int end, String searchKey, String searchValue) {
		// TODO Auto-generated method stub
		ArrayList<FreeBoardDTO> list = new ArrayList<FreeBoardDTO>();
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		ResultSet rs = null;
		try{
			sb.append("select * from ( ");
			sb.append("select tb.*, rownum rnum from( ");
			if(searchKey.equals("") && searchValue.equals("")) { //검색값이 없는 경우
				sb.append("select useremail,subject,content,name,hitCount,boardNum, created from board order by created desc ");
				sb.append(")tb where rownum<="+end);
				sb.append(") where rnum >="+start);
				pstmt = conn.prepareStatement(sb.toString());
			}else { //검색 값이 있는 경우
				sb.append("select useremail,subject,content,name,hitCount,boardNum, created from board ");
				if(searchKey.equalsIgnoreCase("name")) {
					sb.append("where name=? order by created DESC");
					sb.append(")tb where rownum<="+end);
					sb.append(") where rnum >="+start);
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setString(1, searchValue);
				}else if(searchKey.equalsIgnoreCase("all")) {
					sb.append("where instr(content,?)>=1 or instr(subject,?)>=1 order by created DESC");
					sb.append(")tb where rownum<="+end);
					sb.append(") where rnum >="+start);
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setString(1, searchValue);
					pstmt.setString(2, searchValue);
				}else {
					sb.append("where instr("+searchKey+",?)>=1 order by created DESC");
					sb.append(")tb where rownum<="+end);
					sb.append(") where rnum >="+start);
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setString(1, searchValue);
				}	
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FreeBoardDTO dto = new FreeBoardDTO();
				dto.setUserEmail(rs.getString(1));
				dto.setSubject(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setName(rs.getString(4));
				dto.setHitCount(rs.getInt(5));
				dto.setBoardNum(rs.getInt(6));
				dto.setCreated(rs.getDate(7).toString());
				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
			if(rs != null) { 
				try { 
					if(!rs.isClosed()){ 
						rs.close(); 
					}
				}catch (Exception e) { 
					// TODO: handle exception 
				} 
			}
		}
		return list;
	}

	public FreeBoardDTO readBoard(int num) {
		// TODO Auto-generated method stub
		FreeBoardDTO dto = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try{
			plusHitCount(num);
			sql = "select useremail,subject,content,name,hitCount,boardNum,created from board where boardNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				dto = new FreeBoardDTO();
				dto.setUserEmail(rs.getString(1));
				dto.setSubject(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setName(rs.getString(4));
				dto.setHitCount(rs.getInt(5));
				dto.setBoardNum(rs.getInt(6));
				dto.setCreated(rs.getString(7));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
			if(rs != null) { 
				try { 
					if(!rs.isClosed()){ 
						rs.close(); 
					}
				}catch (Exception e) { 
					// TODO: handle exception 
				} 
			}
		}
		return dto;
	}

	private void plusHitCount(int num) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			sql = "update board set hitCount=hitCount+1 where boardNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
	}
	
	public FreeBoardDTO readNextBoard(int num,String searchKey, String searchValue) {
		// TODO Auto-generated method stub
		FreeBoardDTO dto = null;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		ResultSet rs = null;
		try{
			if(searchKey==null && searchValue==null) { //검색값이 없는 경우
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from board where boardNum<?");
				sb.append(" order by boardNum DESC)tb where rownum = 1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}else {
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from board where boardNum<?");
				if(searchKey.equalsIgnoreCase("name")) {
					sb.append("and name=? order by boardNum DESC ");
					sb.append(")tb where rownum = 1");
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, num);
					pstmt.setString(2, searchValue);
				}else if(searchKey.equalsIgnoreCase("all")) {
					sb.append("and (instr(content,?)>=1 or instr(subject,?)>=1) order by boardNum DESC ");
					sb.append(")tb where rownum = 1");
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, num);
					pstmt.setString(2, searchValue);
					pstmt.setString(3, searchValue);
				}else {
					sb.append("and instr("+searchKey+",?)>=1 order by boardNum DESC ");
					sb.append(")tb where rownum = 1");
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, num);
					pstmt.setString(2, searchValue);
				}	
				
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new FreeBoardDTO();
				dto.setBoardNum(rs.getInt(2));
				dto.setSubject(rs.getString(3));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
			if(rs != null) { 
				try { 
					if(!rs.isClosed()){ 
						rs.close(); 
					}
				}catch (Exception e) { 
					// TODO: handle exception 
				} 
			}
		}
		return dto;
	}
	
	public FreeBoardDTO readPrevBoard(int num,String searchKey, String searchValue) {
		// TODO Auto-generated method stub
		FreeBoardDTO dto = null;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		ResultSet rs = null;
		try{
			if(searchKey==null && searchValue==null) { //검색값이 없는 경우
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from board where boardNum>?");
				sb.append(" order by boardNum ASC)tb where rownum = 1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}else {
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from board where boardNum>?");
				if(searchKey.equalsIgnoreCase("name")) {
					sb.append("and name=? order by boardNum ASC ");
					sb.append(")tb where rownum = 1");
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, num);
					pstmt.setString(2, searchValue);
				}else if(searchKey.equalsIgnoreCase("all")) {
					sb.append("and (instr(content,?)>=1 or instr(subject,?)>=1) order by boardNum ASC ");
					sb.append(")tb where rownum = 1");
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, num);
					pstmt.setString(2, searchValue);
					pstmt.setString(3, searchValue);
				}else {
					sb.append("and instr("+searchKey+",?)>=1 order by boardNum ASC ");
					sb.append(")tb where rownum = 1");
					pstmt = conn.prepareStatement(sb.toString());
					pstmt.setInt(1, num);
					pstmt.setString(2, searchValue);
				}	
				
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new FreeBoardDTO();
				dto.setBoardNum(rs.getInt(2));
				dto.setSubject(rs.getString(3));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
			if(rs != null) { 
				try { 
					if(!rs.isClosed()){ 
						rs.close(); 
					}
				}catch (Exception e) { 
					// TODO: handle exception 
				} 
			}
		}
		return dto;
	}
	
	public void removeBoard(int num) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			sql = "delete from board where boardNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
	}

	public void updateBoard(FreeBoardDTO dto) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			sql = "update board set subject=?, content=? where boardNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setInt(3, dto.getBoardNum());
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
	}
}
