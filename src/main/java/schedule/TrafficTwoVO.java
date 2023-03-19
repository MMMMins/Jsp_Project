package schedule;

public class TrafficTwoVO {
    private int idx;
    private String title;
    private String way;
    private String carType;
    private String name;
    private String arrivalDate;
    private String returnTime;
    private int amount;

    public TrafficTwoVO(){}
    public TrafficTwoVO(int idx, String title, String way, String carType, String name, String arrivalDate, String returnTime, int amount) {
        this.idx = idx;
        this.title = title;
        this.way = way;
        this.carType = carType;
        this.name = name;
        this.arrivalDate = arrivalDate;
        this.returnTime = returnTime;
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

    public String getArrivalDate() {
        return arrivalDate;
    }

    public void setArrivalDate(String arrivalDate) {
        this.arrivalDate = arrivalDate;
    }

    public String getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(String returnTime) {
        this.returnTime = returnTime;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}
