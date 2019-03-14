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
import com.util.MyUtil;

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
		} else if (uri.indexOf("view.do") != -1) { // 이력서 보기
			view(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) { //이력서 수정완료
			updateSubmit(req, resp);
		} else if (uri.indexOf("view.do") != -1) {
			view(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}

	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp=req.getContextPath();
		ResumeDAO dao = new ResumeDAO();
		MyUtil util=new MyUtil();
		
		
		String page=req.getParameter("page");
		int current_page=1;
		if(page !=null) {
			current_page=Integer.parseInt(page);			
		}
		String url=cp+"/resume/list.do";
		String view_url=cp+"/resume/view.do?page="+current_page;
		
		int rows=5; //페이지당 출력 이력서수
		int dataCount=dao.totData(); //총 이력서 개수
		int total_page=util.pageCount(rows, dataCount);
		
		if(current_page>total_page) {
			current_page=total_page; // 페이지수를 날려버렸을때, 총페이지수를 현재페이지 수의 합계와 같게 만든다.
		}
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		
		List<ResumeDTO> list = dao.listResume(start,end);
		int n=0;
		for(ResumeDTO dto:list) {
			dto.setListNum(dataCount-(current_page-1)*rows-n);
			n++;
		}
		
		String paging=util.paging(current_page, total_page,url);
		
		req.setAttribute("list", list);
		req.setAttribute("url", url);
		req.setAttribute("view_url", view_url);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("paging", paging);
		forward(req, resp, "/WEB-INF/views/resume/list.jsp");
	}

	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이력서 작성폼
		req.setAttribute("mode", "created");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		MemberDAO dao = new MemberDAO();
		com.member.UserDTO dto = dao.readUser(info.getEmail());
		req.setAttribute("dto", dto);

		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 이력서 작성완료
		req.setCharacterEncoding("utf-8");
		req.setAttribute("mode", "created_ok");
		ResumeDAO dao = new ResumeDAO();
		ResumeDTO dto_resume = new ResumeDTO();
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
		if (license_name != null && license_date != null && license_publisher != null) {
			for (int i = 0; i < license_name.length; i++) {
				LicenseDTO dto_license = new LicenseDTO();
				dto_license.setLicense_name(license_name[i]);
				dto_license.setLicense_date(license_date[i]);
				dto_license.setLicense_publisher(license_publisher[i]);
				dao.insertLicense(dto_license, rnum);
			}
		}

		String[] awardsName = req.getParameterValues("awardsName");
		String[] awardspublisher = req.getParameterValues("awardspublisher");
		String[] awardsDate = req.getParameterValues("awardsDate");
		if (awardsName != null && awardspublisher != null && awardsDate != null) {
			for (int i = 0; i < awardsName.length; i++) {
				AwardsDTO dto_awards = new AwardsDTO();
				dto_awards.setAwardsName(awardsName[i]);
				dto_awards.setAwards_publisher(awardspublisher[i]);
				dto_awards.setAwards_date(awardsDate[i]);
				dao.insertAwards(dto_awards, rnum);
			}
		}

		String[] gubun = req.getParameterValues("gubun");
		String[] copName = req.getParameterValues("copName");
		String[] task = req.getParameterValues("task");
		String[] position = req.getParameterValues("position");
		String[] carrerjoinDate = req.getParameterValues("carrerjoinDate");
		String[] carrerresignDate = req.getParameterValues("carrerresignDate");
		if (gubun != null && copName != null && task != null && position != null && carrerjoinDate != null
				&& carrerresignDate != null) {
			for (int i = 0; i < gubun.length; i++) {
				CareerDTO dto_career = new CareerDTO();
				dto_career.setGubun(gubun[i]);
				dto_career.setCopName(copName[i]);
				dto_career.setTask(task[i]);
				dto_career.setPosition(position[i]);
				dto_career.setJoinDate(carrerjoinDate[i]);
				dto_career.setResignDate(carrerresignDate[i]);
				dao.insertCareer(dto_career, rnum);
			}
		}

		EducationDTO dto_education = new EducationDTO();
		dto_education.setEducationCode(Integer.parseInt(req.getParameter("educationCode")));
		dto_education.setSchoolName(req.getParameter("schoolName"));
		dto_education.setRegion(Integer.parseInt(req.getParameter("region")));
		dto_education.setMajor(req.getParameter("major"));
		dto_education.setEntrance(req.getParameter("entrance"));
		dto_education.setGraduate(req.getParameter("graduate"));
		dto_education.setGraduate_status(req.getParameter("graduate_status"));
		dao.insertEducation(dto_education,rnum);

		forward(req, resp, "/WEB-INF/views/resume/created_ok.jsp");
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이력서 수정
		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이력서 수정완료
		req.setCharacterEncoding("utf-8");
		req.setAttribute("mode", "created_ok");
		ResumeDAO dao = new ResumeDAO();
		ResumeDTO dto_resume = new ResumeDTO();
		dto_resume.setTitle(req.getParameter("title"));
		int rnum = dao.insertResume(dto_resume);
		
		forward(req, resp, "/WEB-INF/views/resume/update_ok.jsp");
	}

	protected void view(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이력서 보기
		int resumeCode = Integer.parseInt(req.getParameter("resumeCode"));
		ResumeDAO dao=new ResumeDAO();
		ResumeDTO dto_resume=dao.readResume(resumeCode);
		
		EducationDTO dto_edu=dao.readEducation(resumeCode);
		List<AwardsDTO> awardList = dao.readAwards(resumeCode);
		List<LicenseDTO> licenseList= dao.readLicense(resumeCode);
		List<CareerDTO> CareerList=dao.readCareer(resumeCode);

		
		req.setAttribute("awardList", awardList);
		req.setAttribute("licenseList", licenseList);
		req.setAttribute("CareerList", CareerList);
		req.setAttribute("dto_resume", dto_resume);
		req.setAttribute("dto_edu", dto_edu);
		// db 해당 이력서 가져오기

		forward(req, resp, "/WEB-INF/views/resume/view.jsp");
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 이력서삭제
		String cp = req.getContextPath();
		resp.sendRedirect(cp);

		forward(req, resp, "/WEB-INF/views/resume/delete.jsp");
	}
}
