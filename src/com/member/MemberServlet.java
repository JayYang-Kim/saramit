package com.member;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.companies.CompaniesDTO;
import com.main.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.resume.ResumeDAO;
import com.resume.ResumeDTO;
import com.util.FileManager;
import com.util.MyServlet;

@WebServlet("/member/*")
public class MemberServlet extends MyServlet {
	private static final long serialVersionUID = 1L;
	
	private String pathname;
	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		HttpSession session=req.getSession();
		
		// �̹����� ������ ���
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "photo";
		
		File f = new File(pathname);
		
		if(!f.exists()) {
			f.mkdirs();
		}
		
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

		SessionInfo info = new SessionInfo(); // �̸���, �̸�, ���/���� ������ ������ ���ǿ� ����� ��ü
		MemberDAO dao = new MemberDAO();

		if (userLevel.equals("user")) {
			UserDTO dto = dao.readUser(email);
			if(dto == null) {
				req.setAttribute("msg", "�������� �ʴ� �̸����Դϴ�.");
				forward(req, resp, "/WEB-INF/views/member/login.jsp");
				return;
			}
			if(dto != null) {
				if (dto.getUserPwd().equals(pwd)) {
					if (dto.getStatusCode() == 2) {
						req.setAttribute("msg", "Ż���� ȸ���Դϴ�.");
						forward(req, resp, "/WEB-INF/views/member/login.jsp");
						return;
					}
					session.setMaxInactiveInterval(60 * 30);
					info.setEmail(email);
					info.setLevel(dto.getLevelCode());
					info.setName(dto.getUserName());
					session.setAttribute("member", info); // ���ǿ� ����
					resp.sendRedirect(cp);
					return;
				} else {
					req.setAttribute("msg", "���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
					forward(req, resp, "/WEB-INF/views/member/login.jsp");
					return;
				}
			}
		} else {
			CompaniesDTO dto = dao.readCompany(email);
			if(dto == null) {
				req.setAttribute("msg", "�������� �ʴ� �̸����Դϴ�.");
				forward(req, resp, "/WEB-INF/views/member/login.jsp");
				return;
			}
			if (dto != null) {
				if (dto.getCompanyPwd().equals(pwd)) {
					if (dto.getStatusCode() == 2) {
						req.setAttribute("msg", "Ż���� ȸ���Դϴ�.");
						forward(req, resp, "/WEB-INF/views/member/login.jsp");
						return;
					} 
					session.setMaxInactiveInterval(60*30);
					info.setEmail(email);
					info.setLevel(dto.getLevelCode());
					info.setName(dto.getCompanyName());
					session.setAttribute("member", info);
					resp.sendRedirect(cp);
					return;
				} else {
					req.setAttribute("msg", "���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
					forward(req, resp, "/WEB-INF/views/member/login.jsp");
					return;
				}
			}
		}
		
		//resp.sendRedirect(cp + "/member/login.do");
	}

	protected void joinForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/member/join.jsp");
	}

	protected void joinSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		MemberDAO dao = new MemberDAO();
		
		String level = null;
		
		if(req.getMethod().equalsIgnoreCase("POST")) {
			level = req.getParameter("level");
			
			if(level == null) {
				level = "1";
			}
		}
		
