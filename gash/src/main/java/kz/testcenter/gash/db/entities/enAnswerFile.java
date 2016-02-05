package kz.testcenter.gash.db.entities;

import kz.testcenter.gash.db.entities.test.enTest;
import kz.testcenter.gash.db.entities.uchzav.enUchZav;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "answer_files", schema = "public")
public class enAnswerFile {
    @Id
    @Column(name = "id_file")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getId(){
        return this.id;
    }
    public void setId(int id) {
        this.id = id;
    }
    private int id;

    @Column(name = "id_vpt")
    public short getIdVpt(){
        return this.idVpt;
    }
    public void setIdVpt(short idVpt) {
        this.idVpt = idVpt;
    }
    private short idVpt;

    @Column(name = "arm_sign")
    public int getArmSign() {
        return this.armSign;
    }
    public void setArmSign(int armSign) {
        this.armSign = armSign;
    }
    private int armSign;

    @Column(name = "num")
    public short getNum() {
        return this.num;
    }
    public void setNum(short num) {
        this.num = num;
    }
    private short num;

    @Column(name = "id_season")
    public short getIdSeason() {
        return this.idSeason;
    }
    public void setIdSeason(short idSeason) {
        this.idSeason = idSeason;
    }
    private short idSeason;

    @Column(name = "import_date_time")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getImportDateTime() {
        return this.importDateTime;
    }
    public void setImportDateTime(Date importDateTime) {
        this.importDateTime = importDateTime;
    }
    private Date importDateTime;

    @Column(name = "create_date_time")
    public Date getCreateDateTime() {
        return this.createDateTime;
    }
    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }
    private Date createDateTime;

    @Column(name = "answer_file_name")
    public String getAnswerFileName() {
        return this.answerFileName;
    }
    public void setAnswerFileName(String answerFileName) {
        this.answerFileName = answerFileName;
    }
    private String answerFileName;

    @Column(name = "result_file_name")
    public String getResultFileName() {
        return this.resultFileName;
    }
    public void setResultFileName(String resultFileName) {
        this.resultFileName = resultFileName;
    }
    private String resultFileName;

    @Column(name = "data_hash")
    public String getDataHash() {
        return this.dataHash;
    }
    public void setDataHash(String dataHash) {
        this.dataHash = dataHash;
    }
    private String dataHash;

    @Column(name = "rand_id")
    public int getRandId() {
        return this.randId;
    }
    public void setRandId(int randId) {
        this.randId = randId;
    }
    private int randId;

    @OneToMany
    @JoinColumn(name = "id_file")
    public List<enListOtv> getListOtvEnList() {
        return listOtvEnList;
    }
    public void setListOtvEnList(List<enListOtv> listOtvEnList) {
        this.listOtvEnList = listOtvEnList;
    }
    private List<enListOtv> listOtvEnList;

    @OneToMany
    @JoinColumn(name = "id_file")
    public List<enTest> getEnTestList() {
        return this.enTestList;
    }
    public void setEnTestList(List<enTest> enTestList) {
        this.enTestList = enTestList;
    }
    private List<enTest> enTestList;

    @OneToMany
    @JoinColumn(name = "id_file")
    public List<enUchZav> getUchZavList() {
        return this.uchZavList;
    }
    public void setUchZavList(List<enUchZav> uchZavList) {
        this.uchZavList = uchZavList;
    }
    private List<enUchZav> uchZavList;

    public enAnswerFile(){

    }
}
