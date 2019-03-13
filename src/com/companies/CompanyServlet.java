package com.companies;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.main.SessionInfo;
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
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		}else if(uri.indexOf("listReview.do") != -1) {
			listReview(req, resp);
		}else if(uri.indexOf("review.do") != -1) {
			review(req, resp);
		}else if(uri.indexOf("info.do")!=-1) {
			info(req, resp);
		}else if(uri.indexOf("review_ok.do")!=-1) {
			reviewSubmit(req, resp);
		}else if(uri.indexOf("reviewUp.do")!=-1) {
			revewUpdateForm(req,resp);
		}else if(uri.indexOf("reviewUp_ok.do")!=-1) {
			reviewUpdateSubmit(req, resp);
		}else if(uri.indexOf("articleReview.do")!=-1) {
			articleReview(req, resp);
		}else if(uri.indexOf("reviewDelete.do")!=-1) {
			reviewDelete(req,resp);
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
		String url = cp+"/companies/list.do?page="+current_page; //다시 리스트로 가는 경우의 주소
		String info_url = cp+"/companies/info.do?page="+current_page;
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		
		//검색값 디코딩 & 주소 처리
		if(searchKey != null && searchValue != null) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
			url += "&searchKey="+searchKey+"&searchValue="+searchValue;
			info_url += "&searchKey="+searchKey+"&searchValue="+searchValue;
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
		req.setAttribute("url", url);
		req.setAttribute("info_url", info_url);
		req.setAttribute("companies", list);
		req.setAttribute("paging", paging);
		req.setAttribute("dataCount", dataCount);
		forward(req, resp, "/WEB-INF/views/companies/list.jsp");
	}
	
	protected void listReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회사평가(리뷰) 리스트
		String cp = req.getContextPath();
		MyUtil util = new MyUtil();
		EvaluationDAO dao = new EvaluationDAO();
	      
		// 넘어온 페이지 번호
		String page = req.getParameter("page");
		int current_page=1;
		if(page != null) 
			current_page=Integer.parseInt(page);
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey == null) {
			searchKey = "cop";
			searchValue = "";
		}
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		int dataCount;
		if(searchValue.length()==0)
			dataCount = dao.dataCount();
		else
			dataCount = dao.dataCount(searchKey, searchValue);
		
		// 페이지 수 
		int rows=10;
		int total_page = util.pageCount(rows, dataCount);
		if(current_page > total_page)
			current_page = total_page;
		
		// 게시물 가져오기~
		int start = (current_page -1) * rows + 1;
		int end = current_page * rows;
		
		List<EvaluationDTO> list;
		if(searchValue.length() == 0)
			list = dao.listReview(start, end);
		else
			list = dao.listReview(start, end, searchKey, searchValue);
		
		// 글번호	
		int listNum, n=0;
		Iterator<EvaluationDTO> it=list.iterator();
		while(it.hasNext()) {
			EvaluationDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query="";
		if(searchValue.length()!=0) {
			searchValue=URLEncoder.encode(searchValue,"utf-8");
			query="searchKey="+searchKey+"&searchValue="+searchValue;
		}
		
		String listUrl=cp+"/companies/listReview.do";
		String articleUrl=cp+"/companies/articleReview.do?page="+current_page;
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl+="&"+query;
		}
		
		// 별점 랭킹
		List<EvaluationDTO> listS;
		listS = dao.star();

		String paging = util.paging(current_page,total_page,listUrl);
		
		req.setAttribute("listS", listS);
		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("paging", paging);
		
		forward(req, resp, "/WEB-INF/views/evaluation/list.jsp");
	}
	protected void review(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	      //회사 평가 작성
		EvaluationDAO dao = new EvaluationDAO();
		CompaniesDAO c_dao = new CompaniesDAO();
	      
	      String email = req.getParameter("email");
	      
	      String cop_name=dao.searchCoName(email);

		  
		  CompaniesDTO c_dto = c_dao.readCompany(email);
		  String savefilename=c_dto.getSavefilename();
		  
		  req.setAttribute("savefilename", savefilename); 
		  req.setAttribute("cop_name",cop_name); 
		  req.setAttribute("email", email);
		  req.setAttribute("mode", "created");
		  
		  forward(req, resp, "/WEB-INF/views/evaluation/review.jsp");
		 
	}
	
	// 상세보기
	protected void articleReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EvaluationDAO dao = new EvaluationDAO();
		String cp = req.getContextPath();
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="cop";
			searchValue="";
		}
		searchValue=URLDecoder.decode(searchValue, "utf-8");
		
		String query="page="+page;
		if(searchValue.length()!=0) {
			query += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue,"utf-8");
		}
		
		EvaluationDTO dto = dao.readReview(boardNum);
		if(dto==null) {
			resp.sendRedirect(cp+"/companies/listReview.do?"+query);
			return;
		}
		
		MyUtil util = new MyUtil();
		dto.setContent1(util.htmlSymbols(dto.getContent1()));
		dto.setContent2(util.htmlSymbols(dto.getContent2()));
		dto.setContent3(util.htmlSymbols(dto.getContent3()));
		dto.setContent4(util.htmlSymbols(dto.getContent4()));
		
		req.setAttribute("dto", dto);
		req.setAttribute("query", query);
		req.setAttribute("page", page);
		
		forward(req, resp, "/WEB-INF/views/evaluation/articleReview.jsp");
	}
	
	
	protected void info(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회사 소개
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		String url = cp+"/companies/list.do?page="+page;
		if(searchKey != null && searchValue != null) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
			url += "&searchKey="+searchKey+"&searchValue="+searchValue;
		}
		String email = req.getParameter("email");
		email = URLDecoder.decode(email, "utf-8");
		CompaniesDAO dao = new CompaniesDAO();
		CompaniesDTO dto = dao.readCompany(email);
		req.setAttribute("url", url);
		req.setAttribute("company", dto);
		forward(req,resp,"/WEB-INF/views/companies/info.jsp");
	}
	
	protected void reviewSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//리뷰(기업평가) 저장
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		EvaluationDAO dao = new EvaluationDAO();
		EvaluationDTO dto = new EvaluationDTO();

		dto.setUserEmail(info.getEmail());
		dto.setCompanyEmail(req.getParameter("email"));
		dto.setContent1(req.getParameter("content1"));
		dto.setContent2(req.getParameter("content2"));
		dto.setContent3(req.getParameter("content3"));
		dto.setContent4(req.getParameter("content4"));
		dto.setStar(Integer.parseInt(req.getParameter("score")));
		
		
		dao.insertReview(dto);
		
		resp.sendRedirect(cp);
	
	}
	
	// 기업평가(리뷰) 수정 폼
	protected void revewUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		EvaluationDAO dao = new EvaluationDAO();
		CompaniesDAO c_dao = new CompaniesDAO();
		
		String email = req.getParameter("email");
		String cop_name=dao.searchCoName(email);
	      
		String page = req.getParameter("page");
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		EvaluationDTO dto = dao.readReview(boardNum);
		
		if(dto==null) {
			resp.sendRedirect(cp+"/companies/list.do?page="+page);
			return;
		}
		
		if(! dto.getUserEmail().equals(info.getEmail())) {
			resp.sendRedirect(cp+"/companies/list.do?page="+page);
			return;
		}
		
		CompaniesDTO c_dto = c_dao.readCompany(email);
	    String savefilename=c_dto.getSavefilename();
	    
	    req.setAttribute("savefilename", savefilename);
	    req.setAttribute("cop_name", cop_name);
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("mode", "update");
		
		forward(req, resp, "/WEB-INF/views/evaluation/review.jsp");
		
	}
	protected void reviewUpdateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//기업평가(리뷰) 수정완료
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		EvaluationDAO dao = new EvaluationDAO();
		
		String page = req.getParameter("page");
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp+"/companies/articleReview.do?page="+page);
			return;
		}
		
		EvaluationDTO dto = new EvaluationDTO();
		dto.setBoardNum(Integer.parseInt(req.getParameter("boardNum")));
		dto.setUserEmail(info.getEmail());
		dto.setCompanyEmail(req.getParameter("email"));
		dto.setContent1(req.getParameter("content1"));
		dto.setContent2(req.getParameter("content2"));
		dto.setContent3(req.getParameter("content3"));
		dto.setContent4(req.getParameter("content4"));
		dto.setStar(Integer.parseInt(req.getParameter("score")));
		
		dao.updateReview(dto, info.getEmail());
		
		resp.sendRedirect(cp+"/companies/listReview.do?page="+page);

	}
	
	protected void reviewDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	// 기업평가(리뷰) 삭제
	HttpSession session = req.getSession();
	SessionInfo info=(SessionInfo)session.getAttribute("member");
	
	String cp = req.getContextPath();
	EvaluationDAO dao = new EvaluationDAO();
	
	String page = req.getParameter("page");
	String searchKey = req.getParameter("searchKey");
	String searchValue = req.getParameter("searchValue");
	if(searchKey == null) {
		searchKey="subject";
		searchValue="";
	}
	searchValue = URLDecoder.decode(searchValue, "utf-8");
	String query="page="+page;
	if(searchValue.length()!=0) {
		query +="&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
	}
	
	int boardNum = Integer.parseInt(req.getParameter("boardNum"));
	EvaluationDTO dto = dao.readReview(boardNum);
	
	if(dto==null) {
		resp.sendRedirect(cp+"/companies/listReview.do?"+query);
		return;
	}
	
	if(!dto.getUserEmail().equals(info.getEmail()) && ! info.getEmail().equals("admin")) {
		resp.sendRedirect(cp+"/companies/listReview.do?"+query);
		return;
	}
	
	dao.deleteReveiw(boardNum);
	resp.sendRedirect(cp+"/companies/listReview.do?"+query);
	
	}
	
}
