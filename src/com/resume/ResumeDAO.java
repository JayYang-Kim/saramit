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
	
	
	
	
	
	public List<ResumeDTO> listResume(int start,int end) { //이력서 리스트
		List<ResumeDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("select * from(");
			sb.append("select tb.*,rownum rnum from(");
			sb.append("SELECT userEmail, resumeCode, title, created FROM resume ORDER BY created DESC");
			sb.append(")tb where rownum<="+end);
			sb.append(") where rnum>="+start);

			pstmt = conn.prepareStatement(sb.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ResumeDTO dto = new ResumeDTO();
				dto.setUserEmail(rs.getString(1));
				dto.setResumeCode(rs.getInt(2));
				dto.setTitle(rs.getString(3));
				dto.setCreated(rs.getDate(4).toString());
				list.add(dto);
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
		
		
		return list;
	}
	
	public int insertResume(ResumeDTO dto) { //이력서 작성-개인정보
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
			pstmt.close();
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
		
		return resumeNum;
	}

	public void insertLicense(LicenseDTO dto, int num) { //이력서 작성-자격사항
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
		} finally {
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
	}

	public void insertAwards(AwardsDTO dto,int num) { //이력서 작성-수상경력
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

	public void insertEducation(EducationDTO dto, int num) { ////이력서 작성-학력
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO education(educationCode,resumeCode,schoolName,region,major,entrance,graduate,graduate_status,gubun) VALUES(education_seq.nextval,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getSchoolName());
			pstmt.setInt(3, dto.getRegion());
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

	public void insertCareer(CareerDTO dto, int num) { //이력서 작성-경력사항.
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
		} finally {
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					
				}
			}
		}
	}

	public int totData() { //작성한 이력서 숫자 세기
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="select nvl(count(*),0) from resume ";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=rs.getInt(1); //여기서 1은 nvl(count(*),0) 뜻함. 데이터중 맨 처음거임.
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
	
	public ResumeDTO readResume(int resumeCode) {//이력서 코드로 이력서 하나 읽어오기
		ResumeDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT name, birth, gender, addr, title FROM resume WHERE resumeCode=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, resumeCode);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ResumeDTO();
				dto.setName(rs.getString(1));
				dto.setBirth(rs.getDate(2).toString());
				dto.setGender(rs.getString(3));
				dto.setAddr(rs.getString(4));
				dto.setTitle(rs.getString(5));
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
	public EducationDTO readEducation(int resumeCode) {//이력서 코드로 이력서 하나 읽어오기
		EducationDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT EducationCode, SchoolName, Region, Major, Entrance, Graduate, Graduate_Status, Gubun FROM Education WHERE ResumeCode=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, resumeCode);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new EducationDTO();
				dto.setEducationCode(rs.getInt(1));
				dto.setSchoolName(rs.getString(2));
				dto.setRegion(rs.getInt(3));
				dto.setMajor(rs.getString(4));
				dto.setEntrance(rs.getString(5));
				dto.setGraduate(rs.getString(6));
				dto.setGraduate_status(rs.getString(7));
				dto.setGubun(rs.getString(8));
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
	
	public List<AwardsDTO> readAwards(int resumeCode) {//이력서 코드로 이력서 하나 읽어오기
		List<AwardsDTO> list = new ArrayList<AwardsDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT awardscode, awardsname, awards_date, awards_publisher from awards WHERE ResumeCode=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, resumeCode);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				AwardsDTO dto = new AwardsDTO();
				dto.setAwardsCode(rs.getInt(1));
				dto.setAwardsName(rs.getString(2));
				dto.setAwards_date(rs.getString(3));
				dto.setAwards_publisher(rs.getString(4));
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

	public List<LicenseDTO> readLicense(int resumeCode) {
		List<LicenseDTO> list = new ArrayList<LicenseDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT licensecode, licensename,license_date,license_publisher from license where resumecode=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, resumeCode);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				LicenseDTO dto=new LicenseDTO();
				dto.setLicenseCode(rs.getInt(1));
				dto.setLicense_name(rs.getString(2));
				dto.setLicense_date(rs.getString(3));
				dto.setLicense_publisher(rs.getString(4));
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

	public List<CareerDTO> readCareer(int resumeCode) {
		List<CareerDTO> list = new ArrayList<CareerDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT careercode,gubun,copname,joindate,resigndate,task,position from career WHERE ResumeCode=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, resumeCode);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CareerDTO dto = new CareerDTO();
				dto.setCareerCode(rs.getInt(1));
				dto.setGubun(rs.getString(2));
				dto.setCopName(rs.getString(3));
				dto.setJoinDate(rs.getString(4));
				dto.setResignDate(rs.getString(5));
				dto.setTask(rs.getString(6));
				dto.setPosition(rs.getString(7));
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
