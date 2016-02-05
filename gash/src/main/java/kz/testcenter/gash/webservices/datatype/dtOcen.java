package kz.testcenter.gash.webservices.datatype;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import kz.testcenter.gash.AppContants;

/**
 * Created by user on 17.09.2015.
 */
@XmlAccessorType(XmlAccessType.PROPERTY)
@XmlType(name = "dtOcen", propOrder = {
        "classNo",
        "idListOtv",
        "itogOcen",
        "balls",
        "ocen"
})
public class dtOcen {
    @XmlElement(name = "class_no", required = true)
    public byte getClassNo() {
        return classNo;
    }
    public void setClassNo(byte classNo) {
        this.classNo = classNo;
    }
    private byte classNo;

    @XmlElement(name = "id_listotv", required = true)
    public int getIdListOtv() {
        return idListOtv;
    }
    public void setIdListOtv(int idListOtv) {
        this.idListOtv = idListOtv;
    }
    private int idListOtv;

    @XmlElement(name = "itog_ocen", required = true)
    public byte getItogOcen() {
        return itogOcen;
    }
    public void setItogOcen(byte itogOcen) {
        this.itogOcen = itogOcen;
    }
    private byte itogOcen;

    @XmlElement(name = "balls", required = true)
    public byte[] getBalls() {
        return balls;
    }
    public void setBalls(byte[] balls) {
        this.balls = balls;
    }
    private byte[] balls = new byte[AppContants.MAX_PREDMET_COUNT];

    @XmlElement(name = "ocen", required = true)
    public byte[] getOcen() {
        return ocen;
    }
    public void setOcen(byte[] ocen) {
        this.ocen = ocen;
    }
    private byte[] ocen = new byte[AppContants.MAX_PREDMET_COUNT];

}
