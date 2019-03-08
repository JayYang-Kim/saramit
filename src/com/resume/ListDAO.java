/*
 * package com.resume;
 * 
 * import java.sql.Connection; import java.sql.PreparedStatement; import
 * java.sql.ResultSet; import java.util.ArrayList; import java.util.List;
 * 
 * import com.util.DBConn;
 * 
 * public class ListDAO { private Connection conn=DBConn.getConnection();
 * 
 * private List<ResumeDTO> listResume(String resumeCode){ List<ResumeDTO>
 * list=new ArrayList<ResumeDTO>(); PreparedStatement pstmt=null; ResultSet
 * rs=null; StringBuffer sb=new StringBuffer();
 * 
 * try { sb.append("SELECT * FROM("); sb.append(" SELECT ROWNUM num, tb.* fro")
 * 
 * } catch (Exception e) { // TODO: handle exception } return list; } }
 */