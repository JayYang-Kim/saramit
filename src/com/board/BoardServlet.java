package com.board;

import java.io.IOException;
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
		}else if(uri.indexOf("reply.do") != -1){
			replyForm(req, resp);
		}else if(uri.indexOf("reply_ok.do") != -1){
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
		
		int dataCount;
		dataCount = dao.dataCount();
		
		int rows = 10;
		int total_page = util.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		List<BoardDTO> list;
		list = dao.listBoard(start, end);
		
		int listNum, n = 0;
		Iterator<BoardDTO> it = list.iterator();
		
		while(it.hasNext()) {
			BoardDTO dto = it.next();
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String list_url = cp + "/board/list.do";
		String view_url = cp + "/board/view.do?page=" + current_page;
		
		String paging = util.paging(current_page, total_page, list_url);
		
		req.setAttribute("list", list);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("view_url", view_url);
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
		
		int boardNum = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		
		BoardDTO dto = new BoardDTO();
		
		dto = dao.readBoard(boardNum);
		
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		
		forward(req, resp, "/WEB-INF/views/board/article.jsp");
	}
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정폼
		forward(req, resp, "/WEB-INF/views/board/created.jsp");
	}
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정완료
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
	protected void replyForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//답글 폼
		forward(req, resp, "/WEB-INF/views/board/created.jsp");
	}
	protected void replySubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 답글 완료
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 삭제
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}


}
