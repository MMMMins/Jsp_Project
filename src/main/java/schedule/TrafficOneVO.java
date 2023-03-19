package schedule;

public class TrafficOneVO {
    private int idx;
    private String title;
    private String way;
    private String wayType;
    private String carType;
    private String name;
    private String departDate;
    private String departTime;
    private int amount;

    public TrafficOneVO(){}

    public TrafficOneVO(int idx, String title, String way, String wayType, String carType, String name, String departDate, String departTime, int amount) {
        this.idx = idx;
        this.title = title;
        this.way = way;
        this.wayType = wayType;
        this.carType = carType;
        this.name = name;
        this.departDate = departDate;
        this.departTime = departTime;
        this.amount = amount;
    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getWay() {
        return way;
    }

    public void setWay(String way) {
        this.way = way;
    }

    public String getWayType() {
        return wayType;
    }

    public void setWayType(String wayType) {
        this.wayType = wayType;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartDate() {
        return departDate;
    }

    public void setDepartDate(String departDate) {
        this.departDate = departDate;
    }

    public String getDepartTime() {
        return departTime;
    }

    public void setDepartTime(String departTime) {
        this.departTime = departTime;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}
