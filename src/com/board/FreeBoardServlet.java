package com.board;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.main.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;
@WebServlet("/board/free/*")
public class FreeBoardServlet extends MyServlet{
	private static final long serialVersionUID = 1L;
	//자유게시판이나 피드백 게시판이나 내용이 똑같아서 하나로 비벼볼 수 있을 듯
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		}else if(uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		}else if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		}else if(uri.indexOf("update.do")!= -1) {
			updateForm(req, resp);
		}else if(uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		}else if(uri.indexOf("reply.do") != -1){
			replyForm(req, resp);
		}else if(uri.indexOf("reply_ok.do") != -1){
			replySubmit(req, resp);
		}else if(uri.indexOf("delete.do") != -1){
			delete(req, resp);
		}else if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		}
	
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 리스트
		
		//기본 세팅
		String cp = req.getContextPath();
		MyUtil util = new MyUtil();
		FreeBoardDAO dao = new FreeBoardDAO();
		String page = req.getParameter("page");
		int current_page = 1;
		if(page!=null) {
			current_page = Integer.parseInt(page);
		}
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey != null && searchValue != null) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		//페이징 준비
		int rows = 10;
		int dataCount = 0;
		if(searchKey != null && searchValue != null) {
			dataCount = dao.dataCount(searchKey,searchValue);
		}else {
			dataCount = dao.dataCount("","");
		}
		int total_page = util.pageCount(rows, dataCount);
		int start = (current_page-1)*rows+1;
		int end = current_page*rows;
		
		if(current_page> total_page) {
			current_page = total_page;
		}
		//주소 정리 & 리스트 가져오기
		String list_url = cp+"/board/free/list.do";
		String article_url = cp+"/board/free/article.do?page="+current_page;
		ArrayList<FreeBoardDTO> list;
		if(searchKey != null && searchValue != null) {
			list_url += "?searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			article_url += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			list = dao.listBoard(start,end,searchKey,searchValue);
		}else {
			list = dao.listBoard(start, end,"","");
		}
		//리스트 번호 만들기
		int n = 0;
		for(FreeBoardDTO dto : list) {
			dto.setListNum(dataCount-((current_page-1)*rows)-n);
			n++;
		}
		//페이징
		String paging = util.paging(current_page, total_page, list_url);
		//어트리뷰트 삽입
		req.setAttribute("page", page);
		req.setAttribute("list", list);
		req.setAttribute("article_url", article_url);
		req.setAttribute("paging", paging);
		req.setAttribute("dataCount", dataCount);
		forward(req, resp, "/WEB-INF/views/board/free/list.jsp");
	}
	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 생성폼
		forward(req, resp, "/WEB-INF/views/board/free/created.jsp");
	}
	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 생성 완료
		//기본 준비
		MyUtil util = new MyUtil();
		String cp = req.getContextPath();
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		FreeBoardDTO dto = new FreeBoardDTO();
		FreeBoardDAO dao = new FreeBoardDAO();
		dto.setUserEmail(info.getEmail());
		dto.setSubject(util.htmlSymbols(req.getParameter("subject")));
		dto.setContent(util.htmlSymbols(req.getParameter("content")));
		dao.insertBoard(dto,info.getName());
		resp.sendRedirect(cp+"/board/free/list.do");
	}
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정폼
		FreeBoardDAO dao = new FreeBoardDAO();
		FreeBoardDTO dto = dao.readBoard(Integer.parseInt(req.getParameter("num")));
		if(dto==null) {
			
		}
		req.setAttribute("num", req.getParameter("num"));
		req.setAttribute("page", req.getParameter("page"));
		req.setAttribute("dto", dto);
		req.setAttribute("mode", "update");
		forward(req, resp, "/WEB-INF/views/board/free/created.jsp");
	}
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정완료
		//기본작업
		String cp = req.getContextPath();
		req.setCharacterEncoding("utf-8");
		String page = req.getParameter("page");
		MyUtil util = new MyUtil();
		int num = Integer.parseInt(req.getParameter("boardNum"));
		
		FreeBoardDAO dao = new FreeBoardDAO();
		FreeBoardDTO dto = new FreeBoardDTO();
		dto.setBoardNum(num);
		dto.setSubject(util.htmlSymbols(req.getParameter("subject")));
		dto.setContent(util.htmlSymbols(req.getParameter("content")));		
		dao.updateBoard(dto);
		resp.sendRedirect(cp+"/board/free/article.do?page="+page+"&boardNum="+num);
	}
	protected void replyForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//답글 폼
		forward(req, resp, "/WEB-INF/views/board/free/created.jsp");
	}
	protected void replySubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 답글 완료
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 삭제
		String cp = req.getContextPath();
		int num = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		FreeBoardDAO dao = new FreeBoardDAO();
		dao.removeBoard(num);
		resp.sendRedirect(cp+"/board/free/list.do?page="+page);
	}
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 삭제
		//기본 세팅
		String cp = req.getContextPath();
		int num = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");
		if(page==null) {
			page = "1";
		}
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey != null && searchValue != null) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		String list_url = cp+"/board/free/list.do?page="+page;
		
		
		FreeBoardDAO dao = new FreeBoardDAO();
		FreeBoardDTO dto = dao.readBoard(num);
		FreeBoardDTO nextDto = dao.readNextBoard(num, searchKey, searchValue);
		FreeBoardDTO prevDto = dao.readPrevBoard(num, searchKey, searchValue);
		
		String prev_url = cp+"/board/free/article.do?page="+page;
		String next_url = cp+"/board/free/article.do?page="+page;
		if(searchKey != null && searchValue != null) {
			list_url += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			prev_url += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			next_url += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
		}
		if(nextDto != null) {
			next_url +="&boardNum="+nextDto.getBoardNum();
		}
		
		 if(prevDto != null) { 
			 prev_url +="&boardNum="+prevDto.getBoardNum(); 
		}
		 
		/*
		 * if(dto == null) { PrintWriter out = resp.getWriter();
		 * out.println("<script>alert('이미 삭제된 게시물입니다.');</script>"); out.flush();
		 * resp.sendRedirect(list_url); return; }
		 */
		
		req.setAttribute("page", page);
		req.setAttribute("dto",dto);
		req.setAttribute("prevDto", prevDto);
		req.setAttribute("nextDto", nextDto);
		req.setAttribute("list_url", list_url);
		req.setAttribute("prev_url", prev_url);
		req.setAttribute("next_url", next_url);
		forward(req, resp, "/WEB-INF/views/board/free/article.jsp");
	}


}
