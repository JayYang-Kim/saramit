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
	
	//留덉씠�럹�씠吏��슜 �씠�젰�꽌 �씫�뼱�삤湲�
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
	
	
	
	
	
	public List<ResumeDTO> listResume(int start,int end) { //�씠�젰�꽌 由ъ뒪�듃
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
	
	public int insertResume(ResumeDTO dto) { //�씠�젰�꽌 �옉�꽦-媛쒖씤�젙蹂�
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

	public void insertLicense(LicenseDTO dto, int num) { //�씠�젰�꽌 �옉�꽦-�옄寃⑹궗�빆
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

	public void insertAwards(AwardsDTO dto,int num) { //�씠�젰�꽌 �옉�꽦-�닔�긽寃쎈젰
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

	public void insertEducation(EducationDTO dto, int num) { ////�씠�젰�꽌 �옉�꽦-�븰�젰
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

	public void insertCareer(CareerDTO dto, int num) { //�씠�젰�꽌 �옉�꽦-寃쎈젰�궗�빆.
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

	public int totData() { //�옉�꽦�븳 �씠�젰�꽌 �닽�옄 �꽭湲�
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="select nvl(count(*),0) from resume ";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=rs.getInt(1); //�뿬湲곗꽌 1�� nvl(count(*),0) �쑜�븿. �뜲�씠�꽣以� 留� 泥섏쓬嫄곗엫.
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
	
	public ResumeDTO readResume(int resumeCode) {//�씠�젰�꽌 肄붾뱶濡� �씠�젰�꽌 �븯�굹 �씫�뼱�삤湲�
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
	
	public EducationDTO readEducation(int resumeCode) {//�씠�젰�꽌 肄붾뱶濡� �씠�젰�꽌 �븯�굹 �씫�뼱�삤湲�
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
				dto.setEntrance(rs.getDate(5).toString());
				dto.setGraduate(rs.getDate(6).toString());
				dto.setGraduate_status(rs.getString(7));
				dto.setGubun(rs.getInt(8));
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
	
	public List<AwardsDTO> readAwards(int resumeCode) {//�씠�젰�꽌 肄붾뱶濡� �씠�젰�꽌 �븯�굹 �씫�뼱�삤湲�
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
				dto.setAwards_date(rs.getDate(3).toString());
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
				dto.setLicense_date(rs.getDate(3).toString());
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
				dto.setJoinDate(rs.getDate(4).toString());
				dto.setResignDate(rs.getDate(5).toString());
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

	public LicenseDTO insertLicense(int resumeCode, String licenseName, String licensePublisher, String licenseDate) {
		// TODO Auto-generated method stub
		LicenseDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "select license_seq.nextval from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int code = rs.getInt(1);
				pstmt.close();
				sql = "insert into license(LICENSECODE,RESUMECODE,LICENSENAME,LICENSE_DATE,LICENSE_PUBLISHER) values(?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, code);
				pstmt.setInt(2, resumeCode);
				pstmt.setString(3, licenseName);
				pstmt.setString(4, licenseDate);
				pstmt.setString(5, licensePublisher);
				pstmt.executeUpdate();
				pstmt.close();
				sql = "select LICENSECODE,RESUMECODE,LICENSENAME,LICENSE_DATE,LICENSE_PUBLISHER from license where licensecode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, code);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new LicenseDTO();
					dto.setLicenseCode(rs.getInt(1));
					dto.setLicense_name(rs.getString(3));
					dto.setLicense_date(rs.getDate(4).toString());
					dto.setLicense_publisher(rs.getString(5));
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return dto;
	}

	public AwardsDTO insertAwards(int resumeCode, String awardsName, String awardsPublisher, String awardsDate) {
		// TODO Auto-generated method stub
		AwardsDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "select awards_seq.nextval from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int code = rs.getInt(1);
				pstmt.close();
				sql = "insert into awards(AWARDSCODE,RESUMECODE,AWARDSNAME,AWARDS_DATE,AWARDS_PUBLISHER) values(?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, code);
				pstmt.setInt(2, resumeCode);
				pstmt.setString(3, awardsName);
				pstmt.setString(4, awardsDate);
				pstmt.setString(5, awardsPublisher);
				pstmt.executeUpdate();
				pstmt.close();
				sql = "select AWARDSCODE,RESUMECODE,AWARDSNAME,AWARDS_DATE,AWARDS_PUBLISHER from awards where AWARDSCODE=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, code);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new AwardsDTO();
					dto.setAwardsCode(rs.getInt(1));
					dto.setAwardsName(rs.getString(3));
					dto.setAwards_date(rs.getDate(4).toString());
					dto.setAwards_publisher(rs.getString(5));
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return dto;
	}

	public EducationDTO insertEducation(int resumeCode, int gubun, String schoolName, int region, String major,
		String graduate_status, String entrance, String graduate) {
		EducationDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
				sql = "update education set SCHOOLNAME=?,REGION=?,MAJOR=?,ENTRANCE=?,GRADUATE=?,GRADUATE_STATUS=?,GUBUN=? where resumecode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, schoolName);
				pstmt.setInt(2, region);
				pstmt.setString(3, major);
				pstmt.setString(4, entrance);
				pstmt.setString(5, graduate);
				pstmt.setString(6, graduate_status);
				pstmt.setInt(7, gubun);
				pstmt.setInt(8, resumeCode);
				pstmt.executeUpdate();
				pstmt.close();
				sql = "select EDUCATIONCODE,RESUMECODE,SCHOOLNAME,REGION,MAJOR,ENTRANCE,GRADUATE,GRADUATE_STATUS,GUBUN from education where resumeCode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, resumeCode);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new EducationDTO();
					dto.setEducationCode(rs.getInt(1));
					dto.setSchoolName(rs.getString(3));
					dto.setRegion(rs.getInt(4));
					dto.setMajor(rs.getString(5));
					dto.setEntrance(rs.getDate(6).toString());
					dto.setGraduate(rs.getDate(7).toString());
					dto.setGraduate_status(rs.getString(8));
					dto.setGubun(rs.getInt(9));
				}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return dto;
	}

	public ResumeDTO updateResume(int resumeCode, String addr, String title) {
		ResumeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
				sql = "update resume set addr=?, title=? where resumeCode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, addr);
				pstmt.setString(2, title);
				pstmt.setInt(3, resumeCode);
				pstmt.executeUpdate();
				pstmt.close();
				sql = "select addr, title from resume where resumeCode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, resumeCode);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new ResumeDTO();
					dto.setAddr(rs.getString(1));
					dto.setTitle(rs.getString(2));
				}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return dto;
	}

	public CareerDTO insertCareer(int resumeCode, String copName, String gubun2, String position, String task,
			String carrerjoinDate, String carrerresignDate) {
		CareerDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "select career_seq.nextval from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int code = rs.getInt(1);
				pstmt.close();
				sql = "insert into career(CAREERCODE,RESUMECODE,GUBUN,COPNAME,JOINDATE,RESIGNDATE,TASK,POSITION) values(?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, code);
				pstmt.setInt(2, resumeCode);
				pstmt.setString(3, gubun2);
				pstmt.setString(4, copName);
				pstmt.setString(5, carrerjoinDate);
				pstmt.setString(6, carrerresignDate);
				pstmt.setString(7, task);
				pstmt.setString(8, position);
				pstmt.executeUpdate();
				pstmt.close();
				sql = "select CAREERCODE,RESUMECODE,GUBUN,COPNAME,JOINDATE,RESIGNDATE,TASK,POSITION from career where careercode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, code);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new CareerDTO();
					dto.setCareerCode(rs.getInt(1));
					dto.setGubun(rs.getString(3));
					dto.setCopName(rs.getString(4));
					dto.setJoinDate(rs.getDate(5).toString());
					dto.setResignDate(rs.getDate(6).toString());
					dto.setTask(rs.getString(7));
					dto.setPosition(rs.getString(8));
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return dto;
	}

	public boolean removeLicenseCode(int licenseCode) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		boolean flag = true;
		try {
			sql = "delete from license where licenseCode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, licenseCode);
			pstmt.executeQuery();
		}catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return flag;
	}

	public boolean removeAwards(int awardsCode) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		boolean flag = true;
		try {
			sql = "delete from awards where awardsCode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, awardsCode);
			pstmt.executeQuery();
		}catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return flag;
	}

	public boolean removeCareer(int careerCode) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		boolean flag = true;
		try {
			sql = "delete from career where careerCode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, careerCode);
			pstmt.executeQuery();
		}catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}finally {
			if(pstmt!=null) {
				try {
					if(!pstmt.isClosed()) {
						pstmt.close();
					}
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return flag;
	}
}
