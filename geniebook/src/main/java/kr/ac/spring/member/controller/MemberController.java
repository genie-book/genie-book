package kr.ac.spring.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.ac.spring.cart.service.CartService;
import kr.ac.spring.cart.vo.CartVO;
import kr.ac.spring.history.service.HistoryService;
import kr.ac.spring.member.service.MemberService;
import kr.ac.spring.member.vo.AddrVO;
import kr.ac.spring.member.vo.MemberVO;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CartService cartService;
	@Autowired
	private HistoryService historyService;

	@RequestMapping(value = "/login", method = { RequestMethod.POST, RequestMethod.GET })
	public String login(HttpServletRequest request, @RequestParam(value = "error", required = false) String error,
			Model model) {
		System.out.println(request.getServletPath());
		if (error != null) {
			model.addAttribute("errorMsg", "아이디 혹은 비밀번호가 일치하지 않습니다.");
		}

		return "login";
	}

//---------------------여기까지 로그인--------------------------------------------------
	@RequestMapping("/registerForm_member")
	public String userRegisterForm(HttpServletRequest request) {
		System.out.println(request.getServletPath());

		return "registerForm_member";
	}

	@RequestMapping(value = "/registerMember", method = RequestMethod.POST)
	public String registerMember(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request,
			Model model) {
		System.out.println(request.getServletPath());

		String message = "";

		AddrVO addrVO = new AddrVO();
		addrVO.setId(memberVO.getId());
		addrVO.setAddr_num(request.getParameter("addr_num"));
		addrVO.setAddr_road(request.getParameter("addr_road"));
		addrVO.setAddr_detail(request.getParameter("addr_detail"));

		if (memberVO.getPassword().equals(request.getParameter("password2"))) {
			memberVO.setAuthority("ROLE_USER");
			memberVO.setEnabled(1);
			memberVO.setPoint(0);
			memberVO.setAcc_Price(0);
			
			memberService.addMember(memberVO, addrVO);
			
			cartService.addCart(memberService.selectUserInfo(memberVO.getId()).getCartId_mem());
			
			return "redirect:/";

		} else {

			message = "<script>";
			message += " alert('비밀번호를 확인해주세요.');";
			message += " </script>";

			model.addAttribute("memberVO", memberVO);
			model.addAttribute("addrVO", addrVO);
			model.addAttribute("message", message);

			return "registerForm_member";
		}
	}

	@RequestMapping(value = "/registerMember/overlapped.do", method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println(request.getServletPath());
		ResponseEntity resEntity = null;
		String result = memberService.overlapped(id);
		System.out.println(result);
		resEntity = new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
//---------------------여기까지 회원가입--------------------------------------------------

	@RequestMapping(value = { "/memberInfo_ui", "/pwdCheck", "/pwdCheck_delete",
			"/updateForm_member" }, method = RequestMethod.GET)
	public String selectUserInfo(Model model, HttpServletRequest request) {
		MemberVO memberVO = new MemberVO();
		AddrVO addrVO = new AddrVO();
		Authentication authentivation = SecurityContextHolder.getContext().getAuthentication();

		String id = authentivation.getName();

		memberVO = memberService.selectUserInfo(id);
		addrVO = memberService.selectUserInfo_Addr(id);

		model.addAttribute("memberVO", memberVO);
		model.addAttribute("addrVO", addrVO);

		System.out.println(request.getServletPath());
		if (request.getServletPath().equals("/memberInfo_ui")) {
			/* 개인정보 ui */
			
			return "memberInfo_ui";
		} else if (request.getServletPath().equals("/pwdCheck")) {
			/* 개인정보 접근 비밀번호 체크 */
			return "pwdCheck";
		} else if (request.getServletPath().equals("/pwdCheck_delete")) {
			/* 개인정보 접근 비밀번호 체크 */
			return "pwdCheck_delete";
		} else {
			/* 개인정보 수정폼 */
			System.err.println("test: " + memberVO.getReceive_email());
			return "updateForm_member";
		}

	}

	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public String updateMember(@RequestParam("password2") String password2,
			@ModelAttribute("memberVO") MemberVO memberVO, @ModelAttribute("addrVO") AddrVO addrVO,
			HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {

		System.out.println(request.getServletPath());

		String message = "";

		if (memberVO.getPassword().equals(password2)) {

			if (!memberVO.getPassword().equals("") && !password2.equals("")) {

				memberService.updateMember(memberVO, addrVO);

				message = "<script>";
				message += " alert('회원정보 수정이 완료되었습니다. 다시 로그인 해주세요');";
				message += " location.href='" + request.getContextPath() + "/login';";
				message += " </script>";

				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				if (auth != null) {
					new SecurityContextLogoutHandler().logout(request, response, auth);
				}

				model.addAttribute("message", message);
				return "login";
			} else {
				memberService.updateMember(memberVO, addrVO);
				return "redirect:/";
			}
		} else {
			message = "<script>";
			message += " alert('비밀번호를 확인해주세요.');";
			message += " </script>";

			model.addAttribute("memberVo", memberVO);
			model.addAttribute("addrVo", addrVO);
			model.addAttribute("message", message);

			return "updateForm_member";
		}
	}

	@RequestMapping("/deleteMember.do/{id}")
	public String deleteMember(@PathVariable("id") String id, HttpServletRequest request,
			HttpServletResponse response) {

		System.out.println(request.getServletPath());
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		memberService.deleteMember(id);
		cartService.deleteCart(memberService.selectUserInfo(id).getCartId_mem());
		historyService.deleteHistory(memberService.selectUserInfo(id).getCartId_mem());

		return "redirect:/";
	}

//---------------------여기까지 유저정보 수정--------------------------------------------------
	@RequestMapping(value = { "/findIdPwd", "/findId", "/findPwd" })
	public String findIdPwd(HttpServletRequest request, Model model) {
		System.out.println(request.getServletPath());

		if (request.getServletPath().equals("/findPwd"))
			return "findPwd";
		else if (request.getServletPath().equals("/findId")) {
			return "findId";
		} else {
			return "findIdPwd";
		}
	}

	@RequestMapping(value = "/findPwd.do", method = RequestMethod.POST)
	public String findPwdUpdate(HttpServletRequest request, Model model) {
		System.out.println(request.getServletPath());
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");
		String message = "";
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("비밀번호 1:" + password);
		System.out.println("비밀번호 2:" + password2);
		if (password.equals(password2)) {
			System.out.println("비밀번호 서로 같음");
			map.put("id", id);
			map.put("password", password);
			memberService.updatePwdById(map);

			message = "<script>";
			message += " window.close();";
			message += " </script>";
			model.addAttribute("message", message);
			return "findPwd";
		} else {
			System.out.println("비밀번호 서로 다름");
			message = "<script>";
			message += " alert('입력한 정보를 확인해주세요.');";
			message += " </script>";
			model.addAttribute("message", message);
			return "findPwd_success";
		}
	}

	@RequestMapping(value = { "/findId_chk", "/findPwd_chk" })
	public String findIdPwd_chk(HttpServletRequest request, Model model) {
		System.out.println(request.getServletPath());
		String message = "";
		if (request.getServletPath().equals("/findPwd_chk")) {
			String id = request.getParameter("id");
			String pwHint = request.getParameter("pwHint");
			String pwHintAns = request.getParameter("pwHintAns");
			System.out.println("pwhint: " + pwHintAns);
			MemberVO memberVO = memberService.selectUserInfo(id);
			if (pwHint.equals(memberVO.getPwHint()) && pwHintAns.equals(memberVO.getPwHintAns())) {
				model.addAttribute("id", id);
				return "findPwd_success";
			} else {
				message = "<script>";
				message += " alert('입력한 정보를 확인해주세요.');";
				message += " </script>";
				model.addAttribute("message", message);
				return "findPwd";
			}

		} else if (request.getServletPath().equals("/findId_chk")) {
			String name = request.getParameter("name");
			String jumin = request.getParameter("jumin1") +"-" +request.getParameter("jumin2");
			System.out.println("id]: "+ name);
			System.out.println("id]: "+ jumin);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("name", name);
			map.put("jumin", jumin);
			MemberVO memberVO = memberService.selectUserNameInfo(map);
			
			if (memberVO != null) {
				System.out.println(memberVO.getId());
				model.addAttribute("memberVO", memberVO);
				return "findId_success";
			}
			else {
				message = "<script>";
				message += " alert('입력한 정보를 확인해주세요.');";
				message += " </script>";
				model.addAttribute("message", message);
				
				return "findId";
			}
		} else {
			return "findIdPwd";
		}
	}
}
