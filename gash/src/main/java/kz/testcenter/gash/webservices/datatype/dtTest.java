package kz.testcenter.gash.webservices.datatype;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * Created by user on 16.09.2015.
 */
@XmlAccessorType(XmlAccessType.PROPERTY)
@XmlType(name = "dtTest", propOrder = {
        "idTest",
        "gidUchZav",
        "scanDate",
        "idTestType"
})
public class dtTest {
    @XmlElement(name = "id_test", required = true)
    public int getIdTest() {
        return idTest;
    }
    public void setIdTest(int idTest) {
        this.idTest = idTest;
    }
    private int idTest;

    @XmlElement(name = "gid_uchzav", required = true)
    public int getGidUchZav() {
        return gidUchZav;
    }
    public void setGidUchZav(int gidUchZav) {
        this.gidUchZav = gidUchZav;
    }
    private int gidUchZav;

    @XmlElement(name = "scan_date", required = true)
    public int getScanDate() {
        return scanDate;
    }
    public void setScanDate(int scanDate) {
        this.scanDate = scanDate;
    }
    private int scanDate;

    @XmlElement(name = "id_test_type", required = true)
    public short getIdTestType() {
        return idTestType;
    }
    public void setIdTestType(short idTestType) {
        this.idTestType = idTestType;
    }
    private short idTestType;
}