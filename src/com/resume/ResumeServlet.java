package com.resume;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.main.SessionInfo;
import com.util.MyServlet;

@WebServlet("/resume/*")
public class ResumeServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		String uri = req.getRequestURI();

		if (uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		} else if (uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		} else if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("view.do") != -1) {
			view(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//내가 작성한 이력서 목록 출력
		forward(req, resp, "/WEB-INF/views/resume/list.jsp");
	}

	protected void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 작성폼
		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 작성완료
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//익력서 수정
		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 수정완료
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}

	protected void view(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 보기
		forward(req, resp, "/WEB-INF/views/resume/created.jsp");
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이력서 삭제
		String cp = req.getContextPath();
		resp.sendRedirect(cp);
	}
}
