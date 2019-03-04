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
		//list���� �Ѿ �� �ִ� ������ �� ó���ؾ��ϴ� ��
		//list -> list �˻����� �ִ� ���
		//list -> list �˻����� �ִ� ���¿��� �����Ǵ� ���������� ������ �°��
		//list -> list �˻��� ���� ���� �Ǵ� ���������� ������ �� ���
		//list -> list �ٽ� ȸ��˻� ������ ������ ���
		//list -> info ȸ�� ������ ������ �Ѿ�� ���
		//�� �̿ܿ��� ó������ �ʿ� ����
		
		//�⺻ ������
		String cp = req.getContextPath();
		CompaniesDAO dao = new CompaniesDAO();
		MyUtil util = new MyUtil();
		
		//�ʿ��� ������ ����
		String page = req.getParameter("page");
		int current_page = 1;
		if(page != null) {
			current_page = Integer.parseInt(page);
		}
		//������ ������ uri
		String url = cp+"/companies/list.do"; //�ٽ� ����Ʈ�� ���� ����� �ּ�
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		
		//�˻��� ���ڵ� & �ּ� ó��
		if(searchKey != null && searchValue != null) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
			url += "&searchKey="+searchKey+"&searchValue="+searchValue;
		}
		
		//����¡ �۾� 
		int rows = 12;
		int dataCount = dao.totData(searchKey, searchValue);
		int total_page = util.pageCount(rows, dataCount);
		
		if(current_page>total_page) {
			current_page=total_page;
		} //���� ����
		int start = (current_page-1)*rows +1;
		int end = current_page*rows;
		
		
		//ȸ�� ����Ʈ(�˻�)
		List<CompaniesDTO> list = dao.listCompanies(start, end, searchKey, searchValue);
		String paging = util.paging(current_page, total_page, url);
		
		req.setAttribute("page", current_page);
		req.setAttribute("companies", list);
		req.setAttribute("paging", paging);
		req.setAttribute("dataCount", dataCount);
		forward(req, resp, "/WEB-INF/views/companies/list.jsp");
	}
	protected void review(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//ȸ�� ��
	}
	protected void info(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//ȸ�� �Ұ�
		String email = req.getParameter("email");
		email = URLDecoder.decode(email, "utf-8");
		CompaniesDAO dao = new CompaniesDAO();
		CompaniesDTO dto = dao.readCompany(email);
		req.setAttribute("company", dto);
		forward(req,resp,"/WEB-INF/views/companies/info.jsp");
	}
}
