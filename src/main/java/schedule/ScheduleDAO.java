package schedule;

import java.sql.*;

public class ScheduleDAO {
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat; // 사용자 값 입력시 처리
    private ResultSet rs;
    private String sqlQuery;

    private final String dbID = "root";
    private final String dbPwd = "test1234";
    private final String dbURL = "jdbc:mysql://localhost:3306/projectDB";

    public ScheduleDAO(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public int choiceIdx(){
        sqlQuery = "SELECT ifnull(max(idx)+1,1) idx FROM schedule";
        int maxValue=-1;
        try{
            stat = conn.createStatement();
            rs = stat.executeQuery(sqlQuery);
            if(rs.next()){
                maxValue = rs.getInt("idx");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return maxValue;
    }

    public int insertSchedule(ScheduleVO vo){
        sqlQuery = "INSERT INTO schedule values(?, ?, ?, ?, ?, 0)";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, vo.getIdx());
            pstat.setString(2, vo.getId());
            pstat.setString(3, vo.getTitle());
            pstat.setString(4, vo.getStartdate());
            pstat.setString(5, vo.getEnddate());
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
            return -1;

        }
    }

    public ScheduleVO getView(int idx){
        sqlQuery = "SELECT * FROM schedule WHERE idx = ?";
        ScheduleVO svo = new ScheduleVO();
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            rs = pstat.executeQuery();
            if(rs.next()){
                svo.setIdx(rs.getInt(1));
                svo.setId(rs.getString(2));
                svo.setTitle(rs.getString(3));
                svo.setStartdate(rs.getString(4));
                svo.setEnddate(rs.getString(5));
                svo.setAmount(rs.getInt(6));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return svo;
    }

//    public int updateScheduleAmount(ScheduleVO vo){
//
//    }
}
