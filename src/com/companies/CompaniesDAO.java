package com.companies;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class CompaniesDAO {
	private Connection conn;

	public CompaniesDAO() {
		conn = DBConn.getConnection();
	}

	public int totData(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select nvl(count(*),0) from member m join company c on m.memberEmail = c.companyEmail";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					if (!rs.isClosed()) {
						rs.close();
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			if (pstmt != null) {
				try {
					if (!pstmt.isClosed()) {
						pstmt.close();
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		return result;
	}

	public List<CompaniesDTO> listCompanies(int start, int end, String searchKey, String searchValue) {
		List<CompaniesDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			if (searchValue == null) {
				sb.append("select * from ( ");
				sb.append("select tb.*, rownum rnum from ( ");
				sb.append("select memberemail, statuscode, levelcode, ");
				sb.append("c.businesslicensenum, c.companyname, c.owner, ");
				sb.append("c.establishmentdate, c.employees, c.sales, c.location, ");
				sb.append("c.salary, c.introduction, c.homepage, c.savefilename, ");
				sb.append("c.originalfilename, c.filesize from member m join company c on m.memberemail = c.companyemail ");
				sb.append(")tb where rownum <=" + end);
				sb.append(" ) where rnum >=" + start);
				pstmt = conn.prepareStatement(sb.toString());
			} else {
				sb.append("select * from ( ");
				sb.append("select tb.*, rownum rnum from ( ");
				sb.append("select memberemail, statuscode, levelcode, ");
				sb.append("c.businesslicensenum, c.companyname, c.owner, ");
				sb.append("c.establishmentdate, c.employees, c.sales, c.location, ");
				sb.append("c.salary, c.introduction, c.homepage, c.savefilename, ");
				sb.append("c.originalfilename, c.filesize from member m join company c on m.memberemail = c.companyemail ");
				if(searchKey.equals("location") || searchKey.equals("companyname")) {
					sb.append("where instr("+searchKey+",?)>0 ");
				}else {
					sb.append("where " + searchKey + "= ? ");
				}
				sb.append(")tb where rownum <=" + end);
				sb.append(" ) where rnum >=" + start);
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, searchValue);
			}
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CompaniesDTO dto = new CompaniesDTO();
				dto.setCompanyEmail(rs.getString(1));
				dto.setStatusCode(rs.getInt(2));
				dto.setLevelCode(rs.getInt(3));
				dto.setBusinessLicenseNum(rs.getString(4));
				dto.setCompanyName(rs.getString(5));
				dto.setOwner(rs.getString(6));
				dto.setEstablishmentDate(rs.getDate(7).toString());
				dto.setEmployees(rs.getInt(8));
				dto.setSale(rs.getInt(9));
				dto.setLocation(rs.getString(10));
				dto.setSalary(rs.getInt(11));
				dto.setIntroduction(rs.getString(12));
				dto.setHomepage(rs.getString(13));
				dto.setSavefilename(rs.getString(14));
				dto.setOriginalfilename(rs.getString(15));
				dto.setFilesize(rs.getInt(16));
				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					if (!rs.isClosed()) {
						rs.close();
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			if (pstmt != null) {
				try {
					if (!pstmt.isClosed()) {
						pstmt.close();
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}

		return list;
	}

	public CompaniesDTO readCompany(String email) {
		CompaniesDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
				sb.append("select memberemail, statuscode, levelcode, ");
				sb.append("c.businesslicensenum, c.companyname, c.owner, ");
				sb.append("c.establishmentdate, c.employees, c.sales, c.location, ");
				sb.append("c.salary, c.introduction, c.homepage, c.savefilename, ");
				sb.append("c.originalfilename, c.filesize from member m join company c on m.memberemail = c.companyemail");
				sb.append(" where memberemail = ?");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new CompaniesDTO();
				dto.setCompanyEmail(rs.getString(1));
				dto.setStatusCode(rs.getInt(2));
				dto.setLevelCode(rs.getInt(3));
				dto.setBusinessLicenseNum(rs.getString(4));
				dto.setCompanyName(rs.getString(5));
				dto.setOwner(rs.getString(6));
				dto.setEstablishmentDate(rs.getDate(7).toString());
				dto.setEmployees(rs.getInt(8));
				dto.setSale(rs.getInt(9));
				dto.setLocation(rs.getString(10));
				dto.setSalary(rs.getInt(11));
				dto.setIntroduction(rs.getString(12));
				dto.setHomepage(rs.getString(13));
				dto.setSavefilename(rs.getString(14));
				dto.setOriginalfilename(rs.getString(15));
				dto.setFilesize(rs.getInt(16));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					if (!rs.isClosed()) {
						rs.close();
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			if (pstmt != null) {
				try {
					if (!pstmt.isClosed()) {
						pstmt.close();
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}

		return dto;
	}
}
