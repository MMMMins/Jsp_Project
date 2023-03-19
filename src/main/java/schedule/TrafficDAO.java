package schedule;

import java.sql.*;

public class TrafficDAO {
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat; // 사용자 값 입력시 처리
    private ResultSet rs;
    private String sqlQuery;

    private final String dbID = "root";
    private final String dbPwd = "test1234";
    private final String dbURL = "jdbc:mysql://localhost:3306/projectDB";

    public TrafficDAO(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public int insertOneWay(TrafficOneVO vo){
        sqlQuery = "INSERT INTO traffic_one values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, vo.getIdx());
            pstat.setString(2, vo.getTitle());
            pstat.setString(3, vo.getWay());
            pstat.setString(4, vo.getWayType());
            pstat.setString(5, vo.getCarType());
            pstat.setString(6, vo.getName());
            pstat.setString(7, vo.getDepartDate());
            pstat.setString(8, vo.getDepartTime());
            pstat.setInt(9, vo.getAmount());
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }
    public int insertTwoWay(TrafficTwoVO vo){
        sqlQuery = "INSERT INTO traffic_two values(?, ?, ?, ?, ?, ?, ?, ?)";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, vo.getIdx());
            pstat.setString(2, vo.getTitle());
            pstat.setString(3, vo.getWay());
            pstat.setString(4, vo.getCarType());
            pstat.setString(5, vo.getName());
            pstat.setString(6, vo.getArrivalDate());
            pstat.setString(7, vo.getReturnTime());
            pstat.setInt(8, vo.getAmount());
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

    public TrafficOneVO oneWayView(int idx){
        sqlQuery = "SELECT * FROM traffic_one WHERE idx = ?";
        TrafficOneVO tOvo = new TrafficOneVO();
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            rs = pstat.executeQuery();
            if(rs.next()){
                String way;
                switch (rs.getString(3)){
                    case "ship":
                        way = "배";
                        break;
                    case "car":
                        way = "차량";
                        break;
                    case "bus":
                        way = "버스";
                        break;
                    case "train":
                        way = "기차";
                        break;
                    case "air":
                        way = "비행기";
                        break;
                    default:
                        way = "에러";
                }
                tOvo.setIdx(rs.getInt(1));
                tOvo.setTitle(rs.getString(2));
                tOvo.setWay(way);
                tOvo.setWayType(rs.getString(4).equals("two")?"왕복":"편도");
                tOvo.setCarType(rs.getString(5));
                tOvo.setName(rs.getString(6));
                tOvo.setDepartDate(rs.getString(7));
                tOvo.setDepartTime(rs.getString(8));
                tOvo.setAmount(rs.getInt(9));
            }
            return tOvo;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public TrafficTwoVO twoWayView(int idx){
        sqlQuery = "SELECT * FROM traffic_two WHERE idx = ?";
        TrafficTwoVO tTvo = new TrafficTwoVO();
            try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            rs = pstat.executeQuery();
            if(rs.next()){
                String way;
                switch (rs.getString(3)){
                    case "ship":
                        way = "배";
                        break;
                    case "car":
                        way = "차량";
                        break;
                    case "bus":
                        way = "버스";
                        break;
                    case "train":
                        way = "기차";
                        break;
                    case "air":
                        way = "비행기";
                        break;
                    default:
                        way = "에러";
                }
                tTvo.setIdx(rs.getInt(1));
                tTvo.setTitle(rs.getString(2));
                tTvo.setWay(way);
                tTvo.setCarType(rs.getString(4));
                tTvo.setName(rs.getString(5));
                tTvo.setArrivalDate(rs.getString(6));
                tTvo.setReturnTime(rs.getString(7));
                tTvo.setAmount(rs.getInt(8));
            }
            return tTvo;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
