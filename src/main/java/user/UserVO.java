package user;

public class UserVO {
    private String id;          //아이디
    private String password;    //패스워드
    private String name;        //이름
    private String gender;      //성별
    private String email;       //이메일
    private String zipCode;        //우편번호
    private String roadAddr;    //도로명
    private String detailAddr = null;  //상세주소

    public UserVO(){};
    public UserVO(String id, String password, String name, String gender, String email, String zipCode, String roadAddr){
        this.id = id;
        this.password = password;
        this.name = name;
        this.gender = gender;
        this.email = email;
        this.zipCode = zipCode;
        this.roadAddr = roadAddr;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String pwd) {
        this.password = pwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getRoadAddr() {
        return roadAddr;
    }

    public void setRoadAddr(String roadAddr) {
        this.roadAddr = roadAddr;
    }

    public String getDetailAddr() {
        return detailAddr;
    }

    public void setDetailAddr(String detailAddr) {
        this.detailAddr = detailAddr;
    }

}
