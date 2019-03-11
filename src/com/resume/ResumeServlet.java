package com.resume;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.main.SessionInfo;
import com.member.MemberDAO;

import com.util.MyServlet;

@WebServlet("/resume/*")
public class ResumeServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		String uri = req.getRequestURI();

		if (uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		} else if (uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		} else if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("view.do") != -1) {
			view(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//req.setAttribute(name, o);
		ResumeDAO dao = new ResumeDAO();
		
		List<ResumeDTO> list = dao.listResume();
		
		req.setAttribute("list", list);
		
		forward(req, resp, "/WEB-INF/views/resume/list.jsp");
	}

	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 작성폼
		req.setAttribute("mode", "created");
		HttpSession session =req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		MemberDAO dao=new MemberDAO();
		com.member.UserDTO dto= dao.readUser(info.getEmail());
		req.setAttribute("dto", dto);
		
		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 작성완료
		req.setCharacterEncoding("utf-8");
		req.setAttribute("mode", "created_ok");
		ResumeDAO dao=new ResumeDAO();
		ResumeDTO dto_resume=new ResumeDTO();
		dto_resume.setUserEmail(req.getParameter("userEmail"));
		dto_resume.setName(req.getParameter("name"));
		dto_resume.setAddr(req.getParameter("addr"));
		dto_resume.setBirth(req.getParameter("birth"));
		dto_resume.setGender(req.getParameter("gender"));
		dto_resume.setTitle(req.getParameter("title"));
		int rnum = dao.insertResume(dto_resume);
		
		
		String[] license_name = req.getParameterValues("licenseName");
		String[] license_date = req.getParameterValues("licenseDate");
		String[] license_publisher = req.getParameterValues("licensePublisher");
		if(license_name!=null && license_date!=null && license_publisher != null) {
			for(int i=0; i<license_name.length; i++) {
				LicenseDTO dto_license=new LicenseDTO();
				dto_license.setLicense_name(license_name[i]);
				dto_license.setLicense_date(license_date[i]);
				dto_license.setLicense_publisher(license_publisher[i]);
				dao.insertLicense(dto_license,rnum);
			}
		}
		
		String[] awardsName=req.getParameterValues("awardsName");
		String[] awardspublisher=req.getParameterValues("awardspublisher");
		String[] awardsDate=req.getParameterValues("awardsDate"); 
		if(awardsName!=null && awardspublisher!=null && awardsDate!=null) {
			for(int i=0;i<awardsName.length;i++) {
		AwardsDTO dto_awards=new AwardsDTO();
		dto_awards.setAwardsName(req.getParameter(awardsName[i]));
		dto_awards.setAwards_publisher(req.getParameter(awardspublisher[i]));
		dto_awards.setAwards_date(req.getParameter(awardsDate[i]));
		dao.insertAwards(dto_awards,rnum);
			}
		}
		
		String[] gubun=req.getParameterValues("gubun");
		String[] copName=req.getParameterValues("copName");
		String[] task=req.getParameterValues("task");
		String[] position=req.getParameterValues("position");
		String[] carrerjoinDate=req.getParameterValues("carrerjoinDate");
		String[] carrerresignDate=req.getParameterValues("carrerresignDate");
		if(gubun!=null && copName!=null && task!=null && position!=null && carrerjoinDate!=null && carrerresignDate!=null) {
		for(int i=0;i<gubun.length;i++) {
				CareerDTO dto_career=new CareerDTO();
				dto_career.setGubun(req.getParameter("gubun"));
				dto_career.setCopName(req.getParameter("copName"));
				dto_career.setTask(req.getParameter("task"));
				dto_career.setPosition(req.getParameter("position"));
				dto_career.setJoinDate(req.getParameter("carrerjoinDate"));
				dto_career.setResignDate(req.getParameter("carrerresignDate"));
				dao.insertCareer(dto_career,rnum);
			}	
		}
		
		EducationDTO dto_education=new EducationDTO();
		dto_education.setEducationCode(Integer.parseInt(req.getParameter("educationCode")));
		dto_education.setSchoolName(req.getParameter("schoolName"));
		System.out.println(req.getParameter("schoolName"));
		dto_education.setRegion(req.getParameter("region"));
		dto_education.setMajor(req.getParameter("major"));
		dto_education.setEntrance(req.getParameter("entrance"));
		dto_education.setGraduate(req.getParameter("graduate"));
		dto_education.setGraduate_status(req.getParameter("graduate_status"));
		System.out.println(rnum);
		//dao.insertEducation(dto_education,rnum);
		
		forward(req, resp, "/WEB-INF/views/resume/created_ok.jsp");
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 수정
		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 수정완료
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}

	protected void view(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 보기
		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서삭제
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
}
