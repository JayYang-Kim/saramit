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
	
	public int insertResume(ResumeDTO dto) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int resumeNum = -1;
		try {
			sql = "select resume_seq.nextval from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				resumeNum = rs.getInt(1);
			}
			sql = "INSERT INTO resume(resumeCode,name,addr,gender,birth,title,userEmail) VALUES(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, resumeNum);
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getAddr());
			pstmt.setString(4, dto.getGender());
			pstmt.setString(5, dto.getBirth());
			pstmt.setString(6, dto.getTitle());
			pstmt.setString(7, dto.getUserEmail());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resumeNum;
	}

	public void insertLicense(LicenseDTO dto, int num) {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO license(licenseCode,resumeCode,licenseName,license_Date,license_Publisher) VALUES(license_seq.nextval,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getLicense_name());
			pstmt.setString(3, dto.getLicense_date());
			pstmt.setString(4, dto.getLicense_publisher());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insertAwards(AwardsDTO dto,int num) {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO awards(awardsCode,resumeCode,awardsName,awards_date,awards_publisher) VALUES(awards_seq.nextval,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getAwardsName());
			pstmt.setString(3, dto.getAwards_date());
			pstmt.setString(4, dto.getAwards_publisher());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insertEducation(EducationDTO dto, int num) {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO education(educationCode,resumeCode,schoolName,region,major,entrance,graduate,graduate_status,gubun) VALUES(education_seq.nextval,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getSchoolName());
			pstmt.setString(3, dto.getRegion());
			pstmt.setString(4, dto.getMajor());
			pstmt.setString(5, dto.getEntrance());
			pstmt.setString(6, dto.getGraduate());
			pstmt.setString(7, dto.getGraduate_status());
			pstmt.setInt(8, dto.getEducationCode());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insertCareer(CareerDTO dto, int num) {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO career(careerCode,resumeCode,gubun,copName,joinDate,resignDate,task,position) VALUES(career_seq.nextval,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getGubun());
			pstmt.setString(3, dto.getCopName());
			pstmt.setString(4, dto.getJoinDate());
			pstmt.setString(5, dto.getResignDate());
			pstmt.setString(6, dto.getTask());
			pstmt.setString(7, dto.getPosition());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
