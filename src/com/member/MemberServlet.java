package com.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.companies.CompaniesDTO;
import com.main.SessionInfo;
import com.util.MyServlet;

@WebServlet("/member/*")
public class MemberServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();
		if (uri.indexOf("login.do") != -1) {
			loginForm(req, resp);
		} else if (uri.indexOf("login_ok.do") != -1) {
			loginSubmit(req, resp);
		}else if(uri.indexOf("logout.do") != -1) {
			logout(req,resp);
		}else if (uri.indexOf("join.do") != -1) {
			joinForm(req, resp);
		} else if (uri.indexOf("join_ok.do") != -1) {
			joinSubmit(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if (uri.indexOf("myPage.do") != -1) {
			myPage(req, resp);
		}
	}

	protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		session.invalidate();
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
	
	protected void loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}

	protected void loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		
		String userLevel = req.getParameter("radioLevel");
		String email = req.getParameter("email");
		String pwd = req.getParameter("pwd");

		SessionInfo info = new SessionInfo(); // 이메일, 이름, 기업/개인 정보를 가지고 세션에 저장될 객체
		MemberDAO dao = new MemberDAO();

		if (userLevel.equals("user")) {
			UserDTO dto = dao.readUser(email);
			if (dto != null) {
				if (dto.getUserPwd().equals(pwd)) {
					/*if (dto.getStatusCode() == 2) {
						System.out.println("탈퇴한 회원");
					}*/
					session.setMaxInactiveInterval(60 * 30);
					info.setEmail(email);
					info.setLevel(dto.getLevelCode());
					info.setName(dto.getUserName());
					session.setAttribute("member", info); // 세션에 저장
					resp.sendRedirect(cp);
					return;
				}
			}
		} else {
			CompaniesDTO dto = dao.readCompany(email);
			if (dto != null) {
				if (dto.getCompanyPwd().equals(pwd)) {
					/*if (dto.getStatusCode() == 2) {
						System.out.println("탈퇴한 회원");
					}*/
					session.setMaxInactiveInterval(60 * 30);
					info.setEmail(email);
					info.setLevel(dto.getLevelCode());
					info.setName(dto.getCompanyName());
					session.setAttribute("member", info);
					resp.sendRedirect(cp);
					return;
				}
			}

		}
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}

	protected void joinForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/member/join.jsp");
	}

	protected void joinSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/member/join.jsp");
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}

	protected void myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/member/join.jsp"); // 여기 정확히 어디로 갈지 헷갈려서 냅둠
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
}
