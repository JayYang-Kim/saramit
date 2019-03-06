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
		
		if(uri.indexOf("listReview.do") != -1) {
			listReview(req, resp);
		}else if(uri.indexOf("review.do") != -1) {
			review(req, resp);
		}else if(uri.indexOf("info.do")!=-1) {
			info(req, resp);
		}else if(uri.indexOf("review_ok.do")!=-1) {
			reviewSubmit(req, resp);
		}else if(uri.indexOf("reviewUp_ok.do")!=-1) {
			reviewUpdate(req, resp);
		}else if(uri.indexOf("articleReview.do")!=-1) {
			articleReview(req, resp);
		}
	}
	
	protected void listReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회사평가(리뷰) 리스트
		String cp = req.getContextPath();
		MyUtil util = new MyUtil();
		EvaluationDAO dao = new EvaluationDAO();
		
		//String email = req.getParameter("email");
	    //email="smilegate@saramit.com";
	      
	    //String cop_name=dao.searchCoName("smilegate@saramit.com");
	    
		  
		String page = req.getParameter("page");
		int current_page=1;
		if(page!=null) 
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
		
		int rows=10;
		int total_page = util.pageCount(rows, dataCount);
		if(current_page > total_page)
			current_page = total_page;
		
		int start = (current_page -1) * rows + 1;
		int end = current_page * rows;
		
		List<EvaluationDTO> list;
		if(searchValue.length() ==0)
			list = dao.listReview(start, end);
		else
			list = dao.listReview(start, end, searchKey, searchValue);
		
		
		int listNum, n=0;
		Iterator<EvaluationDTO>it=list.iterator();
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
		
		String listUrl=cp+"/companies/listReiew.do";
		String articleUrl=cp+"/companies/articleReview.do?page="+current_page;
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl+="&"+query;
		}
		
		String paging=util.paging(current_page,total_page,listUrl);
		
		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("paging", paging);
		
		forward(req, resp, "/WEB-INF/views/evaluation/list.jsp");
	}
	protected void review(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	      //회사 평가
		EvaluationDAO dao = new EvaluationDAO();
		
	      
	      String email = req.getParameter("email");
	      email="smilegate@saramit.com";
	      
	      String cop_name=dao.searchCoName(email);
	      req.setAttribute("cop_name", cop_name);
		  req.setAttribute("email", email);
		  
	      req.setAttribute("mode", "created");
	      
	      forward(req, resp, "/WEB-INF/views/evaluation/review.jsp");
	}
	
	protected void articleReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EvaluationDAO dao = new EvaluationDAO();
		String cp = req.getContextPath();
		
		int boardNum = Integer.parseInt(req.getParameter("num"));
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
		dto.setStar(Integer.parseInt(req.getParameter("star")));
		
		dao.insertReview(dto,"created");
		
		resp.sendRedirect(cp);
	
	}
	
	protected void reviewUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//리뷰(기업평가) 수정
	//	String cp = req.getContextPath();
		
	//	HttpSession session = req.getSession();
	//	SessionInfo info = (SessionInfo)session.getAttribute("member");
		
	}
	
	
	
}
