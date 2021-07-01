package gym.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import board.model.vo.PageInfo;
import gym.model.dao.GymDAO;
import gym.model.vo.GFile;
import gym.model.vo.Gym;
import page.model.vo.Page;

public class GymService {

	public ArrayList<Gym> selectGym(int gNo) {

		Connection conn = getConnection();

		ArrayList<Gym> list = new GymDAO().selectGym(conn, gNo);
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

	public ArrayList selectLocalList(String gu_nm) {

		Connection conn = getConnection();

		ArrayList<Gym> list = new GymDAO().selectLocalList(conn, gu_nm);
		close(conn);

		return list;
	}

	public int gEListCount() {

		Connection conn = getConnection();

		int count = new GymDAO().gEListCount(conn);

		close(conn);

		return count;
	}

	public int gListCount(String category) {
		Connection conn = getConnection();

		int count = new GymDAO().gListCount(conn, category);

		close(conn);
		return count;
	}

	public ArrayList<Gym> selectGList(String category, Page pi) {
		Connection conn = getConnection();

		ArrayList<Gym> gList = new GymDAO().selectGList(conn, pi, category);

		close(conn);

		return gList;
	}

	public ArrayList<Gym> selectGEList(Page pi) {
		Connection conn = getConnection();

		ArrayList<Gym> gList = new GymDAO().selectGEList(conn, pi);

		close(conn);

		return gList;
	}

	public ArrayList<GFile> selectGymThumbList() {

		Connection conn = getConnection();

		ArrayList<GFile> thumbList = new GymDAO().selectGymThumbList(conn);

		close(conn);

		return thumbList;
	}
	

	public ArrayList<Gym> recommendGym(Gym rGym) {
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().recommendGym(conn, rGym);
		
		close(conn);
		
		return list;
	}

	public int deleteGym(String check) {

		Connection conn = getConnection();

		int result = 0;
		GymDAO gymDAO = new GymDAO();

		String arr[] = check.split(",");
		String gNo = null;

		for (int i = 0; i < arr.length; i++) {
			gNo = arr[i];
			result = gymDAO.deleteGym(conn, gNo);

			if (result > 0) {
				commit(conn);
			} else {
				rollback(conn);
				break;
			}
		}
		close(conn);
		return result;
	}

	public ArrayList<GFile> selectGFile(int gNo) {

		Connection conn = getConnection();

		ArrayList<GFile> gFList = new GymDAO().selectGFile(conn, gNo);

		close(conn);

		return gFList;
	}

	public int updateGym(Gym g, ArrayList<GFile> fileList) {

		Connection conn = getConnection();

		GymDAO dao = new GymDAO();
		
		int result3 = 0;
		
		for(int i = 0; i < fileList.size(); i++) {
			if(fileList.get(i).getgFileNo() == -1) { // -1일 때만 이미지삽입 쿼리 실행
				result3 = dao.updateInsertGFile(conn, fileList);
				if(result3>0) {
					fileList.remove(i); // 삽입 완료 되면 해당 리스트 삭제
					commit(conn);
				} else {
					rollback(conn);
				}
			}
		}
		int result1 = dao.updateGym(conn, g);
		int result2 = dao.updateGFile(conn, fileList);
		

		System.out.println("Gymservice result1(시설 수정) : " + result1);
		System.out.println("Gymservice result2(파일 수정) : " + result2);
		System.out.println("Gymservice result3(파일 수정+삽입) : " + result3);

		if (result1 > 0 || result2 > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result1;

	}

	public int insertGym(Gym g, ArrayList<GFile> fileList) {

		Connection conn = getConnection();
		
		GymDAO dao = new GymDAO();

		int result1 = dao.insertGym(conn, g);
		int result2 = dao.insertGFile(conn, fileList);

		if (result1 > 0 && result2 > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result1;
	}

	public int getGymListCount() {
		Connection conn = getConnection();
		
		int listCount = new GymDAO().getGymListCount(conn);
		
		close(conn);
		
		return listCount;
	}

	public int getSearchGymListCount(String keyword, String category) {
		
		Connection conn = getConnection();
		
		int listCount = new GymDAO().getSearchGymListCount(conn, keyword, category);
		
		close(conn);
		
		return listCount;

	}

	public ArrayList<Gym> searchGym(String keyword, String category, PageInfo pi) {
		
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().searchGym(conn, keyword, category, pi);
		
		close(conn);
		
		return list;
	}


	public ArrayList<Gym> selectGymList(PageInfo pi) {
		
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().selectGymList(conn, pi);
		
		close(conn);
		
		return list;
	}


	public int getLocaCount(String loca) {
		Connection conn = getConnection();
		
		int count = new GymDAO().getLocaCount(conn, loca);
		
		close(conn);
		
		return count;
	}

	public ArrayList<Gym> locationList(Page pi, String loca) {
		Connection conn = getConnection();
		
		ArrayList<Gym> list = new GymDAO().locationList(conn, pi, loca);
		
		close(conn);
		return list;
	}


	
	public Gym selectGymInfo(String gNo) {
		Connection conn = getConnection();
		
		GymDAO dao = new GymDAO();
		
		int resultCount = dao.updateCount(conn, gNo);
		
		Gym g = null;
		if(resultCount > 0) {
			g = dao.selectGymInfo(conn, gNo);
			
			if(g != null) {
				commit(conn);
			} else {
				rollback(conn);
			}
		}
		
		close(conn);
		return g;
	}

	public ArrayList<GFile> selectImage(String gNo) {
		Connection conn = getConnection();
		
		ArrayList<GFile> fileList = new GymDAO().selectImage(conn, gNo);
	
		close(conn);
		return fileList;
	}
	

}
