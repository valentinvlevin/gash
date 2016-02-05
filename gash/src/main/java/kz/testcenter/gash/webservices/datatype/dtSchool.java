package kz.testcenter.gash.webservices.datatype;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * Created by user on 16.09.2015.
 */
@XmlAccessorType(XmlAccessType.PROPERTY)
@XmlType(name = "dtSchool", propOrder = {
        "id",
        "schoolKaz",
        "schoolRus"
})
public class dtSchool {
    @XmlElement(name = "id", required = true)
    public int getId() {
        return id;
    }
    public void setIdv(int id) {
        this.id = id;
    }
    private int id;

    @XmlElement(name = "school_kaz", required = true)
    public String getSchoolKaz() {
        return schoolKaz;
    }
    public void setUchZavKaz(String schoolKaz) {
        this.schoolKaz = schoolKaz;
    }
    private String schoolKaz;

    @XmlElement(name = "school_rus", required = true)
    public String getSchoolRus() {
        return schoolRus;
    }
    public void setSchoolRus(String schoolRus) {
        this.schoolRus = schoolRus;
    }
    private String schoolRus;
}
