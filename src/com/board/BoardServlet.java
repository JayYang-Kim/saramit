package com.board;

import java.io.IOException;
import java.io.PrintWriter;
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

import net.sf.json.JSONObject;
@WebServlet("/board/*")
public class BoardServlet extends MyServlet{
	private static final long serialVersionUID = 1L;
	//자유게시판이나 피드백 게시판이나 내용이 똑같아서 하나로 비벼볼 수 있을 듯
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		if(info == null) {
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		}else if(uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		}else if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		}else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		}else if(uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		}else if(uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		}else if(uri.indexOf("reply_list.do") != -1){
			replyList(req, resp);
		}else if(uri.indexOf("reply_insert.do") != -1){
			replySubmit(req, resp);
		}else if(uri.indexOf("delete.do") != -1){
			delete(req, resp);
		}
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 리스트
		MyUtil util = new MyUtil();
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		int current_page = 1;
		if(page != null) {
			current_page = Integer.parseInt(page);
		}
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey == null) {
			searchKey = "subject";
			searchValue ="";
		}
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		int dataCount;
		if(searchValue.length() == 0) {
			dataCount = dao.dataCount();
		} else {
			dataCount = dao.dataCount(searchKey, searchValue);
		}
		
		int rows = 10;
		int total_page = util.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		List<BoardDTO> list;
		if(searchValue.length() == 0) {
			list = dao.listBoard(start, end);
		} else {
			list = dao.listBoard(start, end, searchKey, searchValue);
		}
		
		int listNum, n = 0;
		Iterator<BoardDTO> it = list.iterator();
		
		while(it.hasNext()) {
			BoardDTO dto = it.next();
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		if(searchValue.length() != 0) {
			query = "searchKey" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String list_url = cp + "/board/list.do";
		String article_url = cp + "/board/article.do?page=" + current_page;
		if(query.length() != 0) {
			list_url += "?" + query;
			article_url += "&" + query;
		}
		
		String paging = util.paging(current_page, total_page, list_url);
		
		req.setAttribute("list", list);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("article_url", article_url);
		req.setAttribute("paging", paging);
		
		forward(req, resp, "/WEB-INF/views/board/list.jsp");
	}
	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 생성폼
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		req.setAttribute("mode", "created");
		req.setAttribute("email", info.getEmail());
		req.setAttribute("name", info.getName());
		forward(req, resp, "/WEB-INF/views/board/created.jsp");
	}
	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 생성 완료
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/board/list.do");
			return;
		}
		
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO();
		
		dto.setUserEmail(info.getEmail());
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("contents"));
		
		dao.insertBoard(dto, "created");
		
		resp.sendRedirect(cp + "/board/list.do");
	}
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 상세
		String cp = req.getContextPath();
		
		BoardDAO dao = new BoardDAO();
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}
		
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "page=" + page;
		if(searchValue.length() != 0) {
			query = "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		dao.updateHitCount(boardNum);
		BoardDTO dto = dao.readBoard(boardNum);
		if(dto == null) {
			resp.sendRedirect(cp + "/board/list.do?" + query);
		}
		
		MyUtil util = new MyUtil();
		dto.setContent(util.htmlSymbols(dto.getContent()));
		
		BoardDTO preReadDto = dao.preReadBoard(dto.getGroupNum(), dto.getOrderNum(), searchKey, searchValue);
		BoardDTO nextReadDto = dao.nextReadBoard(dto.getGroupNum(), dto.getOrderNum(), searchKey, searchValue);
		
		req.setAttribute("dto", dto);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);
		req.setAttribute("query", query);
		req.setAttribute("page", page);
		req.setAttribute("mode", "reply");
		
		forward(req, resp, "/WEB-INF/views/board/article.jsp");
	}
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정폼
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		BoardDAO dao = new BoardDAO();
		
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}
		
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "page=" + page;
		if(searchValue.length()!=0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		int boardNum=Integer.parseInt(req.getParameter("boardNum"));
		
		BoardDTO dto=dao.readBoard(boardNum);
		
		if(dto == null) {
			resp.sendRedirect(cp + "/board/list.do?" + query);
			return;
		}
		
		if(! dto.getUserEmail().equals(info.getEmail())) {
			resp.sendRedirect(cp + "/board/list.do?" + query);
			return;
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("searchKey", searchKey);
		req.setAttribute("searchValue", searchValue);
		req.setAttribute("mode", "update");
		
		forward(req, resp, "/WEB-INF/views/board/created.jsp");
	}
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정완료
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/board/list.do");
			return;
		}
		
		BoardDAO dao = new BoardDAO();
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		String query = "page=" + page;
		if(searchValue.length() != 0) {
			query += "&searchKey" + searchKey + "&searchValue=" + URLDecoder.decode(searchValue, "UTF-8");
		}
		
		BoardDTO dto = new BoardDTO();
		dto.setBoardNum(Integer.parseInt(req.getParameter("boardNum")));
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("contents"));
		
		dao.updateBoard(dto, info.getEmail());
		
		resp.sendRedirect(cp + "/board/article.do?boardNum=" + boardNum +"&" + query);
	}
	protected void replyList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//답글 리스트 (AJAX)
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtil();
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		int current_page = 1;
		String pageNo = req.getParameter("page");
		
		if(pageNo != null) {
			current_page = Integer.parseInt(pageNo);
		}
		
		int rows = 5;
		int total_page = 0;
		int replyCount = 0;
		
		replyCount = dao.dataCountReply(boardNum);
		total_page = util.pageCount(rows, replyCount);
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		List<FeedBack_ReplyDTO> list = dao.listReply(boardNum, start, end);
		
		for(FeedBack_ReplyDTO dto : list) {
			dto.setContent(util.htmlSymbols(dto.getContent()));
		}
		
		String paging = util.paging(current_page, total_page, "listPage");
		
		req.setAttribute("list", list);
		req.setAttribute("pageNo", current_page);
		req.setAttribute("replyCount", replyCount);
		req.setAttribute("total_page", total_page);
		req.setAttribute("paging", paging);
		
		forward(req, resp, "/WEB-INF/views/board/listReply.jsp");
	}
	protected void replySubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 답글 등록(AJAX)
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "true";
		
		if(info == null) {
			state = "loginFail";
		} else {
			BoardDAO dao = new BoardDAO();
			FeedBack_ReplyDTO dto = new FeedBack_ReplyDTO();
			
			dto.setEmail(info.getEmail());
			dto.setBoardNum(Integer.parseInt(req.getParameter("boardNum")));
			dto.setAnswer(Integer.parseInt(req.getParameter("answer")));
			dto.setContent(req.getParameter("reply_content"));
			
			dao.insertReply(dto);
		}
		
		JSONObject job = new JSONObject();
		job.put("state", state);
		
		// json으로 결과 전송
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 삭제
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		BoardDAO dao = new BoardDAO();
		
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}
		
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		String query = "page=" + page;
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		BoardDTO dto = dao.readBoard(boardNum);
		
		if(dto == null) {
			resp.sendRedirect(cp + "/board/list.do?" + query);
			return;
		}
		
		if(!dto.getUserEmail().equals(info.getEmail()) && !info.getEmail().equals("admin")) {
			resp.sendRedirect(cp + "/board/list.do?" + query);
			return;
		}
		
		dao.deleteBoard(boardNum);
		
		resp.sendRedirect(cp + "/board/list.do?" + query);
	}


}
