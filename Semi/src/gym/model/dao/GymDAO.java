package gym.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import gym.model.vo.Gym;

public class GymDAO {
	
	private Properties prop = new Properties();
	public GymDAO() {
		String filename = GymDAO.class.getResource("/sql/gym/gym-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filename));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	public ArrayList<Gym> selectGymList(Connection conn) {

		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<Gym> list = new ArrayList<Gym>();
		
		String query = prop.getProperty("selectGymList");

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			while(rset.next()) {
				Gym g = new Gym(rset.getInt("g_NO"),
							rset.getString("g_TYPE_NM"),
							rset.getString("g_GU_NM"),
							rset.getString("g_NAME"),
							rset.getString("g_ADDRESS"),
							rset.getDouble("g_YCODE"),
							rset.getDouble("g_XCODE"));
				list.add(g);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}
	
	public ArrayList<Gym> searchGym(Connection conn, String gName) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Gym> list = new ArrayList<Gym>();
		
		String query = prop.getProperty("searchGym");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, gName);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Gym g = new Gym();
				g.setG_NO(rset.getInt("g_No"));
				g.setG_TYPE_NM(rset.getString("g_type_nm"));
				g.setG_GU_NM(rset.getString("g_gu_nm"));
				g.setG_NAME(rset.getString("g_name"));
				g.setG_ADDRESS(rset.getString("g_address"));
				g.setG_YCODE(rset.getDouble("g_ycode"));
				g.setG_XCODE(rset.getDouble("g_xcode"));
				g.setG_TEL(rset.getString("g_tel"));
				g.setG_EDU_YN(rset.getString("g_edu_yn"));
				g.setG_IN_OUT(rset.getString("g_in_out"));
				
				list.add(g);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return list;
	}
	
}
