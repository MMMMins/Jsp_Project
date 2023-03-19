package schedule;

import Board.BoardVO;

import java.sql.*;
import java.util.ArrayList;

public class LocationDAO {
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat; // 사용자 값 입력시 처리
    private ResultSet rs;
    private String sqlQuery;

    private final String dbID = "root";
    private final String dbPwd = "test1234";
    private final String dbURL = "jdbc:mysql://localhost:3306/projectDB";

    public LocationDAO(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public int insertLocationTime(LocationVO vo){
        sqlQuery = "INSERT INTO locationTime values(?, ?, ?, ?, ?, ?, ?)";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, vo.getIdx());
            pstat.setString(2, vo.getTitle());
            pstat.setString(3, vo.getFromLoc());
            pstat.setString(4, vo.getToLoc());
            pstat.setString(5, vo.getDistance());
            pstat.setString(6, vo.getTime());
            pstat.setString(7, vo.getWay());
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

    public ArrayList<LocationVO> getView(int idx){
        sqlQuery = "SELECT * FROM locationTime WHERE idx = ?";
        ArrayList<LocationVO> locationList = new ArrayList<>();
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            rs = pstat.executeQuery();
            while(rs.next()) {
                LocationVO lvo = new LocationVO();
                lvo.setIdx(rs.getInt(1));
                lvo.setTitle(rs.getString(2));
                lvo.setFromLoc(rs.getString(3));
                lvo.setToLoc(rs.getString(4));
                lvo.setDistance(rs.getString(5));
                lvo.setTime(rs.getString(6).substring(0,5));
                lvo.setWay(rs.getString(7));
                locationList.add(lvo);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return locationList;
    }
}
