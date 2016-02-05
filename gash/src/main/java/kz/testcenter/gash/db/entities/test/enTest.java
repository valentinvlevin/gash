package kz.testcenter.gash.db.entities.test;

import javax.persistence.*;

/**
 * Created by user on 14.09.2015.
 */
@Entity
@Table(name = "tests", schema = "public")
@IdClass(value = enTestId.class)
public class enTest {
    @Id
    @Column(name = "id_file")
    public int getIdFile() {
        return idFile;
    }
    public void setIdFile(int idFile) {
        this.idFile = idFile;
    }
    private int idFile;

    @Id
    @Column(name = "id_test")
    public int getIdTest() {
        return idTest;
    }
    public void setIdTest(int idTest) {
        this.idTest = idTest;
    }
    private int idTest;

    @Column(name = "scan_date")
    public int getScanDate() {
        return scanDate;
    }
    public void setScanDate(int scanDate) {
        this.scanDate = scanDate;
    }
    private int scanDate;

    @Column(name = "gid_uchzav")
    public int getGidUchZav() {
        return gidUchZav;
    }

    public void setGidUchZav(int gidUchZav) {
        this.gidUchZav = gidUchZav;
    }
    private int gidUchZav;

    @Column(name = "id_testtype")
    public short getIdTestType() {
        return idTestType;
    }
    public void setIdTestType(short idTestType) {
        this.idTestType = idTestType;
    }
    private short idTestType;

    public enTest() {

    }
}
