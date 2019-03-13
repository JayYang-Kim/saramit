package com.main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.NotificationDAO;
import com.board.NotificationDTO;
import com.companies.CompaniesDAO;
import com.companies.CompaniesDTO;
import com.util.MyServlet;
@WebServlet("/main.do")
public class MainServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();
		
		if(uri.indexOf("main.do") != -1) {
			display(req,resp);
		}
	}

	private void display(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		CompaniesDAO dao = new CompaniesDAO();
		List<CompaniesDTO> recentList = dao.recentCompanies();
		NotificationDAO ndao = new NotificationDAO();
		List<NotificationDTO> recentNoti = ndao.listNotification(1, 5, "", "");
		for(NotificationDTO dto : recentNoti) {
			dto.setCreated(dto.getCreated().substring(0,10));
		}
		req.setAttribute("recentCompanies", recentList);
		req.setAttribute("recentNotifications", recentNoti);
		forward(req, resp, "/WEB-INF/views/main/main.jsp");
	}
	
}
