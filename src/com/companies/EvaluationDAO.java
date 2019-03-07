package com.companies;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class EvaluationDAO {
	private Connection conn;
	
	public EvaluationDAO() {
		conn = DBConn.getConnection();
	}
	
	// 기업평가 등록
	public int insertReview(EvaluationDTO dto,String mode) {
		int result=0;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("insert into cop_evaluation(boardNum,userEmail,companyEmail,star,content1,content2,content3,content4) ");
			sb.append(" values (cop_evaluation_seq.nextval,?,?,?,?,?,?,?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getUserEmail());
			pstmt.setString(2, dto.getCompanyEmail());
			pstmt.setInt(3, dto.getStar());
			pstmt.setString(4, dto.getContent1());
			pstmt.setString(5, dto.getContent2());
			pstmt.setString(6, dto.getContent3());
			pstmt.setString(7, dto.getContent4());
			
			result=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
		}
		
		return result;
	}
	
	public EvaluationDTO readReview(int boardNum) {
		EvaluationDTO dto = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("select c.companyname,e.boardNum,star,content1,content2,content3,content4 ");
			sb.append("        from cop_evaluation e ");
			sb.append("        join company c on e.companyemail=c.companyemail ");
			sb.append("where boardNum=?");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, boardNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new EvaluationDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setCop_name(rs.getString("companyname"));
				dto.setStar(rs.getInt("star"));
				dto.setContent1(rs.getString("content1"));
				dto.setContent2(rs.getString("content2"));
				dto.setContent3(rs.getString("content3"));
				dto.setContent4(rs.getString("content4"));
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
	
	public List<EvaluationDTO> listReview(int start, int end) {
		List<EvaluationDTO> list = new ArrayList<EvaluationDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("select * from ( ");
			sb.append("    select rownum rnum, tb.* from ( ");
			sb.append("        select c.companyname,e.boardNum,to_char(e.created,'yyyymmdd') created ");
			sb.append("        from cop_evaluation e");
			sb.append("		   join company c on c.companyemail=e.companyemail ");
			sb.append("        order by boardNum desc ");
			sb.append("    ) tb where rownum <= ?");
			sb.append(") where rnum >= ?");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				EvaluationDTO dto = new EvaluationDTO();
				dto.setCop_name(rs.getString("companyname"));
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
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
	
	
	// 검색!
	public List<EvaluationDTO> listReview(int start, int end, String searchKey, String searchValue) {
		List<EvaluationDTO> list = new ArrayList<EvaluationDTO>();
		
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("select * from ( ");
			sb.append("    select rownum rnum, tb.* from ( ");
			sb.append("        select c.companyname,e.boardNum,to_char(e.created,'yyyymmdd') created ");
			sb.append("        from cop_evaluation e");
			sb.append("        join company c on c.companyemail=e.companyemail ");
			
			if(searchKey.equals("cop")) {
				searchValue=searchValue.replaceAll(" ", "");
				sb.append("        where instr(companyname,?)>=1 ");
			} else if(searchKey.equals("created")) {
				searchValue=searchValue.replaceAll("-", "");
				sb.append("        where to_char(e.created,'yyyymmdd') = ?");
			} else {
				sb.append("        where instr(" + searchKey + ", ? ) >= 1");
			}
	
			sb.append("        order by boardNum desc ");
			sb.append("    ) tb where rownum <= ?");
			sb.append(") where rnum >= ?");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				EvaluationDTO dto = new EvaluationDTO();
				
				dto.setCop_name(rs.getString("companyname"));
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setCreated(rs.getString("created"));
				
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
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
	}
	
	
	public int dataCount() {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql;
		
		try {
		
			sql="select nvl(count(*),0) from cop_evaluation ";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
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
		
		return result; 
	}
	
	public int dataCount(String searchKey, String searchValue) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			
			
			if(searchKey.equals("created")) {
				searchValue=searchValue.replaceAll("-", "");
				sb.append("select nvl(count(*),0) from cop_evaluation");
				sb.append(" where to_char(created, 'YYYYMMDD') = ? ");
			} else if(searchKey.equals("cop")) {
				searchValue=searchValue.replaceAll(" ", "");
				sb.append("select nvl(count(*),0) from cop_evaluation e ");
				sb.append("join company c on c.companyemail=e.companyemail ");
				sb.append("where instr(c.companyname,?)>=1 ");
			} else {
				sb.append("select nvl(count(*),0) from cop_evaluation");
				sb.append(" where instr(" + searchKey + ", ? ) >= 1");
			}
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
				result=rs.getInt(1);
			
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
		
		return result;
	}
	
	public String searchCoName(String companyEmail) {
		PreparedStatement pstmt=null;
		String sql;
		String co_name=null;
		
		try {
			sql="select companyName from company c join cop_evaluation e on e.companyemail=c.companyemail where e.companyemail= ? ";
			pstmt=conn.prepareStatement(sql);
		
			pstmt.setString(1, companyEmail);
			pstmt.executeQuery();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		return co_name;
	}
	
}
