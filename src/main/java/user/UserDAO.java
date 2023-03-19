package user;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class UserDAO {
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat; // 사용자 값 입력시 처리
    private ResultSet rs;
    private String sqlQuery;
    private final String dbID = "root";
    private final String dbPwd = "test1234";
    private final String dbURL = "jdbc:mysql://localhost:3306/projectDB";


    public UserDAO(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
            stat = conn.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public Map<String, String> selectUserAllData(UserVO vo){
        sqlQuery = "SELECT * FROM userlist WHERE user_id = ?";
        Map<String, String> userData = new HashMap<>();
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getId());
            rs = pstat.executeQuery();
            while(rs.next()){
                userData.put("id", rs.getString("user_id"));
                userData.put("pwd",rs.getString("user_pwd"));
                userData.put("name",rs.getString("user_name"));
                userData.put("gender",rs.getString("user_gender"));
                userData.put("email",rs.getString("user_email"));
                userData.put("zipCode",rs.getString("user_Zipcode"));
                userData.put("roadAddr",rs.getString("user_RoadAddr"));
                userData.put("detailAddr",rs.getString("user_DetailAddr"));
            }
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
        return userData;
    }

    //로그인
    public boolean selectUserResult(UserVO vo) {
        sqlQuery = "SELECT user_id, user_pwd FROM userlist WHERE user_id=? and user_pwd= sha2(?, 512)";
        try {
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getId());
            pstat.setString(2, vo.getPassword());
            rs = pstat.executeQuery();
            return rs.next();
        } catch (Exception e) {
            return false;
        }
    }

    //아이디중복체크
    public boolean selectUserIdCheck(UserVO vo){
        sqlQuery = "SELECT user_id FROM userlist WHERE user_id=?";
        try {
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getId());
            rs = pstat.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //아이디찾기
    public ArrayList<String> selectUserIdFind(UserVO vo){
        sqlQuery = "SELECT user_id FROM userlist WHERE user_email = ?";
        ArrayList<String> result = new ArrayList<>();
        int rowCount,i=0;
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getEmail());
            rs = pstat.executeQuery();
            while(rs.next()){
                result.add(rs.getString("user_id"));}
            return result;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    //비밀번호찾기
    public boolean selectUserPwdFind(UserVO vo){
        sqlQuery = "SELECT user_id, user_email, user_name FROM userlist";
        sqlQuery += " WHERE user_id = ? and user_email = ? and user_name = ?";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getId());
            pstat.setString(2, vo.getEmail());
            pstat.setString(3, vo.getName());
            rs = pstat.executeQuery();
            return rs.next();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    //비밀번호변경
    public boolean updateUserPwd(UserVO vo){
        sqlQuery = "UPDATE userlist SET user_pwd = ? WHERE user_id = ?";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getPassword());
            pstat.setString(2, vo.getId());
            return pstat.executeUpdate() > 0;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    //회원가입
    public boolean insertUser(UserVO vo){
        sqlQuery = "INSERT INTO userlist VALUES(?,sha2(?,512),?,?,?,?,?,?)";
        try{
            int result = 0;
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getId());
            pstat.setString(2, vo.getPassword());
            pstat.setString(3, vo.getName());
            pstat.setString(4, vo.getGender());
            pstat.setString(5, vo.getEmail());
            pstat.setString(6, vo.getZipCode());
            pstat.setString(7, vo.getRoadAddr());
            if(vo.getDetailAddr() != null) pstat.setString(8, vo.getDetailAddr());
            else pstat.setString(8, null);
            result = pstat.executeUpdate();
            return result > 0;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public int updateUser(UserVO vo){
        sqlQuery = "UPDATE userlist SET user_pwd = sha2(?,512), user_name = ?, user_gender = ?, user_email = ?, user_Zipcode = ?, user_RoadAddr = ?, user_DetailAddr = ?" +
                "WHERE user_id = ?";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setString(1, vo.getPassword());
            pstat.setString(2, vo.getName());
            pstat.setString(3, vo.getGender());
            pstat.setString(4, vo.getEmail());
            pstat.setString(5, vo.getZipCode());
            pstat.setString(6, vo.getRoadAddr());
            if(vo.getDetailAddr() != null)
                pstat.setString(7, vo.getDetailAddr());
            else pstat.setString(7, null);
            pstat.setString(8, vo.getId());
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public void dbClose(){
        try{
            if(rs != null) rs.close();
            if(pstat != null) pstat.close();
            if(stat != null) stat.close();
            if(conn != null) conn.close();
        }catch (Exception e){

        }
    }
}
