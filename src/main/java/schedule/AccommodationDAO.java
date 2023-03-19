package schedule;

import java.sql.*;
import java.util.ArrayList;

public class AccommodationDAO {
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat; // 사용자 값 입력시 처리
    private ResultSet rs;
    private String sqlQuery;

    private final String dbID = "root";
    private final String dbPwd = "test1234";
    private final String dbURL = "jdbc:mysql://localhost:3306/projectDB";

    public AccommodationDAO(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public int insertAcc(AccommodationVO vo){
        sqlQuery = "INSERT INTO accommodation VALUES(?,?,?,?,?,?,?)";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, vo.getIdx());
            pstat.setString(2, vo.getTitle());
            pstat.setString(3, vo.getName());
            pstat.setString(4, vo.getCheckIn());
            pstat.setString(5, vo.getCheckOut());
            pstat.setString(6, vo.getDay());
            pstat.setInt(7, vo.getAmount());
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<AccommodationVO> AccommView(int idx){
        sqlQuery = "SELECT * FROM accommodation WHERE idx = ?";
        ArrayList<AccommodationVO> list = new ArrayList<>();
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            rs = pstat.executeQuery();
            while(rs.next()){
                AccommodationVO vo = new AccommodationVO();
                vo.setIdx(rs.getInt(1));
                vo.setTitle(rs.getString(2));
                vo.setName(rs.getString(3));
                vo.setCheckIn(rs.getString(4));
                vo.setCheckOut(rs.getString(5));
                vo.setDay(rs.getString(6));
                vo.setAmount(rs.getInt(7));
                list.add(vo);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
}
