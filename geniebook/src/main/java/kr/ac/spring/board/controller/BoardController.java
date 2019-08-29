package kr.ac.spring.board.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.spring.board.service.BoardService;
import kr.ac.spring.board.vo.BoardVO;
import kr.ac.spring.board.vo.Pagination;

@Controller("boardController")
public class BoardController {

	private static final String BOARD_IMAGE_REPO = "resource/images/upload";
	@Autowired
	private BoardService boardService;
	//, method = { RequestMethod.GET, RequestMethod.POST }
	@RequestMapping(value = "/board/listboards", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listBoards(@RequestParam(value="page", required = false, defaultValue="1") int page, @RequestParam(value="range", required = false, defaultValue="1") int range, HttpServletRequest request, HttpServletResponse response, Model model, @ModelAttribute("boardVO") BoardVO boardVO) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		String id = authentication.getName();
		
		//전체 게시글 갯수
		int listCnt = boardService.getBoardListCnt();
		
		//Pagination 객체 생성
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, listCnt);
		
		//model.addAttribute("pagination",pagination);
		//model.addAttribute("boardList",boardService.listBoards(pagination));
		model.addAttribute("id",id);
		
		List<BoardVO> boardList = boardService.listBoards(pagination);
		ModelAndView mav = new ModelAndView("listboards");
		mav.addObject("boardlist", boardList);
		mav.addObject("pagination", pagination);
		return mav;
	}

	@RequestMapping("/board/boardForm")
	public String boardForm(Model model) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String id = authentication.getName();
		System.out.println("id chk  : " + id);
		model.addAttribute("memberId", id);
		return "boardForm";
	}
	
	@RequestMapping("/board/replyForm")
	public String replyForm(@ModelAttribute("boardVO") BoardVO boardVO, Model model, HttpServletRequest request) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String id = authentication.getName();
		System.out.println("id chk  : " + id);
		model.addAttribute("memberId", id);
		model.addAttribute("originNo",request.getParameter("originNo"));
		model.addAttribute("groupOrd",request.getParameter("groupOrd"));
		model.addAttribute("groupLayer",request.getParameter("groupLayer"));
		return "replyForm";
	}

	@RequestMapping(value = "/board/addBoard")
	public ModelAndView addBoard(@ModelAttribute("boardVO") BoardVO boardVO, MultipartHttpServletRequest request,
			HttpServletResponse response, MultipartFile uploadFile) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration enu = request.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			// System.out.println(name+", "+value);
			map.put(name, value);
		}
		String imageFileName = upload(request);
		map.put("imageFileName", imageFileName);
		if (imageFileName != null)
			boardVO.setImageFileName(imageFileName);
		else
			boardVO.setImageFileName(null);
		//System.out.println(request.getParameter("originNo"));
		//boardVO.setOriginNo(Integer.parseInt(request.getParameter("boardId")));
		boardVO.setGroupOrd(0);
		boardVO.setGroupLayer(0);
		ModelAndView mav = new ModelAndView("redirect:/board/listboards");
		int result = 0;
//		if (uploadFile != null)
//			boardVO.setImageFileName(uploadFile.getOriginalFilename());
//		else
//			boardVO.setImageFileName(null);
		result = boardService.addBoard(boardVO);

		return mav;
	}
	
	@RequestMapping(value = "/board/replyBoard")
	public ModelAndView replyBoard(@ModelAttribute("boardVO") BoardVO boardVO, MultipartHttpServletRequest request,
			HttpServletResponse response, MultipartFile uploadFile) throws Exception {
		request.setCharacterEncoding("utf-8");
		String str = "";
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration enu = request.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			// System.out.println(name+", "+value);
			map.put(name, value);
		}
		String imageFileName = upload(request);
		map.put("imageFileName", imageFileName);
		if (imageFileName != null)
			boardVO.setImageFileName(imageFileName);
		else
			boardVO.setImageFileName(null);
		System.out.println("zzz" + boardVO.getGroupOrd());
		boardVO.setOriginNo(Integer.parseInt(request.getParameter("originNo")));
		boardVO.setGroupOrd(Integer.parseInt(request.getParameter("groupOrd"))+1);
		boardVO.setGroupLayer(Integer.parseInt(request.getParameter("groupLayer"))+1);
		
		for(int i=0;i<boardVO.getGroupLayer();i++) {
			str += " ";
		}
		boardVO.setTitle(" RE : " + boardVO.getTitle());
		ModelAndView mav = new ModelAndView("redirect:/board/listboards");
		int result = 0;
