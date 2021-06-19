package gym.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import gym.model.dao.GymDAO;
import gym.model.vo.Gym;

public class GymService {

	public ArrayList<Gym> selectGym() {
		
		Connection conn = getConnection();

		ArrayList<Gym> list = new GymDAO().selectGymList(conn);
		close(conn);

		return list;
	}
	
	public ArrayList<Gym> searchGym(String keyword) {
		
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().searchGym(conn, keyword);
		close(conn);
		
		return list;
	}

	public ArrayList<Gym> selectCovidList() {
		
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().selectCovidList(conn);
		close(conn);
		
		return list;
	}

	public ArrayList<Gym> selectPopularList() {
		
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().selectPopularList(conn);
		close(conn);
		
		return list;
	}

	public ArrayList<Gym> selectRecomendList(String like) {
		
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().selectRecommendList(conn, like);
		close(conn);
		
		return list;
	}

	public ArrayList selectRandomGymList() {
		
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().selectRandomList(conn);
		close(conn);
		
		return list;
	}
}
