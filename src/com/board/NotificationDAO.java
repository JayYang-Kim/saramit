package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.util.DBConn;

public class NotificationDAO {
	private Connection conn;
	
	public NotificationDAO() {
		conn = DBConn.getConnection();
	}
	
	public void insertNotification(NotificationDTO dto) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			if(dto.getOriginalFileName()==null) {
				sql = "insert into notification(boardnum,subject,content,email,name) values(notification_seq.nextval,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getEmail());
				pstmt.setString(4, dto.getName());
				pstmt.executeUpdate();
			}else {
				sql = "insert into notification(boardnum,subject,content,email,originalfilename,savefilename,filesize,name) values(notification_seq.nextval,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getEmail());
				pstmt.setString(4, dto.getOriginalFileName());
				pstmt.setString(5, dto.getSaveFileName());
				pstmt.setLong(6, dto.getFileSize());
				pstmt.setString(7, dto.getName());
				pstmt.executeUpdate();
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
		}
	}

	public int dataCount(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try{
			if(searchKey.equals("") && searchKey.equals("")) {
				sql = "select nvl(count(*),0) from notification";
				pstmt = conn.prepareStatement(sql);
			}else {
				if(searchKey.equals("name")) {
					sql="select nvl(count(*),0) from notification where name=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, searchValue);
				}else if(searchKey.equals("all")) {
					sql="select nvl(count(*),0) from notification where instr(subject,?)>=1 or instr(content,?)>=1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, searchValue);
					pstmt.setString(2, searchValue);
				}else {
					sql="select nvl(count(*),0) from notification where instr("+searchKey+",?)>=1";
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

	public ArrayList<NotificationDTO> listNotification(int start, int end, String searchKey, String searchValue) {
		// TODO Auto-generated method stub
		ArrayList<NotificationDTO> list = new ArrayList<NotificationDTO>();
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		ResultSet rs = null;
		try{
			sb.append("select * from ( ");
			sb.append("select tb.*, rownum rnum from( ");
			if(searchKey.equals("") && searchValue.equals("")) { //검색값이 없는 경우
				sb.append("select boardnum,subject,content,email,hitCount,created,savefilename,name from notification order by created desc ");
				sb.append(")tb where rownum<="+end);
				sb.append(") where rnum >="+start);
				pstmt = conn.prepareStatement(sb.toString());
				
			}else { //검색 값이 있는 경우
				sb.append("select boardnum,subject,content,email,hitCount,created,savefilename,name from notification ");
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
				NotificationDTO dto = new NotificationDTO();
				dto.setBoardNum(rs.getInt(1));
				dto.setSubject(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setEmail(rs.getString(4));
				dto.setHitCount(rs.getInt(5));
				dto.setCreated(rs.getString(6));
				dto.setSaveFileName(rs.getString(7));
				dto.setName(rs.getString(8));
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

	public NotificationDTO readNotification(int boardNum) {
		// TODO Auto-generated method stub
		NotificationDTO dto = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		try{
			sql = "select boardnum,subject,content,email,hitCount,created,savefilename,name,originalfilename,filesize from notification where boardNum=? order by created desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,boardNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new NotificationDTO();
				dto.setBoardNum(rs.getInt(1));
				dto.setSubject(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setEmail(rs.getString(4));
				dto.setHitCount(rs.getInt(5));
				dto.setCreated(rs.getString(6));
				dto.setSaveFileName(rs.getString(7));
				dto.setName(rs.getString(8));
				dto.setOriginalFileName(rs.getString(9));
				dto.setFileSize(rs.getLong(10));
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

	public void plusHitCount(int num) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			sql = "update notification set hitCount=hitCount+1 where boardNum=?";
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
	
	public NotificationDTO readNextNotification(int num,String searchKey, String searchValue) {
		// TODO Auto-generated method stub
		NotificationDTO dto = null;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		ResultSet rs = null;
		try{
			if(searchKey==null && searchValue==null) { //검색값이 없는 경우
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from notification where boardNum<?");
				sb.append(" order by boardNum DESC)tb where rownum = 1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}else {
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from notification where boardNum<?");
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
				dto = new NotificationDTO();
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
	
	public NotificationDTO readPrevNotification(int num,String searchKey, String searchValue) {
		// TODO Auto-generated method stub
		NotificationDTO dto = null;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		ResultSet rs = null;
		try{
			if(searchKey==null && searchValue==null) { //검색값이 없는 경우
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from notification where boardNum>?");
				sb.append(" order by boardNum ASC)tb where rownum = 1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}else {
				sb.append("select rownum, tb.* from(");
				sb.append("select boardNum,subject from notification where boardNum>?");
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
				dto = new NotificationDTO();
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
	
	public void removeNotification(int num) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			sql = "delete from notification where boardNum=?";
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

	public void updateNotification(NotificationDTO dto) {
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			sql = "update notification set subject=?, content=?,saveFileName=?,originalFileName=?,filesize=?  where boardNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setString(3, dto.getSaveFileName());
			pstmt.setString(4, dto.getOriginalFileName());
			pstmt.setLong(5, dto.getFileSize());
			pstmt.setInt(6, dto.getBoardNum());
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
