package review.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;

import common.MyFileRenamePolicy;
import member.model.vo.Member;
import review.model.service.ReviewService;
import review.model.vo.Review;
import review.model.vo.ReviewAttachment;

/**
 * Servlet implementation class ReviewUpdateServlet
 */
@WebServlet("/reviewUpdate.re")
public class ReviewUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 1024*1024*10;	
			String root = request.getSession().getServletContext().getRealPath("/");
			String savePath = root + "review_uploadFiles/";
			
			File f = new File(savePath);
			if(!f.exists()) {
				f.mkdirs();
			}
		  
			MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
		
			ArrayList<String> originFiles = new ArrayList<String>();	// 파일의 원래 이름을 저장할 공간
			ArrayList<String> saveFiles = new ArrayList<String>();		// 파일의 바뀐 이름을 저장할 공간
			
			Enumeration<String> files = mr.getFileNames(); 
			
			while(files.hasMoreElements()) {
				String name = files.nextElement();
				
				if(mr.getFilesystemName(name) != null) {
					originFiles.add(mr.getOriginalFileName(name));
					saveFiles.add(mr.getFilesystemName(name));
				}
			}
			
			ArrayList<ReviewAttachment> fileList = new ArrayList<ReviewAttachment>();
			
			int rNo = Integer.parseInt(mr.getParameter("rNo"));
			int gNo = Integer.parseInt(mr.getParameter("gNo"));
			
			if(originFiles.size() == 1) {
				ReviewAttachment ra = new ReviewAttachment();
				ra.setR_file_path(savePath);
				ra.setR_origin_name(originFiles.get(0));
				ra.setR_change_name(saveFiles.get(0));
				ra.setR_no(rNo);
				
				fileList.add(ra);
			}
			
			if(originFiles.size() > 1) {
				for(int i = 1; i >= 0; i--) {
					ReviewAttachment ra = new ReviewAttachment();
					ra.setR_file_path(savePath);
					ra.setR_origin_name(originFiles.get(i));
					ra.setR_change_name(saveFiles.get(i));
					ra.setR_no(rNo);
					
					fileList.add(ra);
				}
				
				for(int i = originFiles.size()-1; i >= 2; i--) {
					ReviewAttachment ra = new ReviewAttachment();
					ra.setR_file_path(savePath);
					ra.setR_origin_name(originFiles.get(i));
					ra.setR_change_name(saveFiles.get(i));
					ra.setR_no(rNo);
					
					fileList.add(ra);
				}
			}
			
			Member loginUser = ((Member)request.getSession().getAttribute("loginUser"));
			String name = loginUser.getM_name();
			int no = loginUser.getM_no();
			int totalStar = Integer.parseInt(mr.getParameter("totalStar"));
			int facilityStar =  Integer.parseInt(mr.getParameter("facilityStar"));
			int instructorStar =  Integer.parseInt(mr.getParameter("instructorStar"));
			int serviceStar =  Integer.parseInt(mr.getParameter("serviceStar"));
			int priceStar =  Integer.parseInt(mr.getParameter("priceStar"));
			String keywordArr[] = mr.getParameterValues("keyword");
			String reviewText = mr.getParameter("reviewText");
			
			String keyword = "";
			if(keywordArr != null) {
				for(int i = 0; i < keywordArr.length; i++) {
					if(i == keywordArr.length-1) {
						keyword += keywordArr[i];
					} else {
						keyword += keywordArr[i] + ", ";
					}
				}
			}
			
			Review r = new Review();
			r.setR_no(rNo);
			r.setR_body(reviewText);
			r.setR_total(totalStar);
			r.setR_teacher(instructorStar);
			r.setR_service(serviceStar);
			r.setR_gym(facilityStar);
			r.setR_price(priceStar);
			r.setR_keyword(keyword);
			r.setReviewerName(name);
			r.setReviewerNo(no);
			
			int result = new ReviewService().updateReview(fileList, r);
			
			if(result > 0) {
				response.sendRedirect("detail.do?gNo="+gNo);
				response.getWriter().println(result);
				
			} else {
				for(int i = 0; i < saveFiles.size(); i++) {
					File fail = new File(savePath + saveFiles.get(i));
					fail.delete();
				}
				request.setAttribute("msg", "리뷰 수정에 실패하였습니다.");
				request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
			}
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
