package com.board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.main.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/notification/*")
public class NotificationServlet extends MyServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String pathname;
	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		// AJAX에서 로그인이 안된 경우 403이라는 에러 코드를 던진다.
		String header=req.getHeader("AJAX");
		if(header!=null && header.equals("true")  && info==null) {
				resp.sendError(403);
				return;
		}
			
		// AJAX가 아닌 경우에 로그인이 안된 경우
		if(info==null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		String root = session.getServletContext().getRealPath("/");
		pathname = root+File.separator+"uploads"+File.separator+"notification";
		File f = new File(pathname);
		if(!f.exists()) {
			f.mkdirs();
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
		}else if(uri.indexOf("delete.do") != -1){
			delete(req, resp);
		}else if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		}else if(uri.indexOf("download.do") != -1) {
			download(req, resp);
		}
}
	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파일 다운로드
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		NotificationDAO dao=new NotificationDAO();
		String cp=req.getContextPath();
		
		if(info==null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		int boardNum=Integer.parseInt(req.getParameter("boardNum"));
		String page=req.getParameter("page");
		
		NotificationDTO dto=dao.readNotification(boardNum);
		if(dto==null) {
			resp.sendRedirect(cp+"/notification/list.do"+page);
			return;
		}
		
		boolean b = FileManager.doFiledownload(dto.getSaveFileName(),
				dto.getOriginalFileName(), pathname, resp);
		
		if(! b) {
			resp.setContentType("text/html;charset=utf-8");
	    	PrintWriter pw=resp.getWriter();
	    	pw.print("<script>alert('파일다운로드가 실패했습니다. !!!');history.back();</script>");
	    	return;
		}
	}
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		NotificationDAO dao=new NotificationDAO();
		String cp=req.getContextPath();
		
		if(info==null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		int num=Integer.parseInt(req.getParameter("boardNum"));
		String page=req.getParameter("page");
		
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey != null && searchValue != null) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
	
		
		// 게시물 가져오기
		NotificationDTO dto=dao.readNotification(num);
		if(dto==null) {
			resp.sendRedirect(cp+"/notification/list.do?page="+page);
			return;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		// 이전글/다음글
		NotificationDTO preReadDto = dao.readPrevNotification(num, searchKey, searchValue);
		NotificationDTO nextReadDto = dao.readNextNotification(num, searchKey, searchValue);
		if(preReadDto != null) {
			System.out.println(preReadDto.getSubject());
		}
		if(nextReadDto != null) {
			System.out.println(nextReadDto.getSubject());
		}
		String query="page="+page;
		if(searchValue != null) {
			query+="&searchKey="+searchKey;
			query+="&searchValue="+URLEncoder.encode(searchValue, "utf-8");
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);
		req.setAttribute("query", query);
		req.setAttribute("page", page);
		
		forward(req, resp, "/WEB-INF/views/notification/article.jsp");
		
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		//글 리스트
				//기본 세팅
				String cp = req.getContextPath();
				MyUtil util = new MyUtil();
				NotificationDAO dao = new NotificationDAO();
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
				String list_url = cp+"/notification/list.do";
				String article_url = cp+"/notification/article.do?page="+current_page;
				ArrayList<NotificationDTO> list;
				if(searchKey != null && searchValue != null) {
					list_url += "?searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
					article_url += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
					list = dao.listNotification(start,end,searchKey,searchValue);
				}else {
					list = dao.listNotification(start, end,"","");
				}
				//리스트 번호 만들기
				int n = 0;
				Date endDate = new Date();
				long gap;
				for(NotificationDTO dto : list) {
					dto.setListNum(dataCount-((current_page-1)*rows)-n);
					try {
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
						Date beginDate = format.parse(dto.getCreated());
						gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
						dto.setGap(gap);
					}catch (Exception e) {
						System.out.println(e.toString());
					}
					dto.setCreated(dto.getCreated().substring(0,10));
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
				forward(req, resp, "/WEB-INF/views/notification/list.jsp");
	}

	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		NotificationDAO dao = new NotificationDAO();
		String cp = req.getContextPath();

		/*
		 * if(info==null && !info.getEmail().equals("admin")) {
		 * resp.sendRedirect(cp+"/member/login.do"); return; }
		 */
		
		String encType = "utf-8";
		int maxFileSize = 5*1024*1024;
		
		NotificationDTO dto = new NotificationDTO();
		MultipartRequest mreq = new MultipartRequest(req,pathname,maxFileSize,encType,new DefaultFileRenamePolicy());
		dto.setName(info.getName());
		dto.setEmail(info.getEmail());
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		if(mreq.getFile("upload")!=null) {
			dto.setSaveFileName(mreq.getFilesystemName("upload"));
			dto.setOriginalFileName(mreq.getOriginalFileName("upload"));
			dto.setFileSize(mreq.getFile("upload").length());
		}
		dao.insertNotification(dto);
		resp.sendRedirect(cp+"/notification/list.do");
	}

	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		/*
		 * HttpSession session = req.getSession(); SessionInfo info =
		 * (SessionInfo)session.getAttribute("member");
		 */

		
		/*
		 * if(info==null && !info.getEmail().equals("admin")) {
		 * resp.sendRedirect(cp+"/member/login.do"); return; }
		 */
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/notification/created.jsp");
	}
}