//		if (uploadFile != null)
//			boardVO.setImageFileName(uploadFile.getOriginalFilename());
//		else
//			boardVO.setImageFileName(null);
		result = boardService.replyBoard(boardVO);

		return mav;
	}

	@RequestMapping("/board/updateBoard")
	public ModelAndView updateBoard(@ModelAttribute("boardVO") BoardVO boardVO, MultipartHttpServletRequest request,
			HttpServletResponse response, MultipartFile uploadFile) throws Exception {
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView("redirect:/board/listboards");
		int result = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration enu = request.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			// System.out.println(name+", "+value);
			map.put(name, value);
		}
		//System.out.println("zzz " + request.getParameter("mod_file"));
		String imageFileName = upload(request);
		map.put("imageFileName", imageFileName);
		if (imageFileName != null)
			boardVO.setImageFileName(imageFileName);
		else
			boardVO.setImageFileName(null);
		//System.out.println(boardVO.getOriginNo());
		//boardVO.setTitle(request.getParameter("title"));
//		if(request.getParameter("mod_file") != null)
//			boardVO.setImageFileName(request.getParameter("mod_file"));
//		else
//			boardVO.setImageFileName(request.getParameter("uploadFile"));
		result = boardService.updateBoard(boardVO);

		return mav;
	}

	@RequestMapping(value = "/board/viewBoard", method = RequestMethod.GET)
	public ModelAndView viewBoard(@RequestParam("boardId") int boardId, HttpServletRequest request,
			HttpServletResponse response, HttpSession session, Model model) throws Exception {
		// String viewName = (String)request.getAttribute("viewName");
		boardService.increaseViewCnt(boardId, session);
		Authentication authentivation = SecurityContextHolder.getContext().getAuthentication();
		String id = authentivation.getName();
		model.addAttribute("id",id);
		BoardVO boardVO = boardService.viewBoard(boardId);
		ModelAndView mav = new ModelAndView("viewBoard");
		mav.addObject("boardVO", boardVO);
		return mav;
	}

	@RequestMapping("/board/deleteBoard")
	public String deleteBoard(@RequestParam("originNo") int originNo, @RequestParam("groupLayer") int groupLayer, Model model) throws Exception {
		int result = 0;
		Map<String, Object> parameters = new HashMap<String, Object>();
	    parameters.put("originNo", originNo);
	    parameters.put("groupLayer", groupLayer);
		result = boardService.deleteBoard(parameters);
		return "redirect:/board/listboards";
	}


	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		String imageFileName = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		String path = multipartRequest.getSession().getServletContext().getRealPath(BOARD_IMAGE_REPO);
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName = mFile.getOriginalFilename();
			File file = new File(path + "/" + fileName);
			if (mFile.getSize() != 0) { // File Null Check
				if (!file.exists()) { // 경로 상에 파일이 존재하지 않다면
					if (file.getParentFile().mkdirs()) { // 파일의 경로에 해당하는 디렉토리를 모두 생성(mkdirs는 경로상 폴더를 모두 만들어줌)
						file.createNewFile(); // 파일 생성
					}
				}
				mFile.transferTo(new File(path + "/" + imageFileName)); // 파일을 이동시킨다.
			}
		}
		return imageFileName;
	}
	
	private String delete(MultipartHttpServletRequest multipartRequest, String deleteFileName) throws Exception {
		String imageFileName = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		String path = multipartRequest.getSession().getServletContext().getRealPath(BOARD_IMAGE_REPO);
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName = mFile.getOriginalFilename();
			File file = new File(path + "/" + fileName);
			if (mFile.getSize() != 0) { // File Null Check
				if (!file.exists()) { // 경로 상에 파일이 존재하지 않다면
					if (file.getParentFile().mkdirs()) { // 파일의 경로에 해당하는 디렉토리를 모두 생성(mkdirs는 경로상 폴더를 모두 만들어줌)
						file.createNewFile(); // 파일 생성
					}
				}
				mFile.transferTo(new File(path + "/" + imageFileName)); // 파일을 이동시킨다.
			}
		}
		return imageFileName;
	}
	
	@RequestMapping(value = "/Q&A/{id}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listBoardById(@RequestParam(value="page", required = false, defaultValue="1") int page,
			@RequestParam(value="range", required = false, defaultValue="1") int range, HttpServletRequest request,
			HttpServletResponse response, Model model, @ModelAttribute("boardVO") BoardVO boardVO, @PathVariable("id") String id) throws Exception {
	
		//전체 게시글 갯수
		int listCnt = boardService.getBoardListCntById(id);
		
		//Pagination 객체 생성
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, listCnt);
		
		model.addAttribute("id",id);
		
		List<BoardVO> boardList = boardService.listBoardById(pagination,id);
		ModelAndView mav = new ModelAndView("listboardById");
		mav.addObject("boardlist", boardList);
		mav.addObject("pagination", pagination);
		return mav;
	}
}