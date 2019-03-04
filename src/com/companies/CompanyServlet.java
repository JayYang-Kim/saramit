package com.companies;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;
import com.util.MyUtil;
@WebServlet("/companies/*")
public class CompanyServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();
		/*HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}*/
		
		if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		}else if(uri.indexOf("review.do") != -1) {
			review(req, resp);
		}else if(uri.indexOf("info.do")!=-1) {
			info(req, resp);
		}
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//list에서 넘어갈 수 있는 페이지 중 처리해야하는 것
		//list -> list 검색값이 있는 경우
		//list -> list 검색값이 있는 상태에서 이전또는 다음페이지 눌러서 온경우
		//list -> list 검색값 없이 이전 또는 다음페이지 눌러서 온 경우
		//list -> list 다시 회사검색 눌러서 들어오는 경우
		//list -> info 회사 더보기 눌러서 넘어가는 경우
		//이 이외에는 처리해줄 필요 없음
		
		//기본 데이터
		String cp = req.getContextPath();
		CompaniesDAO dao = new CompaniesDAO();
		MyUtil util = new MyUtil();
		
		//필요한 데이터 수집
		String page = req.getParameter("page");
		int current_page = 1;
		if(page != null) {
			current_page = Integer.parseInt(page);
		}
		//앞으로 가져갈 uri
		String url = cp+"/companies/list.do"; //다시 리스트로 가는 경우의 주소
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		
		//검색값 디코딩 & 주소 처리
		if(searchKey != null && searchValue != null) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
			url += "&searchKey="+searchKey+"&searchValue="+searchValue;
		}
		
		//페이징 작업 
		int rows = 12;
		int dataCount = dao.totData(searchKey, searchValue);
		int total_page = util.pageCount(rows, dataCount);
		
		if(current_page>total_page) {
			current_page=total_page;
		} //여기 조심
		int start = (current_page-1)*rows +1;
		int end = current_page*rows;
		
		
		//회사 리스트(검색)
		List<CompaniesDTO> list = dao.listCompanies(start, end, searchKey, searchValue);
		String paging = util.paging(current_page, total_page, url);
		
		req.setAttribute("page", current_page);
		req.setAttribute("companies", list);
		req.setAttribute("paging", paging);
		req.setAttribute("dataCount", dataCount);
		forward(req, resp, "/WEB-INF/views/companies/list.jsp");
	}
	protected void review(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회사 평가
	}
	protected void info(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회사 소개
		String email = req.getParameter("email");
		email = URLDecoder.decode(email, "utf-8");
		CompaniesDAO dao = new CompaniesDAO();
		CompaniesDTO dto = dao.readCompany(email);
		req.setAttribute("company", dto);
		forward(req,resp,"/WEB-INF/views/companies/info.jsp");
	}
}