		if(level.equals("2")) {
			UserDTO dto = new UserDTO();
			dto.setUserEmail(req.getParameter("userEmail"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setBirth(req.getParameter("birth"));
			dto.setGender(req.getParameter("gender"));
			dto.setPostCode(req.getParameter("postCode"));
			dto.setAddress(req.getParameter("address"));
			dto.setDetailAddress(req.getParameter("detailAddress"));
			dto.setExtraAddress(req.getParameter("extraAddress"));
			dto.setStatusCode(Integer.parseInt(req.getParameter("status")));
			dto.setLevelCode(Integer.parseInt(req.getParameter("level")));
			
			dao.insertUser(dto);
		} else {
			String encType = "UTF-8";
			int maxSize = 5 * 1024 * 1024;
			
			// request, ������ ������ ���, �ִ�ũ��, �Ķ���� Ÿ��, ���� ���ϸ� ��ȣ
			MultipartRequest mreq = new MultipartRequest(req, pathname, maxSize, encType, new DefaultFileRenamePolicy());
			
			CompaniesDTO dto = new CompaniesDTO();
			
			dto.setCompanyEmail(mreq.getParameter("companyEmail"));
			dto.setCompanyPwd(mreq.getParameter("companyPwd"));
			dto.setBusinessLicenseNum(mreq.getParameter("businessLicenseNum"));
			dto.setCompanyName(mreq.getParameter("companyName"));
			dto.setOwner(mreq.getParameter("owner"));
			dto.setEstablishmentDate(mreq.getParameter("establishmentDate"));
			dto.setEmployees(Integer.parseInt(mreq.getParameter("employees")));
			dto.setSale(Integer.parseInt(mreq.getParameter("employees")));
			dto.setPostCode(mreq.getParameter("postCode"));
			dto.setLocation(mreq.getParameter("location"));
			dto.setDetailLocation(mreq.getParameter("detailLocation"));
			dto.setExtraLocation(mreq.getParameter("extraLocation"));
			dto.setSalary(Integer.parseInt(mreq.getParameter("salary")));
			dto.setHomepage(mreq.getParameter("homepage"));
			if(mreq.getFile("file") != null) {
				// ������ ����� ���ϸ�
				String saveFilename = mreq.getFilesystemName("file");
				
				// ���ϸ� ����
				saveFilename = FileManager.doFilerename(pathname, saveFilename);
				dto.setSavefilename(saveFilename);
			} else {
				// �ΰ� DB�ʿ��� not null�� �ƴϱ� ������ ��Ͼ��Ҷ� �⺻ �̹����� �ٰ����� �ƴ� �ʼ� �Է��� �� ������ ȸ�� �ʿ�
			}
			dto.setIntroduction(mreq.getParameter("introduction"));
			dto.setStatusCode(Integer.parseInt(mreq.getParameter("status")));
			dto.setLevelCode(Integer.parseInt(mreq.getParameter("level")));
			
			dao.insertCompany(dto);
		}
		
		resp.sendRedirect(cp + "/member/login.do");
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		MemberDAO dao = new MemberDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info == null) {
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		String email = info.getEmail();
		int level = info.getLevel();
		
		if(level == 2) {
			UserDTO dto = dao.readUser(email);
			req.setAttribute("dto", dto);
		} else {
			CompaniesDTO dto = dao.readCompany(email);
			req.setAttribute("dto", dto);
		}
		
		forward(req, resp, "/WEB-INF/views/member/update.jsp");
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		MemberDAO dao = new MemberDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info == null) {
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		int level = info.getLevel();
		
		if(level == 2) {
			UserDTO dto = new UserDTO();
			
			dto.setUserEmail(req.getParameter("og_email"));
			dto.setUserPwd(req.getParameter("userPwd"));
			if(dto.getUserPwd().equals("")) {
				dto.setUserPwd(req.getParameter("og_pwd"));
			}
			dto.setUserName(req.getParameter("userName"));
			dto.setPostCode(req.getParameter("postCode"));
			dto.setAddress(req.getParameter("address"));
			dto.setDetailAddress(req.getParameter("detailAddress"));
			dto.setExtraAddress(req.getParameter("extraAddress"));
			dto.setBirth(req.getParameter("birth"));
			
			dao.updateUserInfo(dto);
		} else {
			String encType = "UTF-8";
			int maxSize = 5 * 1024 * 1024;
			
			// request, ������ ������ ���, �ִ�ũ��, �Ķ���� Ÿ��, ���� ���ϸ� ��ȣ
			MultipartRequest mreq = new MultipartRequest(req, pathname, maxSize, encType, new DefaultFileRenamePolicy());
			
			CompaniesDTO dto = new CompaniesDTO();
			
			dto.setCompanyEmail(mreq.getParameter("og_email"));
			dto.setCompanyPwd(mreq.getParameter("companyPwd"));
			if(dto.getCompanyPwd().equals("")) {
				dto.setCompanyPwd(mreq.getParameter("og_pwd"));
			}
			dto.setBusinessLicenseNum(mreq.getParameter("businessLicenseNum"));
			dto.setCompanyName(mreq.getParameter("companyName"));
			dto.setOwner(mreq.getParameter("owner"));
			dto.setEmployees(Integer.parseInt(mreq.getParameter("employees")));
			dto.setSale(Integer.parseInt(mreq.getParameter("sale")));
			dto.setPostCode(mreq.getParameter("postCode"));
			dto.setLocation(mreq.getParameter("location"));
			dto.setDetailLocation(mreq.getParameter("detailLocation"));
			dto.setExtraLocation(mreq.getParameter("extraLocation"));
			dto.setSalary(Integer.parseInt(mreq.getParameter("salary")));
			dto.setHomepage(mreq.getParameter("homepage"));
			dto.setSavefilename(mreq.getParameter("og_saveFilename"));
			if(mreq.getFile("file") != null) {
				// ���� ���� ����
				FileManager.doFiledelete(pathname, dto.getSavefilename());
				
				// ������ ����� ���ο� ���ϸ�
				String saveFilename = mreq.getFilesystemName("file");
				
				// �̸� ����
				saveFilename = FileManager.doFilerename(pathname, saveFilename);
				
				dto.setSavefilename(saveFilename);
			}
			dto.setIntroduction(mreq.getParameter("introduction"));
			
			dao.updateCompanyInfo(dto);
		}
		
		resp.sendRedirect(cp + "/member/myPage.do");
	}

	protected void myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		ResumeDAO dao = new ResumeDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		String email = info.getEmail();
		int level = info.getLevel();

			if (level ==2) {
				List<ResumeDTO> dto = dao.readResume(email);
				req.setAttribute("dto", dto);
				
			}
		req.setAttribute("level", level);
		forward(req, resp, "/WEB-INF/views/member/mypage.jsp");
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info==null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		String memberEmail=info.getEmail();
		int levelCode=info.getLevel();
		MemberDAO dao = new MemberDAO();
		dao.withdrawMember(memberEmail, levelCode);
		
		//���� ����������
		session.invalidate();
		
		resp.sendRedirect(cp + "/main.do");
	}
}
