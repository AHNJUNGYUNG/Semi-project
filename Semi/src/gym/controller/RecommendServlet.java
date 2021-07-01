package gym.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import gym.model.service.GymService;
import gym.model.vo.Gym;

/**
 * Servlet implementation class RecommendServlet
 */
@WebServlet("/recommend.me")
public class RecommendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommendServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userName = request.getParameter("userName");
		String userLike = request.getParameter("userLike");
		String locationStr = request.getParameter("location");
		String inout = request.getParameter("inout");
		String gymType = request.getParameter("gymType");
		String lecture = request.getParameter("lecture");
		String parking = request.getParameter("parking");
		
		System.out.println(userName + " : 이름");
		System.out.println(userLike + " : 선호운동");
		System.out.println(gymType + " : 단체개인");
		System.out.println(locationStr + " : 위치");
		System.out.println(lecture + " : 강습");
		System.out.println(inout + " : 실내실외");
		System.out.println(parking + " : 주차");
		
		Gym rGym = new Gym(gymType, locationStr, lecture, inout, parking);
		
		ArrayList<Gym> list = new GymService().recommendGym(rGym);
		
		for(int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		
		
		JSONArray arr = new JSONArray();
		JSONObject json = null;
		for(Gym g : list) {
			json = new JSONObject();
			json.put("gNo", g.getG_NO());
			json.put("gTypeName", g.getG_TYPE_NM());
			json.put("gName", g.getG_NAME());
			
			arr.add(json);
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().println(arr);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
