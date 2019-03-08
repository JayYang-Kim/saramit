package com.pass;

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

@WebServlet("/pass_board/*")
public class Pass_BoardServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		} else if (uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		} else if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}

	}
	

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�Խù� ����Ʈ
		String cp = req.getContextPath();
		
		Pass_boardDAO dao = new Pass_boardDAO();
		MyUtil util = new MyUtil();
		
		String page=req.getParameter("page");
		int current_page=1;
		if(page!=null)
			current_page=Integer.parseInt(page);
		
		//�˻�
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="companyName";
			searchValue="";
		}
		
		//GET ����� ��� ���ڵ�
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue=URLDecoder.decode(searchValue, "utf-8");
		}
		
		//��ü ������ ����
		int dataCount;
		if(searchValue.length()==0)
			dataCount=dao.dataCount();
		else
			dataCount=dao.dataCount(searchKey, searchValue);
		
		//��ü ������ ��
		int rows=10;
		int total_page=util.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		//�Խù� ������ ���۰� ��
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		//�Խù� ��������
		List<Pass_BoardDTO> list=null;
		if(searchValue.length()==0)
			list=dao.listBoard(start, end);
		else
			list=dao.listBoard(start, end, searchKey, searchValue);
			
		//����Ʈ �۹�ȣ �����
		int listNum, n=0;
		Iterator<Pass_BoardDTO>it = list.iterator();
		while(it.hasNext()) {
			Pass_BoardDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		//�˻��� ���ڵ�
		String query="";
		if(searchValue.length()!=0) {
			searchValue=URLEncoder.encode(searchValue, "utf-8");
			query="searchKey="+searchKey+"&searchValue="+searchValue;
		}
		
		//����¡ ó��
		String listUrl=cp+"/pass_board/list.do";
		String articleUrl=cp+"/pass_board/acticle.do?page="+current_page;
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl+="&"+query;
		}
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		//JSP�� �������� �Ӽ�
		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("paging", paging);
		
		//JSP�� ������
		forward(req, resp, "/WEB-INF/views/pass_board/list.jsp");
	}
	
	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�� ��� ��
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/pass_board/created.jsp");
	}

	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�� ����
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Pass_boardDAO dao = new Pass_boardDAO();
		Pass_BoardDTO dto = new Pass_BoardDTO();
		
		//���ǿ� ����Ǿ��ִ� UserEmail
		dto.setUserEmail(info.getEmail());
		
		//�Ķ����
		dto.setTitle(req.getParameter("title"));
		dto.setCompanyName(req.getParameter("companyName"));
		dto.setField(req.getParameter("field"));
		dto.setGubun(req.getParameter("selectGubun"));
		dto.setContent(req.getParameter("content"));
		
		dao.insertBoard(dto);
		
		resp.sendRedirect(cp+"/pass_board/list.do");
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/pass_board/created.jsp");
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//�ۺ���
		String cp = req.getContextPath();
		Pass_boardDAO dao = new Pass_boardDAO();
		MyUtil myUtil = new MyUtil();
		
		int num=Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="subject";
			searchValue="";
		}
		
		searchValue=URLDecoder.decode(searchValue, "utf-8");
		
		String query="page="+page;
		if(searchValue.length()!=0) {
			query+="&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
		}
		
		//��ȸ�� ����
		dao.updateHitCount(num);
		
		//�Խù� ��������
		Pass_BoardDTO dto=dao.readBoard(num);
		if(dto==null) {
			resp.sendRedirect(cp+"/pass_board/list.do?page="+page);
			return;
		}
		dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		
		//JSP�� �������� �Ӽ�
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("query", query);
		
		forward(req, resp, "/WEB-INF/views/pass_board/article.jsp");
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
	
}
