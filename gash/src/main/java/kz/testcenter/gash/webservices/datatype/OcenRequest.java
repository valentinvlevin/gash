package kz.testcenter.gash.webservices.datatype;

import javax.xml.bind.annotation.*;
import java.util.Date;
import java.util.List;

@XmlAccessorType(XmlAccessType.PROPERTY)
@XmlType(name = "dtAnswerFile", propOrder = {
        "idVpt",
        "armSign",
        "fileNum",
        "createDateTime",
        "testList",
        "schoolList",
        "listOtvList"
})
public class OcenRequest {
    @XmlElement(name = "id_vpt", required = true)
    public short getIdVpt() {
        return idVpt;
    }
    public void setIdVpt(short idVpt) {
        this.idVpt = idVpt;
    }
    private short idVpt;

    @XmlElement(name = "arm_sign", required = true)
    public int getArmSign() {
        return armSign;
    }
    public void setArmSign(int armSign) {
        this.armSign = armSign;
    }
    private int armSign;

    @XmlElement(name = "file_num", required = true)
    public short getFileNum() {
        return fileNum;
    }
    public void setFileNum(short fileNum) {
        this.fileNum = fileNum;
    }
    private short fileNum;

    @XmlElement(name = "create_date_time", required = false)
    public Date getCreateDateTime() {
        return createDateTime;
    }
    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }
    private Date createDateTime;

    @XmlElement(name = "tests", required = false)
    public List<dtTest> getTestList() {
        return TestList;
    }
    public void setTestList(List<dtTest> testList) {
        this.TestList = testList;
    }
    private List<dtTest> TestList;

    @XmlElement(name = "schools", required = false)
    public List<dtSchool> getSchoolList() {
        return schoolList;
    }
    public void setSchoolList(List<dtSchool> schoolList) {
        this.schoolList = schoolList;
    }
    private List<dtSchool> schoolList;

    @XmlElement(name = "listotv", required = false)
    public List<dtListOtv> getListOtvList() {
        return listOtvList;
    }
    public void setListOtvList(List<dtListOtv> listOtvList) {
        this.listOtvList = listOtvList;
    }
    private List<dtListOtv> listOtvList;
}
